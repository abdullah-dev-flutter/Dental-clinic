  Widget build(BuildContext context) {
    final clinic = ref.watch(selectedClinicProvider);
    if (clinic == null) {
      return const Scaffold(
        body: Center(child: Text('No clinic selected')),
      );
    }
    final isOpen = _isOpenNow(clinic.openingHours);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Image/Header
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: clinic.source == ClinicSource.partner
                ? AppColors.accentBlue
                : AppColors.accentGreen,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                clinic.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      clinic.source == ClinicSource.partner
                          ? AppColors.accentBlue
                          : AppColors.accentGreen,
                      clinic.source == ClinicSource.partner
                          ? AppColors.accentBlue.withValues(alpha: 0.7)
                          : AppColors.accentGreen.withValues(alpha: 0.7),
                    ],
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.local_hospital,
                    size: 80,
                    color: Colors.white24,
                  ),
                ),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 16, top: 8),
                decoration: BoxDecoration(
                  color: isOpen
                      ? Colors.green.withValues(alpha: 0.2)
                      : Colors.red.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isOpen ? Colors.green : Colors.red,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isOpen ? Icons.circle : Icons.circle,
                        size: 8,
                        color: isOpen ? Colors.green : Colors.red,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        isOpen ? 'Open Now' : 'Closed',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isOpen ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Source Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: clinic.source == ClinicSource.partner
                          ? AppColors.accentBlue.withValues(alpha: 0.15)
                          : AppColors.accentGreen.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: clinic.source == ClinicSource.partner
                            ? AppColors.accentBlue.withValues(alpha: 0.3)
                            : AppColors.accentGreen.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          clinic.source == ClinicSource.partner
                              ? Icons.storage
                              : Icons.public,
                          size: 16,
                          color: clinic.source == ClinicSource.partner
                              ? AppColors.accentBlue
                              : AppColors.accentGreen,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          clinic.source == ClinicSource.partner
                              ? 'Database Clinic'
                              : 'OpenStreetMap Clinic',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: clinic.source == ClinicSource.partner
                                ? AppColors.accentBlue
                                : AppColors.accentGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Distance Card
                  _buildInfoCard(
                    icon: Icons.location_on,
                    iconColor: AppColors.accentBlue,
                    title: 'Distance',
                    value: '${clinic.distanceKm.toStringAsFixed(1)} km away',
                    subtitle: 'From your location',
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Address Card
                  _buildInfoCard(
                    icon: Icons.place,
                    iconColor: Colors.orange,
                    title: 'Address',
                    value: clinic.address,
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Phone Card
                  if (clinic.phone != null && clinic.phone!.isNotEmpty) ...[
                    _buildInfoCard(
                      icon: Icons.phone,
                      iconColor: AppColors.accentGreen,
                      title: 'Phone',
                      value: clinic.phone!,
                      isLink: true,
                      onTap: () => launchUrl(Uri.parse('tel:${clinic.phone}')),
                    ),
                    const SizedBox(height: 12),
                  ],
                  
                  // Website Card
                  if (clinic.website != null && clinic.website!.isNotEmpty) ...[
                    _buildInfoCard(
                      icon: Icons.language,
                      iconColor: Colors.purple,
                      title: 'Website',
                      value: clinic.website!,
                      isLink: true,
                      onTap: () => launchUrl(Uri.parse(clinic.website!)),
                    ),
                    const SizedBox(height: 12),
                  ],
                  
                  // Opening Hours Card
                  _buildInfoCard(
                    icon: Icons.schedule,
                    iconColor: Colors.teal,
                    title: 'Opening Hours',
                    value: clinic.openingHours ?? 'Not available',
                    subtitle: clinic.openingHours != null ? _getOpenClosedStatus(clinic.openingHours!) : null,
                    subtitleColor: isOpen ? AppColors.accentGreen : AppColors.errorRed,
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Coordinates Card
                  _buildInfoCard(
                    icon: Icons.map,
                    iconColor: Colors.indigo,
                    title: 'Coordinates',
                    value: '${clinic.latitude.toStringAsFixed(6)}, ${clinic.longitude.toStringAsFixed(6)}',
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Action Buttons
                  Row(
                    children: [
                      // Call Button
                      if (clinic.phone != null && clinic.phone!.isNotEmpty)
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => launchUrl(Uri.parse('tel:${clinic.phone}')),
                            icon: const Icon(Icons.call, size: 20),
                            label: const Text('Call Clinic'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.accentGreen,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      if (clinic.phone != null && clinic.phone!.isNotEmpty)
                        const SizedBox(width: 12),
                      
                      // Directions Button
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            final url = 'https://www.google.com/maps/dir/?api=1&destination=${clinic.latitude},${clinic.longitude}';
                            launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                          },
                          icon: const Icon(Icons.directions, size: 20),
                          label: const Text('Directions'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accentBlue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Open in Maps Button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        final url = 'https://www.openstreetmap.org/?mlat=${clinic.latitude}&mlon=${clinic.longitude}#map=18/${clinic.latitude}/${clinic.longitude}';
                        launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                      },
                      icon: const Icon(Icons.map_outlined, size: 20),
                      label: const Text('View on OpenStreetMap'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textPrimary,
                        side: const BorderSide(color: Colors.grey),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
