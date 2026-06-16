import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../domain/providers/doctor_list_provider.dart';
import '../../../domain/providers/map_providers.dart';
import '../../../data/models/map_clinic_entity.dart';
import '../../widgets/doctor_card.dart';

class DoctorsScreen extends ConsumerStatefulWidget {
  const DoctorsScreen({super.key});

  @override
  ConsumerState<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends ConsumerState<DoctorsScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  bool _isSearching = false;
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _animController.forward();
    
    // Sync search controller if there's already a query (e.g. from Home)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final query = ref.read(doctorSearchProvider).query;
      if (query.isNotEmpty) {
        setState(() {
          _isSearching = true;
          _searchCtrl.text = query;
        });
      }
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(doctorSearchProvider);
    final doctorsAsync = ref.watch(doctorListProvider);

    return Scaffold(
      appBar: AppBar(
        leading: _isSearching 
            ? IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {
                setState(() => _isSearching = false);
                _searchCtrl.clear();
                ref.read(doctorSearchProvider.notifier).setQuery('');
              })
            : IconButton(icon: const Icon(Icons.notifications_none), onPressed: () => context.push('/notifications')),
        title: _isSearching 
            ? TextField(
                controller: _searchCtrl,
                autofocus: true,
                style: AppTextStyles.labelMd,
                decoration: const InputDecoration(
                  hintText: 'Search doctor or service...',
                  border: InputBorder.none,
                ),
                onChanged: (v) => ref.read(doctorSearchProvider.notifier).setQuery(v),
              )
            : const Text('Doctors'),
        actions: [
          if (!_isSearching)
            Container(
              margin: const EdgeInsets.only(right: 16),
              decoration: const BoxDecoration(color: AppColors.accentGreen, shape: BoxShape.circle),
              child: IconButton(
                icon: const Icon(Icons.search, color: AppColors.background), 
                onPressed: () => setState(() => _isSearching = true),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          if (!_isSearching) ...[
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        'Greenwich Village',
                        style: AppTextStyles.labelMd,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 36,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildFilterChip('All', 'all', searchState.specialty),
                  _buildFilterChip('General', 'general', searchState.specialty),
                  _buildFilterChip('Cosmetic', 'cosmetic', searchState.specialty),
                  _buildFilterChip('Orthodontist', 'orthodontist', searchState.specialty),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
          Expanded(
            child: doctorsAsync.when(
              data: (doctors) {
                if (doctors.isEmpty) {
                  return Center(child: Text('No doctors found', style: AppTextStyles.bodyMd));
                }
                return RefreshIndicator(
                  onRefresh: () async => ref.refresh(doctorListProvider),
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: doctors.length,
                    itemBuilder: (context, index) {
                      final animation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
                        CurvedAnimation(
                          parent: _animController,
                          curve: Interval((index * 0.1).clamp(0.0, 1.0), 1.0, curve: Curves.easeOut),
                        ),
                      );
                      return SlideTransition(
                        position: animation,
                        child: DoctorCard(
                          doctor: doctors[index],
                          onTap: () => context.push('/doctor/${doctors[index].id}', extra: doctors[index]),
                        ),
                      );
                    },
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text('Failed to load doctors: $e')),
            ),
          ),
          // Nearby Clinics Section
          Container(
            constraints: const BoxConstraints(maxHeight: 320),
            decoration: const BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Nearby Dental Clinics', style: AppTextStyles.headingSm),
                      TextButton.icon(
                        onPressed: () => context.push('/clinics-map'),
                        icon: const Icon(Icons.map, size: 18),
                        label: const Text('Map View'),
                      ),
                    ],
                  ),
                ),
                ref.watch(allMapClinicsProvider).when(
                  data: (clinics) {
                    if (clinics.isEmpty) {
                      return const SizedBox(
                        height: 80,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Text('No nearby clinics found'),
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: clinics.length > 4 ? 4 : clinics.length,
                      itemBuilder: (context, index) {
                        final clinic = clinics[index];
                        final isDb = clinic.source == ClinicSource.partner;
                          return GestureDetector(
                            onTap: () {
                              ref.read(selectedClinicProvider.notifier).state = clinic;
                              context.push('/clinics/detail');
                            },
                            child: Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: isDb
                                        ? AppColors.accentBlue.withValues(alpha: 0.15)
                                        : AppColors.accentGreen.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Icons.local_hospital,
                                    color: isDb ? AppColors.accentBlue : AppColors.accentGreen,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        clinic.name,
                                        style: AppTextStyles.labelMd,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        '${clinic.distanceKm.toStringAsFixed(1)} km • ${clinic.address}',
                                        style: AppTextStyles.bodySm,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 14,
                                  color: AppColors.textSecondary,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  loading: () => const SizedBox(
                    height: 80,
                    child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                  ),
                  error: (e, _) => const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String type, String currentType) {
    final isActive = type == currentType;
    return GestureDetector(
      onTap: () {
        ref.read(doctorSearchProvider.notifier).setSpecialty(type);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? AppColors.accentBlue : AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          style: AppTextStyles.labelSm.copyWith(
            color: isActive ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
