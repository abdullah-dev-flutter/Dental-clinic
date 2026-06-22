-- ============================================================
-- CLINICS TABLE & RPC FUNCTIONS
-- Migration: add_clinics_support
-- ============================================================

-- 1. Clinics table
CREATE TABLE IF NOT EXISTS clinics (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  address TEXT NOT NULL,
  lat DECIMAL(10, 7) NOT NULL,
  lng DECIMAL(10, 7) NOT NULL,
  added_by_doctor_id UUID REFERENCES doctors(id) ON DELETE SET NULL,
  is_verified BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Index for fast spatial lookups
CREATE INDEX IF NOT EXISTS idx_clinics_lat_lng ON clinics (lat, lng);

-- 3. Update doctors table
ALTER TABLE IF EXISTS doctors
  ADD COLUMN IF NOT EXISTS clinic_id UUID REFERENCES clinics(id) ON DELETE SET NULL,
  ADD COLUMN IF NOT EXISTS is_new_clinic BOOLEAN DEFAULT FALSE;

-- 4. RPC: Get nearby clinics for doctor map
CREATE OR REPLACE FUNCTION get_nearby_clinics(
  user_lat DECIMAL,
  user_lng DECIMAL,
  radius_km INTEGER DEFAULT 10
)
RETURNS TABLE (
  id UUID,
  name TEXT,
  address TEXT,
  lat DECIMAL,
  lng DECIMAL,
  distance_km DECIMAL,
  total_doctors INTEGER,
  avg_rating DECIMAL,
  min_fee DECIMAL,
  is_verified BOOLEAN
)
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY
  SELECT
    c.id,
    c.name,
    c.address,
    c.lat,
    c.lng,
    ROUND(CAST(
      6371 * acos(
        cos(radians(user_lat)) *
        cos(radians(c.lat)) *
        cos(radians(c.lng) - radians(user_lng)) +
        sin(radians(user_lat)) *
        sin(radians(c.lat))
      )
    AS DECIMAL), 2) AS distance_km,
    COUNT(DISTINCT d.id)::INTEGER AS total_doctors,
    ROUND(AVG(d.rating)::DECIMAL, 1) AS avg_rating,
    COALESCE(MIN(d.consultation_fee), 0) AS min_fee,
    c.is_verified
  FROM clinics c
  LEFT JOIN doctors d ON d.clinic_id = c.id AND d.status = 'approved'
  WHERE
    6371 * acos(
      cos(radians(user_lat)) *
      cos(radians(c.lat)) *
      cos(radians(c.lng) - radians(user_lng)) +
      sin(radians(user_lat)) *
      sin(radians(c.lat))
    ) <= radius_km
  GROUP BY c.id, c.name, c.address, c.lat, c.lng, c.is_verified
  ORDER BY distance_km;
END;
$$;

-- 5. RPC: Get clinics near patient
CREATE OR REPLACE FUNCTION get_clinics_near_patient(
  patient_lat DECIMAL,
  patient_lng DECIMAL,
  radius_km INTEGER DEFAULT 5
)
RETURNS TABLE (
  clinic_id UUID,
  clinic_name TEXT,
  clinic_address TEXT,
  lat DECIMAL,
  lng DECIMAL,
  distance_km DECIMAL,
  total_doctors INTEGER,
  avg_rating DECIMAL,
  min_fee DECIMAL
)
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY
  SELECT
    c.id,
    c.name,
    c.address,
    c.lat,
    c.lng,
    ROUND(CAST(
      6371 * acos(
        cos(radians(patient_lat)) *
        cos(radians(c.lat)) *
        cos(radians(c.lng) - radians(patient_lng)) +
        sin(radians(patient_lat)) *
        sin(radians(c.lat))
      )
    AS DECIMAL), 2),
    COUNT(DISTINCT d.id)::INTEGER,
    COALESCE(ROUND(AVG(d.rating)::DECIMAL, 1), 0),
    COALESCE(MIN(d.consultation_fee), 0)
  FROM clinics c
  LEFT JOIN doctors d ON d.clinic_id = c.id AND d.status = 'approved'
  WHERE
    6371 * acos(
      cos(radians(patient_lat)) *
      cos(radians(c.lat)) *
      cos(radians(c.lng) - radians(patient_lng)) +
      sin(radians(patient_lat)) *
      sin(radians(c.lat))
    ) <= radius_km
  GROUP BY c.id, c.name, c.address, c.lat, c.lng
  ORDER BY distance_km;
END;
$$;

-- 6. RPC: Register doctor clinic (existing or new)
CREATE OR REPLACE FUNCTION register_doctor_clinic(
  p_doctor_id UUID,
  p_clinic_name TEXT,
  p_clinic_address TEXT,
  p_lat DECIMAL,
  p_lng DECIMAL,
  p_existing_clinic_id UUID DEFAULT NULL
)
RETURNS UUID
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_clinic_id UUID;
BEGIN
  IF p_existing_clinic_id IS NOT NULL THEN
    v_clinic_id := p_existing_clinic_id;
    UPDATE doctors
    SET clinic_id = v_clinic_id,
        is_new_clinic = FALSE,
        updated_at = NOW()
    WHERE id = p_doctor_id;
  ELSE
    INSERT INTO clinics (name, address, lat, lng, added_by_doctor_id)
    VALUES (p_clinic_name, p_clinic_address, p_lat, p_lng, p_doctor_id)
    RETURNING id INTO v_clinic_id;

    UPDATE doctors
    SET clinic_id = v_clinic_id,
        is_new_clinic = TRUE,
        updated_at = NOW()
    WHERE id = p_doctor_id;
  END IF;

  RETURN v_clinic_id;
END;
$$;

-- 7. RPC: Weekly appointment stats for analytics
CREATE OR REPLACE FUNCTION get_weekly_appointments(p_doctor_id UUID)
RETURNS TABLE(day TEXT, count INTEGER)
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY
  SELECT
    TO_CHAR(appointment_date, 'Dy') AS day,
    COUNT(*)::INTEGER
  FROM appointments
  WHERE doctor_id = p_doctor_id
    AND appointment_date >= CURRENT_DATE - INTERVAL '7 days'
  GROUP BY appointment_date, TO_CHAR(appointment_date, 'Dy')
  ORDER BY appointment_date;
END;
$$;

-- 8. RPC: Monthly earnings for analytics
CREATE OR REPLACE FUNCTION get_monthly_earnings(p_doctor_id UUID)
RETURNS TABLE(month TEXT, amount DECIMAL)
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY
  SELECT
    TO_CHAR(paid_at, 'Mon YYYY') AS month,
    SUM(doctor_earning)
  FROM payments
  WHERE doctor_id = p_doctor_id
    AND status = 'completed'
    AND paid_at >= NOW() - INTERVAL '6 months'
  GROUP BY TO_CHAR(paid_at, 'Mon YYYY'), DATE_TRUNC('month', paid_at)
  ORDER BY DATE_TRUNC('month', paid_at);
END;
$$;

-- 9. RPC: Get doctor patients list
CREATE OR REPLACE FUNCTION get_doctor_patients(p_doctor_id UUID)
RETURNS TABLE(
  patient_id UUID,
  full_name TEXT,
  profile_image_url TEXT,
  phone TEXT,
  total_visits INTEGER,
  last_visit DATE,
  total_paid DECIMAL
)
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY
  SELECT
    p.user_id,
    p.full_name,
    p.profile_image_url,
    p.phone,
    COUNT(a.id)::INTEGER,
    MAX(a.appointment_date),
    COALESCE(SUM(py.amount), 0)
  FROM appointments a
  JOIN profiles p ON p.user_id = a.patient_id
  LEFT JOIN payments py ON py.appointment_id = a.id AND py.status = 'completed'
  WHERE a.doctor_id = p_doctor_id
    AND a.status = 'completed'
  GROUP BY p.user_id, p.full_name, p.profile_image_url, p.phone
  ORDER BY last_visit DESC;
END;
$$;

-- 10. RPC: Today's stats for dashboard
CREATE OR REPLACE FUNCTION get_today_stats(p_doctor_id UUID)
RETURNS TABLE(
  total_appointments INTEGER,
  pending_appointments INTEGER,
  completed_appointments INTEGER,
  today_earnings DECIMAL
)
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY
  SELECT
    COUNT(*)::INTEGER AS total_appointments,
    COUNT(*) FILTER (WHERE status = 'pending')::INTEGER AS pending_appointments,
    COUNT(*) FILTER (WHERE status = 'completed')::INTEGER AS completed_appointments,
    COALESCE(SUM(py.doctor_earning), 0) AS today_earnings
  FROM appointments a
  LEFT JOIN payments py
    ON py.appointment_id = a.id
    AND py.status = 'completed'
  WHERE a.doctor_id = p_doctor_id
    AND a.appointment_date = CURRENT_DATE;
END;
$$;
