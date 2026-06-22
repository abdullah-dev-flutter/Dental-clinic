import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../data/models/doctor/doctor_model.dart';
import '../../../../domain/providers/doctor/doctor_provider.dart';
import '../../../../domain/providers/repository_providers.dart';
import '../../../widgets/common/app_button.dart';

class DoctorSignupStep3 extends ConsumerStatefulWidget {
  final Map<String, dynamic> doctorData;
  const DoctorSignupStep3({super.key, required this.doctorData});

  @override
  ConsumerState<DoctorSignupStep3> createState() => _DoctorSignupStep3State();
}

class _DoctorSignupStep3State extends ConsumerState<DoctorSignupStep3> {
  XFile? _pmdcFile;
  XFile? _degreeFile;
  XFile? _cnicFile;
  XFile? _profileFile;

  bool _isSubmitting = false;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(String type) async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    setState(() {
      if (type == 'pmdc') _pmdcFile = image;
      if (type == 'degree') _degreeFile = image;
      if (type == 'cnic') _cnicFile = image;
      if (type == 'profile') _profileFile = image;
    });
  }

  Future<String> _uploadDocumentPath(XFile file, String folder) async {
    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser!.id;
    final ext = file.name.split('.').last.toLowerCase();
    final path = '$folder/$userId.$ext';
    
    final contentType = file.mimeType ?? (ext == 'jpg' ? 'image/jpeg' : 'image/$ext');

    final bytes = await file.readAsBytes();
    await supabase.storage.from('doctor-documents').uploadBinary(
          path,
          bytes,
          fileOptions: FileOptions(upsert: true, contentType: contentType),
        );

    return path;
  }

  Future<String> _uploadProfileImage(XFile file) async {
    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser!.id;
    final ext = file.name.split('.').last.toLowerCase();
    final path = '$userId/profile.$ext';

    final contentType = file.mimeType ?? (ext == 'jpg' ? 'image/jpeg' : 'image/$ext');

    final bytes = await file.readAsBytes();
    await supabase.storage.from('avatars').uploadBinary(
          path,
          bytes,
          fileOptions: FileOptions(upsert: true, contentType: contentType),
        );

    final url = supabase.storage.from('avatars').getPublicUrl(path);

    await supabase.from('profiles').update({'avatar_url': url}).eq('id', userId);
    return url;
  }

  Future<String> _uploadCnic(XFile file) => _uploadDocumentPath(file, 'cnic');

  Future<String> _uploadDegree(XFile file) => _uploadDocumentPath(file, 'degrees');

  Future<String> _uploadPmdc(XFile file) => _uploadDocumentPath(file, 'pmdc');

  Future<void> _handleSubmit() async {
    if (_pmdcFile == null ||
        _degreeFile == null ||
        _cnicFile == null ||
        _profileFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload all required documents')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) throw Exception('User not logged in');

      final results = await Future.wait<String>([
        _uploadProfileImage(_profileFile!),
        _uploadCnic(_cnicFile!),
        _uploadDegree(_degreeFile!),
        _uploadPmdc(_pmdcFile!),
      ]);

      final profileUrl = results[0];
      final cnicUrl = results[1];
      final degreeUrl = results[2];
      final pmdcUrl = results[3];

      final doctor = DoctorModel(
        id: '',
        userId: user.id,
        fullName: user.userMetadata?['full_name'] as String? ?? 'Doctor',
        email: user.email ?? '',
        phone: user.userMetadata?['phone'] as String?,
        pmdcNumber: widget.doctorData['pmdc'] as String,
        specialization: widget.doctorData['specialization'] as String?,
        experienceYears: widget.doctorData['experience'] as int?,
        consultationFee: widget.doctorData['fee'] as double?,
        profileImageUrl: profileUrl,
        status: 'pending',
      );

      final doctorRepo = ref.read(doctorRepositoryProvider);
      final doctorId = await doctorRepo.createDoctorProfile(doctor);

      await ref.read(clinicRepositoryProvider).registerDoctorClinic(
            doctorId: doctorId,
            clinicName: widget.doctorData['clinic_name'] as String,
            clinicAddress: widget.doctorData['clinic_address'] as String,
            lat: widget.doctorData['lat'] as double,
            lng: widget.doctorData['lng'] as double,
            existingClinicId: widget.doctorData['existing_clinic_id'] as String?,
          );

      await doctorRepo.uploadVerificationDocuments(
        doctorId: doctorId,
        pmdcUrl: pmdcUrl,
        degreeUrl: degreeUrl,
        cnicUrl: cnicUrl,
      );

      ref.invalidate(doctorProfileProvider);
      if (mounted) context.go('/doctor/pending');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.errorRed),
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Document Upload'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LinearProgressIndicator(
              value: 1,
              backgroundColor: AppColors.surfaceVariant,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentGreen),
            ),
            const SizedBox(height: 32),
            Text('Upload Documents', style: AppTextStyles.headingMd),
            const SizedBox(height: 8),
            Text(
              'Please provide clear images of your official documents for verification.',
              style: AppTextStyles.bodyMd.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 32),
            _buildUploadItem('Profile Photo', _profileFile, () => _pickImage('profile')),
            _buildUploadItem('PMDC License', _pmdcFile, () => _pickImage('pmdc')),
            _buildUploadItem('Degree Certificate', _degreeFile, () => _pickImage('degree')),
            _buildUploadItem('CNIC (Front/Back)', _cnicFile, () => _pickImage('cnic')),
            const SizedBox(height: 48),
            AppButton(
              label: 'Submit Application',
              isLoading: _isSubmitting,
              onPressed: _handleSubmit,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadItem(String label, XFile? file, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.labelMd),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: file != null ? AppColors.accentGreen : AppColors.surfaceVariant,
              ),
            ),
            child: file != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: kIsWeb
                        ? FutureBuilder<Uint8List>(
                            future: file.readAsBytes(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(child: CircularProgressIndicator());
                              }
                              if (snapshot.hasData) {
                                return Image.memory(
                                  snapshot.data!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                );
                              }
                              return const Center(child: Icon(Icons.error));
                            },
                          )
                        : Image.file(
                            File(file.path),
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.cloud_upload_outlined,
                        color: AppColors.textSecondary,
                        size: 32,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tap to upload',
                        style: AppTextStyles.bodySm.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
