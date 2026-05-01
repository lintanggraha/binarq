import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/audio/audio_service.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/app_colors.dart';
import 'features/subject/presentation/subject_selection_screen.dart';
import 'features/profile/presentation/profile_selection_screen.dart';
import 'features/profile/presentation/widgets/profile_avatar.dart';
import 'features/profile/providers/profile_provider.dart';
import 'features/profile/providers/history_provider.dart';
import 'core/network/supabase_service.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://zohccxhlueafwpmvhasn.supabase.co',
    anonKey: 'sb_publishable_U9IG5DbHLbJ9NEyhx7KS3Q_dJdTcnrB',
  );

  final container = ProviderContainer();
  
  // Jalankan sinkronisasi dari Cloud ke Local Isar di background
  container.read(supabaseSyncProvider).syncQuestionsFromCloud();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const BinarQApp(),
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

class MainMenuScreen extends ConsumerStatefulWidget {
  const MainMenuScreen({super.key});

  @override
  ConsumerState<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends ConsumerState<MainMenuScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(audioServiceProvider).resumeBgm();
    });
  }

  @override
  Widget build(BuildContext context) {
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Tampilkan Avatar Profil Aktif
                  if (activeProfile != null) ...[
                    ProfileAvatar(profile: activeProfile, size: 120),
                    const SizedBox(height: 16),
                    Text(
                      'Ahlan, ${activeProfile.name}!',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    // Badge Level & XP
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: AppColors.accent, width: 2),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.stars_rounded, color: AppColors.accent),
                          const SizedBox(width: 8),
                          Text(
                            'Level ${activeProfile.level} • ${activeProfile.totalXp} XP',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Koleksi Medali
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _MedalBadge(count: activeProfile.goldMedals, color: const Color(0xFFFFD700), label: 'Gold'),
                        const SizedBox(width: 12),
                        _MedalBadge(count: activeProfile.silverMedals, color: const Color(0xFFC0C0C0), label: 'Silver'),
                        const SizedBox(width: 12),
                        _MedalBadge(count: activeProfile.bronzeMedals, color: const Color(0xFFCD7F32), label: 'Bronze'),
                      ],
                    ),
                  ] else ...[
                    const Text('BinarQ', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  ],
                  const SizedBox(height: 10),
                  Text(
                    'Petualangan Ilmu Dimulai!',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 64,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SubjectSelectionScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      child: const Text('MULAI MAIN', style: TextStyle(fontSize: 22, letterSpacing: 1.2)),
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Section History
                  if (activeProfile != null) ...[
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Aktivitas Terakhir',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ref.watch(historyProvider).when(
                      data: (history) {
                        if (history.isEmpty) {
                          return const Text('Belum ada riwayat kuis. Yuk main!');
                        }
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: history.length > 5 ? 5 : history.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            final item = history[index];
                            return Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: item.score >= 80 ? Colors.green : Colors.orange,
                                    radius: 18,
                                    child: Icon(
                                      item.score >= 80 ? Icons.check : Icons.auto_awesome,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('${item.mapel} - ${item.kategoriUjian}', 
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                        Text(DateFormat('dd MMM, HH:mm').format(item.completedAt), 
                                          style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                      ],
                                    ),
                                  ),
                                  Text('${item.score}', 
                                    style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      loading: () => const CircularProgressIndicator(),
                      error: (e, _) => Text('Error: $e'),
                    ),
                  ],

                  const SizedBox(height: 20),
                  // Tombol Ganti Profil
                  TextButton.icon(
                    onPressed: () {
                      ref.read(profileNotifierProvider.notifier).logout();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileSelectionScreen()),
                      );
                    },
                    icon: const Icon(Icons.group_outlined, size: 20),
                    label: const Text('Ganti Profil',
                        style: TextStyle(color: AppColors.textLight)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MedalBadge extends StatelessWidget {
  final int count;
  final Color color;
  final String label;

  const _MedalBadge({
    required this.count,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.3),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
            border: Border.all(color: color, width: 2),
          ),
          child: Icon(Icons.emoji_events, color: color, size: 24),
        ),
        const SizedBox(height: 4),
        Text(
          '$count',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ],
    );
  }
}
