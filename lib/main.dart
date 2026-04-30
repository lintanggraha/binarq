import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/app_colors.dart';
import 'features/subject/presentation/subject_selection_screen.dart';
import 'features/profile/presentation/profile_selection_screen.dart';
import 'features/profile/presentation/widgets/profile_avatar.dart';
import 'features/profile/providers/profile_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://zohccxhlueafwpmvhasn.supabase.co',
    anonKey: 'sb_publishable_U9IG5DbHLbJ9NEyhx7KS3Q_dJdTcnrB',
  );

  runApp(
    const ProviderScope(
      child: BinarQApp(),
    ),
  );
}

class BinarQApp extends StatelessWidget {
  const BinarQApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BinarQ',
      theme: AppTheme.lightTheme,
      home: const ProfileSelectionScreen(), // Mulai dari Layar Pilih Profil
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainMenuScreen extends ConsumerWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeProfile = ref.watch(profileNotifierProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE3FAFF),
              Color(0xFFFFF2B8),
              Color(0xFFFFE1EC),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Tampilkan Avatar Profil Aktif
                if (activeProfile != null)
                  ProfileAvatar(profile: activeProfile, size: 104),
                const SizedBox(height: 10),
                Text(
                  activeProfile != null
                      ? 'Ahlan, ${activeProfile.name}!'
                      : 'BinarQ',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Petualangan Ilmu Dimulai!',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SubjectSelectionScreen()),
                    );
                  },
                  child: const Text('MULAI MAIN'),
                ),
                const SizedBox(height: 10),
                // Tombol Ganti Profil
                TextButton(
                  onPressed: () {
                    ref.read(profileNotifierProvider.notifier).logout();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileSelectionScreen()),
                    );
                  },
                  child: const Text('Ganti Profil',
                      style: TextStyle(color: AppColors.textLight)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
