import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/audio/audio_service.dart';
import '../providers/quiz_provider.dart';
import 'result_screen.dart';

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
        body: _QuizBackground(
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    final question = quizState.currentQuestion;
    if (question == null) {
      return const Scaffold(
        body: _QuizBackground(
          child: Center(child: Text('Kuis Selesai!')),
        ),
      );
    }

    return Scaffold(
      body: _QuizBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Top Bar (XP & Nyawa)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _StatusBadge(
                      label: '${quizState.xp} XP',
                      color: AppColors.accent,
                    ),
                    _StatusBadge(
                      label: '${quizState.lives}/5 Nyawa',
                      color: AppColors.error,
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
                      const SizedBox(height: 24),

                      // Kotak Soal
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
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
                          final isSelected =
                              quizState.selectedAnswerId == p.idPilihan;

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
                            btnColor = AppColors.primary.withValues(alpha: 0.2);
                          }

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: InkWell(
                              onTap: () {
                                ref
                                    .read(audioServiceProvider)
                                    .playButtonClick();
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
                                    color:
                                        isSelected && !quizState.isAnswerChecked
                                            ? AppColors.primary
                                            : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                child: Text(
                                  p.teks ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: textColor,
                                      ),
                                ),
                              ),
                            ),
                          );
                        }),

                      // Kotak Penjelasan / Hint (Muncul setelah dijawab)
                      if (quizState.isAnswerChecked || quizState.isSecondChance)
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: quizState.isCorrect
                                ? AppColors.success.withValues(alpha: 0.1)
                                : AppColors.accent.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: quizState.isCorrect
                                  ? AppColors.success
                                  : AppColors.accent,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    quizState.isCorrect
                                        ? Icons.check_circle
                                        : Icons.lightbulb,
                                    color: quizState.isCorrect
                                        ? AppColors.success
                                        : AppColors.secondary,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    quizState.isCorrect
                                        ? 'Masya Allah, Benar!'
                                        : 'Hint:',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: quizState.isCorrect
                                              ? AppColors.success
                                              : AppColors.secondary,
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
                      backgroundColor: quizState.isAnswerChecked
                          ? AppColors.primary
                          : AppColors.secondary,
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
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusBadge({
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withValues(alpha: 0.6), width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.18),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: color),
      ),
    );
  }
}

class _QuizBackground extends StatelessWidget {
  final Widget child;

  const _QuizBackground({required this.child});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFE3FAFF),
            Color(0xFFFFF7D6),
            Color(0xFFFFE8F0),
          ],
        ),
      ),
      child: CustomPaint(
        painter: _QuizPatternPainter(),
        child: child,
      ),
    );
  }
}

class _QuizPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = AppColors.primary.withValues(alpha: 0.12);

    for (var i = 0; i < 8; i++) {
      final y = size.height * (i + 1) / 9;
      final path = Path()..moveTo(0, y);
      for (var x = 0.0; x <= size.width; x += 36) {
        path.quadraticBezierTo(x + 18, y + (i.isEven ? 10 : -10), x + 36, y);
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
