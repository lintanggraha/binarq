import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/audio/audio_service.dart';
import '../providers/quiz_provider.dart';
import 'result_screen.dart';

// ─── Praise words ────────────────────────────────────────────────────────────
const _praises = [
  'Barakallah! 🌟',
  'Mumtaz! ✨',
  'Masya Allah! 💫',
  'Hebat! 🎉',
  'Luar Biasa! 🚀',
  'Keren Banget! ⭐',
];
const _comboPraises = ['COMBO! 🔥', 'ON FIRE! 🔥🔥', 'UNSTOPPABLE! 🔥🔥🔥'];

// ─── Main Screen ──────────────────────────────────────────────────────────────
class QuizScreen extends ConsumerStatefulWidget {
  const QuizScreen({super.key});
  @override
  ConsumerState<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen>
    with TickerProviderStateMixin {
  // Slide transition
  late final AnimationController _slideCtrl;
  late Animation<Offset> _slideAnim;
  int _questionKey = 0;

  // Praise overlay
  String? _praiseText;
  late final AnimationController _praiseCtrl;
  late final Animation<double> _praiseAnim;

  // Combo
  int _combo = 0;

  // Particles
  late final AnimationController _particleCtrl;

  // Shake for wrong
  late final AnimationController _shakeCtrl;
  late final Animation<double> _shakeAnim;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(audioServiceProvider).resumeBgm());

    _slideCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 380));
    _slideAnim = Tween<Offset>(begin: const Offset(1.2, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _slideCtrl, curve: Curves.easeOutCubic));
    _slideCtrl.forward();

    _praiseCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _praiseAnim = CurvedAnimation(parent: _praiseCtrl, curve: Curves.elasticOut);

    _shakeCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    _shakeAnim = Tween<double>(begin: 0, end: 1).animate(_shakeCtrl);

    _particleCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
  }

  @override
  void dispose() {
    _slideCtrl.dispose();
    _praiseCtrl.dispose();
    _shakeCtrl.dispose();
    _particleCtrl.dispose();
    super.dispose();
  }

  void _triggerNextQuestion() {
    ref.read(audioServiceProvider).playWhoosh();
    _slideCtrl.forward(from: 0);
    setState(() => _questionKey++);
  }

  void _triggerPraise(bool isCorrect) {
    if (isCorrect) {
      _combo++;
      if (_combo >= 3) {
        ref.read(audioServiceProvider).playCombo();
        HapticFeedback.heavyImpact();
      } else {
        HapticFeedback.lightImpact();
      }
      
      final idx = min(_combo - 1, _praises.length - 1);
      final text = _combo >= 3
          ? _comboPraises[min(_combo - 3, _comboPraises.length - 1)]
          : _praises[idx % _praises.length];
      setState(() => _praiseText = text);
      _particleCtrl.forward(from: 0);
      _praiseCtrl.forward(from: 0).then((_) {
        Future.delayed(const Duration(milliseconds: 900), () {
          if (mounted) {
            _praiseCtrl.reverse();
          }
        });
      });
    } else {
      _combo = 0;
      _shakeCtrl.forward(from: 0);
      HapticFeedback.vibrate();
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<QuizState>(quizNotifierProvider, (prev, next) {
      if (next.isFinished) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => ResultScreen(
              totalXp: next.xp,
              correctCount: next.correctCount,
              totalQuestions: next.totalQuestions,
              score: next.score,
            ),
          ),
        );
      }
      if (next.isAnswerChecked && prev?.isAnswerChecked == false) {
        final audio = ref.read(audioServiceProvider);
        if (next.isCorrect) {
          audio.playCorrectAnswer();
        } else {
          audio.playWrongAnswer();
        }
        _triggerPraise(next.isCorrect);
      }
      // Trigger slide on new question
      if (prev != null &&
          !prev.isAnswerChecked &&
          !next.isAnswerChecked &&
          prev.currentIndex != next.currentIndex) {
        _triggerNextQuestion();
      }
    });

    final state = ref.watch(quizNotifierProvider);
    final notifier = ref.read(quizNotifierProvider.notifier);

    if (state.isLoading) {
      return const Scaffold(
        body: _QuizBackground(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: AppColors.primary),
                SizedBox(height: 16),
                Text('Memuat soal...', style: TextStyle(color: AppColors.textLight)),
              ],
            ),
          ),
        ),
      );
    }

    final question = state.currentQuestion;
    if (question == null) {
      return const Scaffold(
        body: _QuizBackground(child: Center(child: Text('Kuis Selesai!'))),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          _QuizBackground(
            child: SafeArea(
              child: Column(
                children: [
                  // ── Top Bar ──────────────────────────────────────────────
                  _TopBar(state: state, combo: _combo),

                  // ── Question Card (slide transition) ─────────────────────
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          SlideTransition(
                            position: _slideAnim,
                            child: _QuestionCard(
                              key: ValueKey(_questionKey),
                              text: question.content.pertanyaan ?? '',
                            ),
                          ),
                          const SizedBox(height: 24),

                          // ── Answer Choices ──────────────────────────────
                          if (question.content.tipeSoal == 'isian')
                            _EssayAnswerField(
                              questionId: question.questionId,
                              enabled: !state.isAnswerChecked,
                              isChecked: state.isAnswerChecked,
                              isCorrect: state.isCorrect,
                              correctAnswer: question.content.jawabanBenar ?? '',
                              onChanged: notifier.selectAnswer,
                            )
                          else if (question.content.pilihan != null)
                            AnimatedBuilder(
                              animation: _shakeAnim,
                              builder: (context, child) {
                                final shake = state.isAnswerChecked && !state.isCorrect
                                    ? sin(_shakeAnim.value * pi * 6) * 6
                                    : 0.0;
                                return Transform.translate(
                                  offset: Offset(shake, 0),
                                  child: child,
                                );
                              },
                              child: Column(
                                children: question.content.pilihan!.map((p) {
                                  return _AnswerButton(
                                    key: ValueKey('${_questionKey}_${p.idPilihan}'),
                                    label: '${p.idPilihan}. ${p.teks ?? ''}',
                                    state: state,
                                    optionId: p.idPilihan ?? '',
                                    correctId: question.content.jawabanBenar ?? '',
                                    onTap: () {
                                      ref.read(audioServiceProvider).playButtonClick();
                                      notifier.selectAnswer(p.idPilihan!);
                                    },
                                  );
                                }).toList(),
                              ),
                            ),

                          // ── Explanation Box ─────────────────────────────
                          if (state.isAnswerChecked)
                            _ExplanationBox(
                              isCorrect: state.isCorrect,
                              explanation: state.isCorrect
                                  ? (question.feedback.penjelasanAnak ?? '')
                                  : 'Jawaban benar: ${_correctAnswerText(question)}',
                            ),

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),

                  // ── Action Button ─────────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    child: _ActionButton(
                      state: state,
                      onTap: () {
                        ref.read(audioServiceProvider).playButtonClick();
                        if (!state.isAnswerChecked) {
                          notifier.checkAnswer();
                        } else {
                          notifier.nextQuestion();
                          _triggerNextQuestion();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Praise Overlay ─────────────────────────────────────────────────
          if (_praiseText != null) ...[
            IgnorePointer(
              child: _CelebrationParticles(controller: _particleCtrl),
            ),
            IgnorePointer(
              child: Align(
                alignment: const Alignment(0, -0.3),
                child: ScaleTransition(
                  scale: _praiseAnim,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFFD166), Color(0xFFFF8C42)],
                      ),
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accent.withValues(alpha: 0.5),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Text(
                      _praiseText!,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
            ),

          // ── Combo Badge ────────────────────────────────────────────────────
          if (_combo >= 2)
            Positioned(
              top: 80,
              right: 20,
              child: _ComboBadge(combo: _combo),
            ),
        ],
      ),
    );
  }
}

// ─── Top Bar ──────────────────────────────────────────────────────────────────
class _TopBar extends StatelessWidget {
  final QuizState state;
  final int combo;
  const _TopBar({required this.state, required this.combo});

  @override
  Widget build(BuildContext context) {
    final progress = state.totalQuestions == 0
        ? 0.0
        : state.questionNumber / state.totalQuestions;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        children: [
          Row(
            children: [
              // XP Badge (bouncy on change)
              TweenAnimationBuilder<double>(
                key: ValueKey(state.xp),
                tween: Tween(begin: 1.2, end: 1.0),
                duration: const Duration(milliseconds: 300),
                curve: Curves.elasticOut,
                builder: (_, scale, child) =>
                    Transform.scale(scale: scale, child: child),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.accent, width: 1.5),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.bolt_rounded, color: AppColors.accent, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        '${state.xp} XP',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.accent,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              // Question counter
              Text(
                '${state.questionNumber} / ${state.totalQuestions}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // ── Adventure Progress Bar ──
          SizedBox(
            height: 36,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final barWidth = constraints.maxWidth;
                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: progress),
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOutCubic,
                  builder: (_, value, __) {
                    final runnerX = value * (barWidth - 30);
                    return Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        // Track background
                        Container(
                          height: 12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.black.withValues(alpha: 0.08),
                          ),
                        ),
                        // Filled track
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 12,
                          width: value * barWidth,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: LinearGradient(
                              colors: combo >= 3
                                  ? [const Color(0xFFFF6B35), AppColors.secondary]
                                  : [AppColors.primary, const Color(0xFF06D6A0)],
                            ),
                          ),
                        ),
                        // Runner character
                        Positioned(
                          left: runnerX.clamp(0, barWidth - 30),
                          child: TweenAnimationBuilder<double>(
                            key: ValueKey(state.questionNumber),
                            tween: Tween(begin: -3.0, end: 0.0),
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.bounceOut,
                            builder: (_, bounce, child) =>
                                Transform.translate(
                                    offset: Offset(0, bounce), child: child),
                            child: const Text('🏃', style: TextStyle(fontSize: 22)),
                          ),
                        ),
                        // Finish flag
                        Positioned(
                          right: 0,
                          child: Text(
                            value >= 0.95 ? '🏆' : '🏁',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


// ─── Question Card ────────────────────────────────────────────────────────────
class _QuestionCard extends StatelessWidget {
  final String text;
  const _QuestionCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.12),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 18,
              height: 1.6,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

// ─── Bouncy Answer Button ─────────────────────────────────────────────────────
class _AnswerButton extends StatefulWidget {
  final String label;
  final String optionId;
  final String correctId;
  final QuizState state;
  final VoidCallback onTap;

  const _AnswerButton({
    super.key,
    required this.label,
    required this.optionId,
    required this.correctId,
    required this.state,
    required this.onTap,
  });

  @override
  State<_AnswerButton> createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<_AnswerButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scaleCtrl;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _scaleCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 120));
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.93).animate(
        CurvedAnimation(parent: _scaleCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _scaleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSelected = widget.state.selectedAnswerId == widget.optionId;
    final isChecked = widget.state.isAnswerChecked;

    Color bgColor = Colors.white;
    Color borderColor = Colors.black12;
    Color textColor = AppColors.textDark;
    IconData? icon;

    if (isChecked) {
      if (widget.optionId == widget.correctId) {
        bgColor = AppColors.success.withValues(alpha: 0.12);
        borderColor = AppColors.success;
        textColor = AppColors.success;
        icon = Icons.check_circle_rounded;
      } else if (isSelected) {
        bgColor = AppColors.error.withValues(alpha: 0.12);
        borderColor = AppColors.error;
        textColor = AppColors.error;
        icon = Icons.cancel_rounded;
      }
    } else if (isSelected) {
      bgColor = AppColors.primary.withValues(alpha: 0.1);
      borderColor = AppColors.primary;
      textColor = AppColors.primaryDark;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTapDown: (_) {
          if (!isChecked) _scaleCtrl.forward();
        },
        onTapUp: (_) {
          _scaleCtrl.reverse();
          if (!isChecked) widget.onTap();
        },
        onTapCancel: () => _scaleCtrl.reverse(),
        child: ScaleTransition(
          scale: _scaleAnim,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: borderColor, width: 2),
              boxShadow: isSelected && !isChecked
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.2),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      )
                    ]
                  : [],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.label,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      color: textColor,
                      height: 1.4,
                    ),
                  ),
                ),
                if (icon != null) ...[
                  const SizedBox(width: 8),
                  Icon(icon, color: textColor, size: 22),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Explanation Box ──────────────────────────────────────────────────────────
class _ExplanationBox extends StatelessWidget {
  final bool isCorrect;
  final String explanation;
  const _ExplanationBox({required this.isCorrect, required this.explanation});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutBack,
      builder: (_, v, child) => Transform.scale(scale: v, child: child),
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isCorrect
              ? AppColors.success.withValues(alpha: 0.1)
              : AppColors.accent.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isCorrect ? AppColors.success : AppColors.secondary,
            width: 2,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              isCorrect ? Icons.auto_awesome_rounded : Icons.lightbulb_rounded,
              color: isCorrect ? AppColors.success : AppColors.secondary,
              size: 22,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                explanation,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: isCorrect ? AppColors.success : AppColors.textDark,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Action Button ────────────────────────────────────────────────────────────
class _ActionButton extends StatelessWidget {
  final QuizState state;
  final VoidCallback onTap;
  const _ActionButton({required this.state, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final canAct = state.selectedAnswerId != null;
    final label = state.isAnswerChecked ? 'LANJUT →' : 'CEK JAWABAN';
    final color = state.isAnswerChecked ? AppColors.primary : AppColors.secondary;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: canAct ? color : Colors.grey.shade300,
        boxShadow: canAct
            ? [
                BoxShadow(
                  color: color.withValues(alpha: 0.4),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                )
              ]
            : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: canAct ? onTap : null,
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: canAct ? Colors.white : Colors.grey,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Combo Badge ──────────────────────────────────────────────────────────────
class _ComboBadge extends StatelessWidget {
  final int combo;
  const _ComboBadge({required this.combo});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      key: ValueKey(combo),
      tween: Tween(begin: 0.5, end: 1.0),
      duration: const Duration(milliseconds: 300),
      curve: Curves.elasticOut,
      builder: (_, v, child) => Transform.scale(scale: v, child: child),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('🔥', style: TextStyle(fontSize: 16)),
            const SizedBox(width: 4),
            Text(
              'x$combo',
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Essay Field ──────────────────────────────────────────────────────────────
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
  late final TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController();
  }

  @override
  void didUpdateWidget(covariant _EssayAnswerField old) {
    super.didUpdateWidget(old);
    if (old.questionId != widget.questionId) _ctrl.clear();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = widget.isChecked
        ? (widget.isCorrect ? AppColors.success : AppColors.error)
        : AppColors.primary.withValues(alpha: 0.45);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _ctrl,
          enabled: widget.enabled,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'Tulis jawaban singkat di sini...',
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: borderColor, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide:
                  const BorderSide(color: AppColors.primary, width: 2),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: borderColor, width: 2),
            ),
          ),
        ),
        if (widget.isChecked && !widget.isCorrect) ...[
          const SizedBox(height: 10),
          Text(
            'Jawaban benar: ${widget.correctAnswer}',
            style: const TextStyle(
              color: AppColors.error,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ],
    );
  }
}

// ─── Background ───────────────────────────────────────────────────────────────
class _CelebrationParticles extends StatelessWidget {
  final AnimationController controller;
  const _CelebrationParticles({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) => CustomPaint(
        size: MediaQuery.of(context).size,
        painter: _ParticlePainter(progress: controller.value),
      ),
    );
  }
}

class _ParticlePainter extends CustomPainter {
  final double progress;
  _ParticlePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    if (progress == 0 || progress == 1) return;
    
    final rng = Random(123);
    final center = Offset(size.width / 2, size.height * 0.35);
    final colors = [AppColors.accent, AppColors.secondary, AppColors.success, Colors.white];

    for (var i = 0; i < 30; i++) {
      final angle = rng.nextDouble() * 2 * pi;
      final speed = 100 + rng.nextDouble() * 200;
      final radius = speed * progress;
      final opacity = (1.0 - progress).clamp(0.0, 1.0);
      
      final pos = center + Offset(cos(angle) * radius, sin(angle) * radius);
      
      final paint = Paint()..color = colors[i % colors.length].withValues(alpha: opacity);
      canvas.drawCircle(pos, 3 + rng.nextDouble() * 4, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter old) => old.progress != progress;
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
          colors: [Color(0xFFE3FAFF), Color(0xFFFFF7D6), Color(0xFFFFE8F0)],
        ),
      ),
      child: child,
    );
  }
}

// ─── Helper ───────────────────────────────────────────────────────────────────
String _correctAnswerText(dynamic question) {
  final correctId = question.content.jawabanBenar;
  if (question.content.tipeSoal == 'isian') return correctId ?? '';
  for (final o in question.content.pilihan ?? []) {
    if (o.idPilihan == correctId) return o.teks ?? correctId ?? '';
  }
  return correctId ?? '';
}
