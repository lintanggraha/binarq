import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/profile.dart';

class ProfileNotifier extends StateNotifier<UserProfile?> {
  ProfileNotifier() : super(null);

  final List<UserProfile> _profiles = [];

  List<UserProfile> get availableProfiles => List.unmodifiable(_profiles);

  void addProfile({
    required String name,
    required String gender,
    required int age,
    required int grade,
  }) {
    final profile = UserProfile(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: name.trim(),
      gender: gender,
      age: age,
      level: 1,
      totalXp: 0,
      grade: grade,
      avatarColorValue: _avatarColors[_profiles.length % _avatarColors.length],
    );

    _profiles.add(profile);
    state = profile;
  }

  void selectProfile(UserProfile profile) {
    state = profile;
  }

  void logout() {
    state = null;
  }
}

final profileNotifierProvider =
    StateNotifierProvider<ProfileNotifier, UserProfile?>((ref) {
  return ProfileNotifier();
});

const _avatarColors = [
  0xFFFF9F1C,
  0xFF2EC4B6,
  0xFF3A86FF,
  0xFFEF476F,
  0xFF8AC926,
  0xFF8338EC,
];
