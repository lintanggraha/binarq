import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/audio/audio_service.dart';
import '../../quiz/presentation/quiz_screen.dart';
import '../../quiz/providers/quiz_provider.dart';
import '../../profile/providers/profile_provider.dart';

class SubjectSelectionScreen extends ConsumerWidget {
  const SubjectSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeProfile = ref.watch(profileNotifierProvider);

    final List<Map<String, dynamic>> subjects = [
      {
        'id': 'MTK',
        'name': 'Matematika',
        'icon': Icons.calculate,
        'color': const Color(0xFFFF9F1C),
        'desc': 'Bilangan, pengukuran, dan logika',
      },
      {
        'id': 'PAI',
        'name': 'Agama Islam',
        'icon': Icons.mosque,
        'color': const Color(0xFF2EC4B6),
        'desc': 'Akidah, akhlak, fikih, dan sirah',
      },
      {
        'id': 'QURAN',
        'name': 'Al-Qur\'an',
        'icon': Icons.menu_book,
        'color': const Color(0xFF3A86FF),
        'desc': 'Tahsin, tahfidz, dan adab tilawah',
      },
      {
        'id': 'ARB',
        'name': 'Bahasa Arab',
        'icon': Icons.translate,
        'color': const Color(0xFF8338EC),
        'desc': 'Mufradat dan kalimat sederhana',
      },
      {
        'id': 'BIND',
        'name': 'Bahasa Indonesia',
        'icon': Icons.record_voice_over,
        'color': const Color(0xFFEF476F),
        'desc': 'Membaca, menulis, dan menyimak',
      },
      {
        'id': 'IPAS',
        'name': 'IPAS',
        'icon': Icons.public,
        'color': const Color(0xFFE71D36),
        'desc': 'Alam, tubuh, energi, dan masyarakat',
      },
      {
        'id': 'PPKN',
        'name': 'Pancasila',
        'icon': Icons.flag,
        'color': const Color(0xFF06D6A0),
        'desc': 'Aturan, gotong royong, dan NKRI',
      },
      {
        'id': 'BIG',
        'name': 'Bahasa Inggris',
        'icon': Icons.language,
        'color': const Color(0xFF118AB2),
        'desc': 'Kosakata dan ungkapan sehari-hari',
      },
      {
        'id': 'PJOK',
        'name': 'PJOK',
        'icon': Icons.sports_soccer,
        'color': const Color(0xFF8AC926),
        'desc': 'Gerak, kebugaran, dan kesehatan',
      },
      {
        'id': 'SBDP',
        'name': 'Seni Budaya',
        'icon': Icons.palette,
        'color': const Color(0xFFFF595E),
        'desc': 'Rupa, musik, tari, dan karya kreatif',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Pelajaran', style: Theme.of(context).textTheme.headlineLarge),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textDark),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                'Siap berpetualang hari ini, ${activeProfile?.name.split(' ').first ?? 'Teman'}?',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ListView.builder(
                  itemCount: subjects.length,
                  itemBuilder: (context, index) {
                    final subject = subjects[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: InkWell(
                        onTap: () {
                          // Bunyikan SFX klik
                          ref.read(audioServiceProvider).playButtonClick();
                          
                          // Simpan Mapel yang dipilih ke state
                          ref.read(selectedSubjectProvider.notifier).state = subject['id'];
                          
                          // Lanjut ke Kuis
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const QuizScreen()),
                          );
                        },
                        borderRadius: BorderRadius.circular(24),
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: subject['color'],
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: (subject['color'] as Color).withOpacity(0.4),
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
                                  color: Colors.white.withOpacity(0.3),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(subject['icon'], size: 40, color: Colors.white),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      subject['name'],
                                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                        color: Colors.white,
                                        fontSize: 28,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      subject['desc'],
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: Colors.white.withOpacity(0.9),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.arrow_forward_ios, color: Colors.white),
                            ],
                          ),
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
