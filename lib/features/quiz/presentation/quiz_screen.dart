import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/audio/audio_service.dart';
import '../providers/quiz_provider.dart';
import 'result_screen.dart';
import 'widgets/mascot_reaction.dart';

class QuizScreen extends ConsumerWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mendengarkan perubahan state untuk navigasi
    ref.listen<QuizState>(quizNotifierProvider, (previous, next) {
      if (next.isFinished) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              totalXp: next.xp,
              sisaNyawa: next.lives,
            ),
          ),
        );
      }

      // Membunyikan suara saat jawaban dicek
      if (next.isAnswerChecked && previous?.isAnswerChecked == false) {
        if (next.isCorrect) {
          ref.read(audioServiceProvider).playCorrectAnswer();
        } else {
          ref.read(audioServiceProvider).playWrongAnswer();
        }
      }
    });

    final quizState = ref.watch(quizNotifierProvider);
    final quizNotifier = ref.read(quizNotifierProvider.notifier);

    if (quizState.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final question = quizState.currentQuestion;
    if (question == null) {
      return const Scaffold(
        body: Center(child: Text('Kuis Selesai!')),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar (XP & Nyawa)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: AppColors.accent, size: 32),
                      const SizedBox(width: 8),
                      Text(
                        '${quizState.xp} XP',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(
                        index < quizState.lives ? Icons.favorite : Icons.favorite_border,
                        color: AppColors.error,
                        size: 32,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Area Pertanyaan
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    
                    // Area Animasi Maskot
                    MascotReaction(state: quizState),
                    const SizedBox(height: 10),

                    // Kotak Soal
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Text(
                        question.content.pertanyaan ?? '',
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Pilihan Jawaban
                    if (question.content.pilihan != null)
                      ...question.content.pilihan!.map((p) {
                        final isSelected = quizState.selectedAnswerId == p.idPilihan;
                        
                        // Menentukan warna tombol berdasarkan status jawaban
                        Color btnColor = AppColors.surface;
                        Color textColor = AppColors.textDark;
                        
                        if (quizState.isAnswerChecked) {
                          if (p.idPilihan == question.content.jawabanBenar) {
                            btnColor = AppColors.success;
                            textColor = Colors.white;
                          } else if (isSelected) {
                            btnColor = AppColors.error;
                            textColor = Colors.white;
                          }
                        } else if (isSelected) {
                          btnColor = AppColors.primary.withOpacity(0.2);
                        }

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: InkWell(
                            onTap: () {
                              ref.read(audioServiceProvider).playButtonClick();
                              quizNotifier.selectAnswer(p.idPilihan!);
                            },
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: btnColor,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isSelected && !quizState.isAnswerChecked 
                                      ? AppColors.primary 
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: Text(
                                p.teks ?? '',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: textColor,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),

                    // Kotak Penjelasan / Hint (Muncul setelah dijawab)
                    if (quizState.isAnswerChecked || quizState.isSecondChance)
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: quizState.isCorrect ? AppColors.success.withOpacity(0.1) : AppColors.accent.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: quizState.isCorrect ? AppColors.success : AppColors.accent,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  quizState.isCorrect ? Icons.check_circle : Icons.lightbulb,
                                  color: quizState.isCorrect ? AppColors.success : AppColors.secondary,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  quizState.isCorrect ? 'Masya Allah, Benar!' : 'Hint dari Maskot:',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: quizState.isCorrect ? AppColors.success : AppColors.secondary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              quizState.isCorrect 
                                  ? question.feedback.penjelasanAnak ?? ''
                                  : question.feedback.hint ?? '',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Tombol Konfirmasi / Lanjut
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: quizState.selectedAnswerId == null
                      ? null
                      : () {
                          ref.read(audioServiceProvider).playButtonClick();
                          if (!quizState.isAnswerChecked) {
                            quizNotifier.checkAnswer();
                          } else {
                            quizNotifier.nextQuestion();
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: quizState.isAnswerChecked ? AppColors.primary : AppColors.secondary,
                  ),
                  child: Text(
                    !quizState.isAnswerChecked ? 'CEK JAWABAN' : 'LANJUT',
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
