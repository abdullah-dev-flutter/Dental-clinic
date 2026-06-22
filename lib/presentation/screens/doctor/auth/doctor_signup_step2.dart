import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/validators.dart';
import '../../../../data/models/clinic_location_model.dart';
import '../../../widgets/common/app_button.dart';
import '../../../widgets/common/app_text_field.dart';

class DoctorSignupStep2 extends ConsumerStatefulWidget {
  const DoctorSignupStep2({super.key});

  @override
  ConsumerState<DoctorSignupStep2> createState() => _DoctorSignupStep2State();
}

class _DoctorSignupStep2State extends ConsumerState<DoctorSignupStep2> {
  final _formKey = GlobalKey<FormState>();
  final _pmdcCtrl = TextEditingController();
  final _experienceCtrl = TextEditingController();
  final _feeCtrl = TextEditingController();

  ClinicLocationModel? _selectedClinic;
  String? _specialization;

  final List<String> _specializations = [
    'General Dentist',
    'Orthodontist',
    'Periodontist',
    'Endodontist',
    'Oral Surgeon',
    'Pediatric Dentist',
    'Prosthodontist',
  ];

  @override
  void dispose() {
    _pmdcCtrl.dispose();
    _experienceCtrl.dispose();
    _feeCtrl.dispose();
    super.dispose();
  }

  Future<void> _openMapPicker() async {
    final result = await context.push<ClinicLocationModel>(
      '/doctor/signup/location-picker',
    );
    if (result == null) return;
    setState(() => _selectedClinic = result);
  }

  void _handleNext() {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedClinic == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select your clinic location from map'),
          backgroundColor: AppColors.errorRed,
        ),
      );
      return;
    }

    context.push('/doctor/signup/step3', extra: {
      'pmdc': _pmdcCtrl.text.trim(),
      'specialization': _specialization,
      'experience': int.tryParse(_experienceCtrl.text.trim()),
      'fee': double.tryParse(_feeCtrl.text.trim()),
      ..._selectedClinic!.toJson(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Professional Info'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LinearProgressIndicator(
                value: 0.66,
                backgroundColor: AppColors.surfaceVariant,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentGreen),
              ),
              const SizedBox(height: 32),
              Text('Professional Details', style: AppTextStyles.headingMd),
              const SizedBox(height: 24),
              AppTextField(
                hint: 'PMDC License Number',
                controller: _pmdcCtrl,
                validator: (v) => Validators.required(v, 'PMDC Number'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _specialization,
                decoration: InputDecoration(
                  hintText: 'Specialization',
                  hintStyle: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary),
                  filled: true,
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                ),
                dropdownColor: AppColors.surface,
                items: _specializations
                    .map((s) => DropdownMenuItem(
                          value: s,
                          child: Text(s, style: AppTextStyles.bodyMd.copyWith(color: AppColors.textPrimary)),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => _specialization = v),
                validator: (v) => v == null ? 'Please select a specialization' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      hint: 'Years of Experience',
                      controller: _experienceCtrl,
                      keyboardType: TextInputType.number,
                      validator: (v) => Validators.required(v, 'Experience'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppTextField(
                      hint: 'Consultation Fee (PKR)',
                      controller: _feeCtrl,
                      keyboardType: TextInputType.number,
                      validator: (v) => Validators.required(v, 'Fee'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text('Clinic Location', style: AppTextStyles.headingMd),
              const SizedBox(height: 16),
              _buildLocationPicker(),
              const SizedBox(height: 48),
              AppButton(label: 'Next', onPressed: _handleNext),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationPicker() {
    final hasLocation = _selectedClinic != null;
    return GestureDetector(
      onTap: _openMapPicker,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: hasLocation ? AppColors.accentGreen : AppColors.surfaceVariant,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(
              hasLocation ? Icons.check_circle : Icons.location_on_outlined,
              color: hasLocation ? AppColors.accentGreen : AppColors.textSecondary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hasLocation ? _selectedClinic!.clinicName : 'Select Clinic Location on Map',
                    style: AppTextStyles.labelMd.copyWith(
                      color: hasLocation ? AppColors.textPrimary : AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    hasLocation
                        ? _selectedClinic!.clinicAddress
                        : 'Required for registration',
                    style: AppTextStyles.bodySm.copyWith(color: AppColors.textSecondary),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Icon(Icons.map, color: AppColors.accentBlue),
          ],
        ),
      ),
    );
  }
}
