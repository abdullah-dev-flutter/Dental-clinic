import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'repository_providers.dart';

final onboardingProvider = FutureProvider.family<void, String>((ref, userId) async {
  final repo = ref.read(profileRepositoryProvider);
  await repo.markOnboardingDone(userId);
});
