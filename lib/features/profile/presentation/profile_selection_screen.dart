import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../main.dart'; // Untuk navigasi ke MainMenuScreen
import '../providers/profile_provider.dart';
import '../../../core/network/supabase_service.dart';

class ProfileSelectionScreen extends ConsumerStatefulWidget {
  const ProfileSelectionScreen({super.key});

  @override
  ConsumerState<ProfileSelectionScreen> createState() => _ProfileSelectionScreenState();
}

class _ProfileSelectionScreenState extends ConsumerState<ProfileSelectionScreen> {
  
  @override
  void initState() {
    super.initState();
    // Jalankan Sinkronisasi Soal dari Supabase ke Isar di Background
    Future.microtask(() {
      ref.read(supabaseSyncProvider).syncQuestionsFromCloud();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileNotifier = ref.read(profileNotifierProvider.notifier);
    final profiles = profileNotifier.availableProfiles;

    return Scaffold(
      backgroundColor: AppColors.textDark, // Background gelap ala Netflix
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Siapa yang mau belajar?',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              
              // Grid Profil (Kakak, Adik, Bunda)
              Wrap(
                spacing: 30,
                runSpacing: 30,
                alignment: WrapAlignment.center,
                children: profiles.map((profile) {
                  return GestureDetector(
                    onTap: () {
                      // 1. Set Profil Aktif di State
                      profileNotifier.selectProfile(profile);
                      
                      // 2. Jika Bunda, minta PIN (Untuk sekarang kita skip PIN dulu)
                      // Jika Anak, langsung masuk menu utama
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const MainMenuScreen()),
                      );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Avatar Berkilau
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: profile.isParent ? AppColors.error : AppColors.primary,
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: (profile.isParent ? AppColors.error : AppColors.primary).withOpacity(0.5),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                            image: DecorationImage(
                              image: NetworkImage(profile.avatarUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Nama Profil
                        Text(
                          profile.name,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        // Label Kelas atau Status
                        Text(
                          profile.isParent ? 'Orang Tua' : 'Kelas ${profile.grade}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 60),
              // Tombol Tambah Profil
              TextButton.icon(
                onPressed: () {
                  // TODO: Fitur Tambah Anak
                },
                icon: const Icon(Icons.add_circle_outline, color: Colors.white),
                label: Text(
                  'Tambah Profil',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
