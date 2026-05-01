import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/isar_service.dart';
import '../../quiz/repositories/quiz_repository.dart';
import '../models/profile.dart';

class ProfileNotifier extends StateNotifier<UserProfile?> {
  final IsarService _isarService;
  List<UserProfile> _profiles = [];

  ProfileNotifier(this._isarService) : super(null) {
    _loadProfiles();
  }

  List<UserProfile> get availableProfiles => List.unmodifiable(_profiles);

  Future<void> _loadProfiles() async {
    _profiles = await _isarService.getAllProfiles();
    // Jika hanya ada 1 profil, bisa langsung pilih? 
    // Tapi user minta "jika sudah pernah membuat maka selanjutnya profile akan tersimpan"
    state = null; // Default belum terpilih
  }

  Future<void> addProfile({
    required String name,
    required String gender,
    required int age,
    required int grade,
  }) async {
    final profile = UserProfile.create(
      name: name.trim(),
      gender: gender,
      age: age,
      level: 1,
      totalXp: 0,
      grade: grade,
      avatarColorValue: _avatarColors[_profiles.length % _avatarColors.length],
    );

    await _isarService.saveProfile(profile);
    await _loadProfiles();
    state = _profiles.last;
  }

  void selectProfile(UserProfile profile) {
    state = profile;
  }

  void logout() {
    state = null;
  }

  Future<void> updateProgress({required int xpGain, required int score}) async {
    if (state == null) return;

    final updatedProfile = state!;
    updatedProfile.totalXp += xpGain;
    
    // Logika Medali
    if (score >= 100) {
      updatedProfile.goldMedals++;
    } else if (score >= 80) {
      updatedProfile.silverMedals++;
    } else if (score >= 60) {
      updatedProfile.bronzeMedals++;
    }

    // Logika level up sederhana (setiap 100 XP naik level)
    updatedProfile.level = (updatedProfile.totalXp / 100).floor() + 1;

    await _isarService.saveProfile(updatedProfile);
    state = updatedProfile;
    await _loadProfiles(); // Refresh list
  }
}

final profileNotifierProvider =
    StateNotifierProvider<ProfileNotifier, UserProfile?>((ref) {
  final isarService = ref.read(isarServiceProvider);
  return ProfileNotifier(isarService);
});

const _avatarColors = [
  0xFFFF9F1C,
  0xFF2EC4B6,
  0xFF3A86FF,
  0xFFEF476F,
  0xFF8AC926,
  0xFF8338EC,
];
