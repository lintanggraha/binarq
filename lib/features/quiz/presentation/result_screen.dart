import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/audio/audio_service.dart';
import '../../../main.dart';
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

class _ResultScreenState extends ConsumerState<ResultScreen>
    with TickerProviderStateMixin {
  // ── Counting animations ──
  late final AnimationController _countCtrl;
  late final Animation<double> _scoreCount;
  late final Animation<double> _xpCount;

  // ── Entrance animations ──
  late final AnimationController _entranceCtrl;
  late final Animation<double> _titleSlide;
  late final Animation<double> _cardScale;
  late final Animation<double> _statsSlide;
  late final Animation<double> _buttonSlide;

  // ── Star rating ──
  late final AnimationController _starCtrl;

  // ── Confetti ──
  late final AnimationController _confettiCtrl;

  @override
  void initState() {
    super.initState();
    ref.read(audioServiceProvider).playLevelUp();

    // Backup progress
    Future.microtask(() {
      final activeProfile = ref.read(profileNotifierProvider);
      if (activeProfile != null) {
        ref.read(profileNotifierProvider.notifier).updateXp(widget.totalXp);
        ref.read(supabaseSyncProvider).backupProfileProgress(
              activeProfile.id,
              activeProfile.totalXp + widget.totalXp,
              activeProfile.grade,
            );
      }
    });

    // ── Count up animation ──
    _countCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1400));
    _scoreCount = Tween<double>(begin: 0, end: widget.score.toDouble())
        .animate(CurvedAnimation(parent: _countCtrl, curve: Curves.easeOutCubic));
    _xpCount = Tween<double>(begin: 0, end: widget.totalXp.toDouble())
        .animate(CurvedAnimation(parent: _countCtrl, curve: Curves.easeOutCubic));

    // ── Entrance stagger ──
    _entranceCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    _titleSlide = CurvedAnimation(
        parent: _entranceCtrl,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOutBack));
    _cardScale = CurvedAnimation(
        parent: _entranceCtrl,
        curve: const Interval(0.2, 0.6, curve: Curves.elasticOut));
    _statsSlide = CurvedAnimation(
        parent: _entranceCtrl,
        curve: const Interval(0.4, 0.75, curve: Curves.easeOutCubic));
    _buttonSlide = CurvedAnimation(
        parent: _entranceCtrl,
        curve: const Interval(0.6, 1.0, curve: Curves.easeOutCubic));

    // ── Star rating ──
    _starCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1600));

    // ── Confetti ──
    _confettiCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));

    // Start sequence
    Future.delayed(const Duration(milliseconds: 200), () {
      if (!mounted) return;
      _entranceCtrl.forward();
      Future.delayed(const Duration(milliseconds: 500), () {
        if (!mounted) return;
        _countCtrl.forward();
        _starCtrl.forward();
        if (widget.score >= 60) _confettiCtrl.forward();
      });
    });
  }

  @override
  void dispose() {
    _countCtrl.dispose();
    _entranceCtrl.dispose();
    _starCtrl.dispose();
    _confettiCtrl.dispose();
    super.dispose();
  }

  int get _starCount {
    if (widget.score >= 100) return 3;
    if (widget.score >= 70) return 2;
    if (widget.score >= 40) return 1;
    return 0;
  }

  String get _titleText {
    if (widget.score >= 100) return 'Masya Allah! Sempurna!';
    if (widget.score >= 80) return 'Barakallah, Hebat!';
    if (widget.score >= 60) return 'Alhamdulillah, Bagus!';
    if (widget.score >= 40) return 'Tetap Semangat!';
    return 'Jangan Menyerah!';
  }

  String get _subtitleText {
    if (widget.score >= 100) return 'Kamu menjawab semua soal dengan benar!';
    if (widget.score >= 80) return 'Kamu sudah memahami materi ini!';
    if (widget.score >= 60) return 'Tinggal sedikit lagi jadi bintang!';
    return 'Ayo ulangi lagi, pasti bisa!';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ── Background ──
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFFF8E1),
                  Color(0xFFE3FAFF),
                  Color(0xFFFFE8F0),
                ],
              ),
            ),
          ),

          // ── Confetti overlay ──
          if (widget.score >= 60)
            AnimatedBuilder(
              animation: _confettiCtrl,
              builder: (context, _) => CustomPaint(
                size: MediaQuery.of(context).size,
                painter: _ConfettiPainter(progress: _confettiCtrl.value),
              ),
            ),

          // ── Content ──
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ── Trophy icon ──
                    FadeTransition(
                      opacity: _titleSlide,
                      child: ScaleTransition(
                        scale: _titleSlide,
                        child: _TrophyIcon(score: widget.score),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ── Title ──
                    FadeTransition(
                      opacity: _titleSlide,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.3),
                          end: Offset.zero,
                        ).animate(_titleSlide),
                        child: Column(
                          children: [
                            Text(
                              _titleText,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                color: AppColors.textDark,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _subtitleText,
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppColors.textLight,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // ── Score Card ──
                    ScaleTransition(
                      scale: _cardScale,
                      child: _ScoreCard(
                        scoreAnim: _scoreCount,
                        xpAnim: _xpCount,
                        countCtrl: _countCtrl,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ── Star Rating ──
                    FadeTransition(
                      opacity: _statsSlide,
                      child: _StarRating(
                        starCount: _starCount,
                        controller: _starCtrl,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ── Stats Row ──
                    FadeTransition(
                      opacity: _statsSlide,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.5),
                          end: Offset.zero,
                        ).animate(_statsSlide),
                        child: _StatsRow(
                          correctCount: widget.correctCount,
                          totalQuestions: widget.totalQuestions,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // ── Button ──
                    FadeTransition(
                      opacity: _buttonSlide,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.6),
                          end: Offset.zero,
                        ).animate(_buttonSlide),
                        child: _BackButton(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const MainMenuScreen()),
                              (route) => false,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Trophy Icon ──────────────────────────────────────────────────────────────
class _TrophyIcon extends StatelessWidget {
  final int score;
  const _TrophyIcon({required this.score});

  @override
  Widget build(BuildContext context) {
    final color = score >= 80
        ? AppColors.accent
        : score >= 60
            ? AppColors.primary
            : AppColors.secondary;

    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color.withValues(alpha: 0.3),
            color.withValues(alpha: 0.05),
          ],
        ),
      ),
      child: Icon(
        score >= 80
            ? Icons.emoji_events_rounded
            : score >= 60
                ? Icons.star_rounded
                : Icons.favorite_rounded,
        size: 72,
        color: color,
      ),
    );
  }
}

// ─── Score Card with counting animation ───────────────────────────────────────
class _ScoreCard extends StatelessWidget {
  final Animation<double> scoreAnim;
  final Animation<double> xpAnim;
  final AnimationController countCtrl;

  const _ScoreCard({
    required this.scoreAnim,
    required this.xpAnim,
    required this.countCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.12),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: AnimatedBuilder(
        animation: countCtrl,
        builder: (context, _) => Column(
          children: [
            // Score number (big)
            Text(
              '${scoreAnim.value.round()}',
              style: const TextStyle(
                fontSize: 72,
                fontWeight: FontWeight.w900,
                color: AppColors.textDark,
                height: 1.0,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'NILAI',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.textLight,
                letterSpacing: 3,
              ),
            ),
            const SizedBox(height: 16),
            // XP earned
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: AppColors.accent.withValues(alpha: 0.5),
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.bolt_rounded,
                      color: AppColors.accent, size: 22),
                  const SizedBox(width: 6),
                  Text(
                    '+ ${xpAnim.value.round()} XP',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Star Rating ──────────────────────────────────────────────────────────────
class _StarRating extends StatelessWidget {
  final int starCount;
  final AnimationController controller;

  const _StarRating({required this.starCount, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (i) {
        final delay = 0.15 + (i * 0.2);
        final end = delay + 0.35;
        final anim = CurvedAnimation(
          parent: controller,
          curve: Interval(delay.clamp(0.0, 1.0), end.clamp(0.0, 1.0),
              curve: Curves.elasticOut),
        );

        final filled = i < starCount;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: ScaleTransition(
            scale: anim,
            child: Icon(
              filled ? Icons.star_rounded : Icons.star_outline_rounded,
              size: 52,
              color: filled
                  ? AppColors.accent
                  : AppColors.textLight.withValues(alpha: 0.3),
            ),
          ),
        );
      }),
    );
  }
}

// ─── Stats Row ────────────────────────────────────────────────────────────────
class _StatsRow extends StatelessWidget {
  final int correctCount;
  final int totalQuestions;

  const _StatsRow({
    required this.correctCount,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _StatChip(
          icon: Icons.check_circle_rounded,
          color: AppColors.success,
          label: '$correctCount Benar',
        ),
        const SizedBox(width: 12),
        _StatChip(
          icon: Icons.cancel_rounded,
          color: AppColors.error,
          label: '${totalQuestions - correctCount} Salah',
        ),
        const SizedBox(width: 12),
        _StatChip(
          icon: Icons.quiz_rounded,
          color: AppColors.primary,
          label: '$totalQuestions Soal',
        ),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;

  const _StatChip({
    required this.icon,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Back Button ──────────────────────────────────────────────────────────────
class _BackButton extends StatelessWidget {
  final VoidCallback onTap;
  const _BackButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [AppColors.primary, AppColors.primaryDark],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.4),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: onTap,
            child: const Center(
              child: Text(
                'KEMBALI KE MENU',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Confetti Painter ─────────────────────────────────────────────────────────
class _ConfettiPainter extends CustomPainter {
  final double progress;
  _ConfettiPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final rng = Random(42);
    final colors = [
      AppColors.accent,
      AppColors.primary,
      AppColors.secondary,
      AppColors.success,
      AppColors.error,
      const Color(0xFF8338EC),
    ];

    for (var i = 0; i < 50; i++) {
      final x = rng.nextDouble() * size.width;
      final startY = -20.0 - rng.nextDouble() * 100;
      final endY = size.height + 40;
      final y = startY + (endY - startY) * progress;
      final drift = sin(progress * pi * 4 + i) * 30;
      final rotation = progress * pi * 4 * (i.isEven ? 1 : -1);

      final paint = Paint()
        ..color = colors[i % colors.length].withValues(
            alpha: (1.0 - progress).clamp(0.0, 0.8));

      canvas.save();
      canvas.translate(x + drift, y);
      canvas.rotate(rotation);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset.zero,
            width: 6 + rng.nextDouble() * 8,
            height: 4 + rng.nextDouble() * 4,
          ),
          const Radius.circular(2),
        ),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter old) =>
      old.progress != progress;
}
