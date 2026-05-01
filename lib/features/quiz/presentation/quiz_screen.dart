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

                      if (question.content.tipeSoal == 'isian')
                        _EssayAnswerField(
                          questionId: question.questionId,
                          enabled: !quizState.isAnswerChecked,
                          isChecked: quizState.isAnswerChecked,
                          isCorrect: quizState.isCorrect,
                          correctAnswer: question.content.jawabanBenar ?? '',
                          onChanged: quizNotifier.selectAnswer,
                        ),

                      // Pilihan Jawaban
                      if (question.content.tipeSoal != 'isian' &&
                          question.content.pilihan != null)
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

class _EssayAnswerField extends StatefulWidget {
  final String questionId;
  final bool enabled;
  final bool isChecked;
  final bool isCorrect;
  final String correctAnswer;
  final ValueChanged<String> onChanged;

  const _EssayAnswerField({
    required this.questionId,
    required this.enabled,
    required this.isChecked,
    required this.isCorrect,
    required this.correctAnswer,
    required this.onChanged,
  });

  @override
  State<_EssayAnswerField> createState() => _EssayAnswerFieldState();
}

class _EssayAnswerFieldState extends State<_EssayAnswerField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void didUpdateWidget(covariant _EssayAnswerField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.questionId != widget.questionId) {
      _controller.clear();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = widget.isChecked
        ? widget.isCorrect
            ? AppColors.success
            : AppColors.error
        : AppColors.primary.withValues(alpha: 0.45);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _controller,
          enabled: widget.enabled,
          onChanged: widget.onChanged,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'Tulis jawaban singkat',
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: borderColor, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: borderColor, width: 2),
            ),
          ),
        ),
        if (widget.isChecked && !widget.isCorrect) ...[
          const SizedBox(height: 12),
          Text(
            'Jawaban benar: ${widget.correctAnswer}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.error,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ],
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
