import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/audio/audio_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../main.dart'; // Untuk kembali ke MainMenuScreen
import '../../../core/network/supabase_service.dart';
import '../../profile/providers/profile_provider.dart';

class ResultScreen extends ConsumerStatefulWidget {
  final int totalXp;
  final int correctCount;
  final int totalQuestions;
  final int score;

  const ResultScreen({
    super.key,
    required this.totalXp,
    required this.correctCount,
    required this.totalQuestions,
    required this.score,
  });

  @override
  ConsumerState<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen> {
  @override
  void initState() {
    super.initState();
    // Bunyikan SFX Level Up/Selesai saat layar ini muncul
    ref.read(audioServiceProvider).playLevelUp();

    // Backup XP terbaru ke Cloud (Background)
    Future.microtask(() {
      final activeProfile = ref.read(profileNotifierProvider);
      if (activeProfile != null) {
        ref.read(supabaseSyncProvider).backupProfileProgress(
              activeProfile.id,
              widget.totalXp, // Total akumulasi
              activeProfile.grade,
            );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isPerfect = widget.correctCount == widget.totalQuestions;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animasi Piala / Bintang
                SizedBox(
                  height: 250,
                  child: Lottie.network(
                    isPerfect
                        ? 'https://assets9.lottiefiles.com/packages/lf20_touohxv0.json' // Animasi Perfect
                        : 'https://assets5.lottiefiles.com/packages/lf20_yziud2q4.json', // Animasi Senang biasa
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.emoji_events,
                      size: 100,
                      color: AppColors.accent,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Text(
                  isPerfect
                      ? 'Masya Allah! Sempurna!'
                      : 'Alhamdulillah, Selesai!',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: AppColors.primary,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),

                Text(
                  'Nilai akhir kamu:',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 20),

                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.accent, width: 3),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.workspace_premium_rounded,
                          color: AppColors.accent, size: 40),
                      const SizedBox(width: 10),
                      Text(
                        '${widget.score}',
                        style:
                            Theme.of(context).textTheme.displayLarge?.copyWith(
                                  color: AppColors.textDark,
                                ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Benar ${widget.correctCount} dari ${widget.totalQuestions} soal - +${widget.totalXp} XP',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 50),

                // Tombol Kembali
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      // Kembali ke halaman utama (buang semua history layar)
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainMenuScreen()),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    child: const Text(
                      'KEMBALI KE MENU',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
