import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/audio/audio_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../quiz/presentation/quiz_screen.dart';
import '../../quiz/providers/quiz_provider.dart';

class ExamSelectionScreen extends ConsumerWidget {
  const ExamSelectionScreen({super.key});

  static const _examTypes = [
    {
      'title': 'Sumatif Awal',
      'subtitle': 'Latihan awal semester',
      'category': 'Sumatif Awal Semester',
      'icon': Icons.flag_circle,
      'color': Color(0xFFFF9F1C),
    },
    {
      'title': 'Sumatif Tengah',
      'subtitle': 'Persiapan tengah semester',
      'category': 'Sumatif Tengah Semester',
      'icon': Icons.route,
      'color': Color(0xFF2EC4B6),
    },
    {
      'title': 'Sumatif Akhir',
      'subtitle': 'Tantangan akhir semester',
      'category': 'Sumatif Akhir Tahun',
      'icon': Icons.emoji_events,
      'color': Color(0xFF3A86FF),
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pilih Sumatif',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textDark),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                'Mau latihan yang mana dulu?',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ListView.separated(
                  itemCount: _examTypes.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    final exam = _examTypes[index];
                    final color = exam['color'] as Color;

                    return InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () {
                        ref.read(audioServiceProvider).playButtonClick();
                        ref.read(audioServiceProvider).playWhoosh();
                        ref.read(selectedExamCategoryProvider.notifier).state =
                            exam['category'] as String;

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const QuizScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: color.withValues(alpha: 0.35),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.25),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                exam['icon'] as IconData,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    exam['title'] as String,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontSize: 28,
                                        ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    exam['subtitle'] as String,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: Colors.white
                                              .withValues(alpha: 0.9),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
