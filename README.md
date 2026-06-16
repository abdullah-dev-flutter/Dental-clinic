# Dental Clinic Appointment App

A professional dental clinic mobile application designed to simplify the process of booking dental appointments. This app allows users to browse services, view doctors, book appointments, and manage their profile.

## 🚀 App Flow

1.  **Onboarding:** Users are greeted with a set of onboarding screens introducing the clinic's services and features.
2.  **Authentication:**
    *   New users can register by creating an account.
    *   Existing users can log in using their credentials.
    *   Features password recovery (Forgot Password -> OTP Verification -> Reset Password).
3.  **Home Screen:** The central hub displaying:
    *   Personalized greeting.
    *   Upcoming appointments.
    *   Available dental services.
    *   Nearby clinic information.
4.  **Doctor Discovery:** Users can browse doctors, filter by specialty (General, Cosmetic, Orthodontist), and search for specific doctors or services.
5.  **Booking Process:**
    *   Select a service.
    *   Choose a doctor.
    *   Pick a preferred date and time.
    *   Select payment method.
    *   Confirm the appointment.
6.  **Profile Management:** Users can view personal details, check appointment history, manage payment methods, and access support.

## 🛠️ Key Parameters & Data Models

The app relies on the following key data models:

*   **Doctor:** Represents the dental professionals.
    *   `id`: Unique identifier.
    *   `name`, `specialty`, `avatarUrl`.
    *   `rating`, `reviewCount`, `isOnline`.
    *   `availableDays`, `startTime`, `endTime`.
    *   `services`: List of service IDs provided by the doctor.
*   **DentalService:** Defines available treatments.
    *   `id`, `name`, `description`, `price`, `durationMinutes`, `iconAsset`.
*   **Appointment:** Manages booking records.
    *   `id`, `doctor` (Object), `service` (Object), `dateTime`.
    *   `status` (upcoming, archived, completed).
*   **Clinic:** Clinic location data.
    *   `id`, `name`, `address`, `distanceKm`, `isOpen`, `closingTime`.

## 🏗️ Architecture

The app follows a clean architecture pattern with Riverpod for state management:

-   **Domain/Providers:** Manages the state of the app (e.g., `appointmentProvider`, `doctorListProvider`, `authProvider`).
-   **Data/Repositories:** Interface layer for data fetching, currently using `MockDatasource` for static data management.
-   **Presentation:** Screen and widget layer (e.g., `HomeScreen`, `DoctorCard`).

## 💻 Tech Stack
- **Flutter:** UI Framework.
- **Riverpod:** State management.
- **GoRouter:** Navigation and routing.
- **Freezed:** Data modeling and immutability.
- **CachedNetworkImage:** Efficient image loading.
