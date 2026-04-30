import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/profile.dart';

class ProfileNotifier extends StateNotifier<UserProfile?> {
  ProfileNotifier() : super(null);

  // Mock Data: Anggap saja ini diambil dari Isar / Supabase
  final List<UserProfile> _mockProfiles = [
    UserProfile(
      id: 'p1',
      name: 'Kak Aisyah',
      avatarUrl: 'https://api.dicebear.com/7.x/fun-emoji/png?seed=Aisyah&backgroundColor=ffd166',
      level: 12,
      totalXp: 4500,
      grade: 4,
    ),
    UserProfile(
      id: 'p2',
      name: 'Adik Umar',
      avatarUrl: 'https://api.dicebear.com/7.x/fun-emoji/png?seed=Umar&backgroundColor=00c4b5',
      level: 3,
      totalXp: 120,
      grade: 1,
    ),
    UserProfile(
      id: 'parent1',
      name: 'Bunda',
      avatarUrl: 'https://api.dicebear.com/7.x/initials/png?seed=Bunda&backgroundColor=ef476f',
      level: 0,
      totalXp: 0,
      grade: 0,
      isParent: true,
    ),
  ];

  List<UserProfile> get availableProfiles => _mockProfiles;

  void selectProfile(UserProfile profile) {
    state = profile;
  }

  void logout() {
    state = null;
  }
}

final profileNotifierProvider = StateNotifierProvider<ProfileNotifier, UserProfile?>((ref) {
  return ProfileNotifier();
});
