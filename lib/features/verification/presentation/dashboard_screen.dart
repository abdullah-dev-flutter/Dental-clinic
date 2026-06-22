import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../domain/doctor_verification_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../domain/verification_providers.dart';
import 'widgets/admin_sidebar.dart';
import 'widgets/admin_appbar.dart';
import 'pending_doctors_screen.dart';
import 'approved_doctors_screen.dart';
import 'rejected_doctors_screen.dart';

class AdminDashboardScreen extends ConsumerStatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  ConsumerState<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends ConsumerState<AdminDashboardScreen> {
  int _selectedIndex = 0;
  int _selectedTab = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 800;
        
        final appBar = AdminAppBar(
          title: _getTitle(),
          isMobile: isMobile,
        );

        if (isMobile) {
          return Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.grey[100],
            appBar: appBar,
            drawer: Drawer(
              child: AdminSidebar(
                selectedIndex: _selectedIndex,
                onItemSelected: (index) {
                  setState(() => _selectedIndex = index);
                  Navigator.pop(context); // Close drawer
                },
              ),
            ),
            body: _buildBody(true),
          );
        }

        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.grey[100],
          body: Row(
            children: [
              AdminSidebar(
                selectedIndex: _selectedIndex,
                onItemSelected: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
              Expanded(
                child: Column(
                  children: [
                    appBar,
                    Expanded(
                      child: _buildBody(false),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _getTitle() {
    switch (_selectedIndex) {
      case 0: return 'Dashboard Overview';
      case 1: return 'Pending Verifications';
      case 2: return 'Approved Doctors';
      case 3: return 'Rejected Applications';
      default: return 'Dashboard';
    }
  }

  Widget _buildBody(bool isMobile) {
    switch (_selectedIndex) {
      case 0: return _buildOverview(isMobile);
      case 1: return const PendingDoctorsScreen();
      case 2: return const ApprovedDoctorsScreen();
      case 3: return const RejectedDoctorsScreen();
      default: return const SizedBox();
    }
  }

  Widget _buildOverview(bool isMobile) {
    final pendingAsync = ref.watch(pendingDoctorsProvider);
    final approvedAsync = ref.watch(approvedDoctorsProvider);
    final rejectedAsync = ref.watch(rejectedDoctorsProvider);

    final activeAsync = _selectedTab == 0 ? pendingAsync : (_selectedTab == 1 ? approvedAsync : rejectedAsync);

    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 16.0 : 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isMobile) ...[
            const Text('Doctor Requests', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 8),
            const Text('Review and manage doctor registration requests', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: _buildSquareStatCard('Pending', pendingAsync, Colors.blueAccent, Icons.person)),
                const SizedBox(width: 12),
                Expanded(child: _buildSquareStatCard('Approved', approvedAsync, AppColors.successGreen, Icons.check)),
                const SizedBox(width: 12),
                Expanded(child: _buildSquareStatCard('Rejected', rejectedAsync, AppColors.errorRed, Icons.close)),
              ],
            ),
            const SizedBox(height: 24),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildTabPill('Pending', pendingAsync, 0),
                  const SizedBox(width: 12),
                  _buildTabPill('Approved', approvedAsync, 1),
                  const SizedBox(width: 12),
                  _buildTabPill('Rejected', rejectedAsync, 2),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ] else ...[
            Wrap(
              spacing: 24,
              runSpacing: 24,
              children: [
                _buildStatCard('Pending', pendingAsync, AppColors.starYellow, Icons.pending_actions, 300),
                _buildStatCard('Approved', approvedAsync, AppColors.successGreen, Icons.check_circle_outline, 300),
                _buildStatCard('Rejected', rejectedAsync, AppColors.errorRed, Icons.cancel_outlined, 300),
              ],
            ),
          ],
          const SizedBox(height: 24),
          if (!isMobile) ...[
            const Text(
              'Recent Applications',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 16),
          ],
          activeAsync.when(
            data: (list) {
              if (list.isEmpty) {
                return Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
                    ],
                  ),
                  child: const Center(child: Text('No applications found.', style: TextStyle(color: Colors.grey))),
                );
              }
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
                  ],
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: isMobile ? list.length : (list.length > 5 ? 5 : list.length),
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final doc = list[index];
                    
                    Color statusColor = Colors.orange;
                    if (doc.status == 'approved') statusColor = Colors.green;
                    if (doc.status == 'rejected') statusColor = Colors.red;

                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      leading: CircleAvatar(
                        backgroundImage: doc.profileImageUrl != null ? NetworkImage(doc.profileImageUrl!) : null,
                        child: doc.profileImageUrl == null ? const Icon(Icons.person) : null,
                      ),
                      title: Text('Dr. ${doc.fullName}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 16)),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(doc.specialization ?? "Doctor", style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(Icons.calendar_today_outlined, size: 12, color: Colors.grey[500]),
                                const SizedBox(width: 4),
                                Text(
                                  "${doc.createdAt.day} ${['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'][doc.createdAt.month - 1]} ${doc.createdAt.year}",
                                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.location_on_outlined, size: 12, color: Colors.grey[500]),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    doc.clinicAddress ?? 'No Address Provided',
                                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              doc.status.isNotEmpty ? '${doc.status[0].toUpperCase()}${doc.status.substring(1)}' : '',
                              style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.chevron_right, color: Colors.grey),
                        ],
                      ),
                      onTap: () {
                        ref.read(selectedDoctorProvider.notifier).state = doc;
                        context.push('/admin/doctor/detail');
                      },
                    );
                  },
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => Text('Error: $err'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, AsyncValue<List> asyncData, Color color, IconData icon, double width) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.05), Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(width: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              asyncData.when(
                data: (list) => Text(
                  '${list.length}',
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                loading: () => const SizedBox(
                  height: 38,
                  width: 40,
                  child: CircularProgressIndicator(),
                ),
                error: (_, __) => const Text('-', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSquareStatCard(String title, AsyncValue<List> asyncData, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 16),
          asyncData.when(
            data: (list) => Text('${list.length}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
            loading: () => const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 2)),
            error: (_, __) => const Text('-', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildTabPill(String title, AsyncValue<List> asyncData, int index) {
    final isSelected = _selectedTab == index;
    final count = asyncData.when(
      data: (list) => '${list.length}',
      loading: () => '...',
      error: (_, __) => '-',
    );

    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueAccent : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? Colors.blueAccent : Colors.grey[300]!),
        ),
        child: Text(
          '$title ($count)',
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
