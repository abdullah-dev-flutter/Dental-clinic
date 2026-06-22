import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../domain/verification_providers.dart';
import '../domain/doctor_verification_model.dart';
import 'package:intl/intl.dart';

class DoctorDetailScreen extends ConsumerStatefulWidget {
  const DoctorDetailScreen({super.key});

  @override
  ConsumerState<DoctorDetailScreen> createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends ConsumerState<DoctorDetailScreen> {
  final _reasonCtrl = TextEditingController();
  String _selectedReason = 'Invalid PMDC License';

  @override
  void dispose() {
    _reasonCtrl.dispose();
    super.dispose();
  }

  void _showApproveDialog(BuildContext context, DoctorVerificationModel doctor) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Approve Doctor'),
        content: Text('Are you sure you want to approve Dr. ${doctor.fullName} as a verified doctor?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.successGreen),
            onPressed: () async {
              Navigator.pop(context); // close confirmation
              
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => const Center(child: CircularProgressIndicator()),
              );

              try {
                await ref.read(verificationRepositoryProvider).approveDoctor(doctor.id, doctor.userId);
                
                ref.invalidate(pendingDoctorsProvider);
                ref.invalidate(approvedDoctorsProvider);
                ref.invalidate(pendingCountProvider);

                if (context.mounted) {
                  Navigator.pop(context); // close loading
                  
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => AlertDialog(
                      title: const Text('Success'),
                      content: const Text('Doctor has been successfully approved.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // close success dialog
                            context.pop(); // go back to dashboard
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  Navigator.pop(context); // close loading
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.errorRed),
                  );
                }
              }
            },
            child: const Text('Confirm Approve', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showRejectDialog(BuildContext context, DoctorVerificationModel doctor) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text('Reject Doctor Application'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Please select a reason for rejection:'),
                  const SizedBox(height: 16),
                  DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedReason,
                    items: [
                      'Invalid PMDC License',
                      'Fake Documents',
                      'Incomplete Information',
                      'PMDC Number Mismatch',
                      'Low Quality Documents',
                      'Other'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setStateDialog(() {
                        _selectedReason = newValue!;
                      });
                    },
                  ),
                  if (_selectedReason == 'Other') ...[
                    const SizedBox(height: 16),
                    TextField(
                      controller: _reasonCtrl,
                      decoration: const InputDecoration(
                        hintText: 'Enter specific reason...',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                  ],
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.errorRed),
                  onPressed: () async {
                    final finalReason = _selectedReason == 'Other' ? _reasonCtrl.text : _selectedReason;
                    if (finalReason.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please provide a reason')),
                      );
                      return;
                    }

                    Navigator.pop(context); // close reason prompt
                    
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => const Center(child: CircularProgressIndicator()),
                    );

                    try {
                      await ref.read(verificationRepositoryProvider).rejectDoctor(doctor.id, finalReason);
                      
                      ref.invalidate(pendingDoctorsProvider);
                      ref.invalidate(rejectedDoctorsProvider);
                      ref.invalidate(pendingCountProvider);

                      if (context.mounted) {
                        Navigator.pop(context); // close loading
                        
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => AlertDialog(
                            title: const Text('Application Rejected'),
                            content: const Text('The doctor application has been successfully rejected.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // close success dialog
                                  context.pop(); // go back to dashboard
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        Navigator.pop(context); // close loading
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.errorRed),
                        );
                      }
                    }
                  },
                  child: const Text('Confirm Reject', style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          }
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final doctor = ref.watch(selectedDoctorProvider);

    if (doctor == null) {
      return const Scaffold(body: Center(child: Text('No doctor selected')));
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Request Details'),
        backgroundColor: Colors.grey[50],
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
      ),
      bottomNavigationBar: doctor.status == 'pending' ? Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.errorRed,
                    side: const BorderSide(color: AppColors.errorRed),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => _showRejectDialog(context, doctor),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.close, size: 18),
                      SizedBox(width: 8),
                      Text('Reject', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.successGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => _showApproveDialog(context, doctor),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check, size: 18),
                      SizedBox(width: 8),
                      Text('Approve', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ) : null,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 800) {
            // Mobile/Tablet Vertical Layout
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLeftInfo(doctor, isMobile: true),
                  const SizedBox(height: 24),
                  _buildRightDocuments(doctor),
                ],
              ),
            );
          } else {
            // Desktop Horizontal Layout
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(32),
                    child: _buildLeftInfo(doctor),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(32),
                    child: _buildRightDocuments(doctor),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildLeftInfo(DoctorVerificationModel doctor, {bool isMobile = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: doctor.profileImageUrl != null ? NetworkImage(doctor.profileImageUrl!) : null,
                  child: doctor.profileImageUrl == null ? const Icon(Icons.person, size: 40, color: Colors.grey) : null,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Dr. ${doctor.fullName}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                      const SizedBox(height: 4),
                      Text(doctor.specialization ?? 'Doctor', style: const TextStyle(fontSize: 14, color: Colors.blueAccent, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.email_outlined, size: 16, color: Colors.grey),
                          const SizedBox(width: 8),
                          Expanded(child: Text(doctor.email, style: const TextStyle(fontSize: 13, color: Colors.grey))),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.phone_outlined, size: 16, color: Colors.grey),
                          const SizedBox(width: 8),
                          Text(doctor.phone ?? 'N/A', style: const TextStyle(fontSize: 13, color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 32),
        const Text('About Doctor', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
        const SizedBox(height: 16),
        _buildAboutRow(Icons.calendar_today_outlined, 'Date of Application', DateFormat('dd MMM yyyy').format(doctor.createdAt)),
        _buildAboutRow(Icons.school_outlined, 'Experience', '${doctor.experienceYears ?? 0} Years'),
        _buildAboutRow(Icons.location_on_outlined, 'Address', doctor.clinicAddress ?? 'N/A'),
        _buildAboutRow(Icons.medical_services_outlined, 'PMDC Number', doctor.pmdcNumber),
      ],
    );
  }

  Widget _buildAboutRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          const Spacer(),
          Text(value, style: const TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildRightDocuments(DoctorVerificationModel doctor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Documents Submitted', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
        const SizedBox(height: 16),
        _DocumentPreviewCard(title: 'PMDC License', path: doctor.pmdcLicenseUrl),
        _DocumentPreviewCard(title: 'Degree Certificate', path: doctor.degreeUrl),
        _DocumentPreviewCard(title: 'CNIC (Front/Back)', path: doctor.cnicUrl),
        const SizedBox(height: 32),
      ],
    );
  }


}

class _DocumentPreviewCard extends ConsumerStatefulWidget {
  final String title;
  final String? path;

  const _DocumentPreviewCard({required this.title, required this.path});

  @override
  ConsumerState<_DocumentPreviewCard> createState() => _DocumentPreviewCardState();
}

class _DocumentPreviewCardState extends ConsumerState<_DocumentPreviewCard> {
  String? _signedUrl;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchSignedUrl();
  }

  Future<void> _fetchSignedUrl() async {
    if (widget.path == null || widget.path!.isEmpty) return;

    setState(() => _isLoading = true);
    try {
      final url = await ref.read(verificationRepositoryProvider).getSignedUrl(widget.path);
      if (mounted) setState(() => _signedUrl = url);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Open full image if needed later
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.blueAccent.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.description_outlined, color: Colors.blueAccent, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Row(
                children: [
                  Flexible(child: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14))),
                  const SizedBox(width: 8),
                  if (widget.path != null && widget.path!.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                      child: const Text('Verified', style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            if (widget.path != null && widget.path!.isNotEmpty)
              Container(
                width: 36,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: _isLoading 
                  ? const Center(child: SizedBox(width: 12, height: 12, child: CircularProgressIndicator(strokeWidth: 2)))
                  : (_signedUrl != null 
                      ? ClipRRect(borderRadius: BorderRadius.circular(4), child: Image.network(_signedUrl!, fit: BoxFit.cover))
                      : const Icon(Icons.error_outline, size: 16, color: Colors.grey)),
              )
          ],
        ),
      ),
    );
  }
}
