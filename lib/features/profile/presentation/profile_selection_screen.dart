import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/audio/audio_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../main.dart';
import '../models/profile.dart';
import '../providers/profile_provider.dart';
import 'widgets/profile_avatar.dart';

class ProfileSelectionScreen extends ConsumerStatefulWidget {
  const ProfileSelectionScreen({super.key});

  @override
  ConsumerState<ProfileSelectionScreen> createState() =>
      _ProfileSelectionScreenState();
}

class _ProfileSelectionScreenState
    extends ConsumerState<ProfileSelectionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  String _gender = 'Laki-laki';
  int _age = 7;
  int _grade = 1;
  bool? _showForm; // null means we haven't decided yet based on profiles count

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(audioServiceProvider).resumeBgm();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(profileNotifierProvider);
    final profileNotifier = ref.read(profileNotifierProvider.notifier);
    final profiles = profileNotifier.availableProfiles;
    
    // Tentukan tampilan awal jika belum diatur
    final shouldShowForm = _showForm ?? profiles.isEmpty;

    return Scaffold(
      body: _CheerfulBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      shouldShowForm
                          ? 'Buat Profil Belajar'
                          : 'Siapa yang mau belajar?',
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                color: AppColors.textDark,
                              ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      shouldShowForm
                          ? 'Isi data anak dulu, nanti kuisnya menyesuaikan kelas.'
                          : 'Pilih profil atau tambah teman belajar baru.',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    if (shouldShowForm)
                      _ProfileForm(
                        formKey: _formKey,
                        nameController: _nameController,
                        gender: _gender,
                        age: _age,
                        grade: _grade,
                        canCancel: profiles.isNotEmpty,
                        onGenderChanged: (value) =>
                            setState(() => _gender = value),
                        onAgeChanged: (value) => setState(() => _age = value),
                        onGradeChanged: (value) =>
                            setState(() => _grade = value),
                        onCancel: () {
                          ref.read(audioServiceProvider).playButtonClick();
                          setState(() => _showForm = false);
                        },
                        onSubmit: () {
                          if (!_formKey.currentState!.validate()) return;

                          ref.read(audioServiceProvider).playButtonClick();
                          profileNotifier.addProfile(
                            name: _nameController.text,
                            gender: _gender,
                            age: _age,
                            grade: _grade,
                          );

                          ref.read(audioServiceProvider).playWhoosh();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainMenuScreen(),
                            ),
                          );
                        },
                      )
                    else
                      _ProfileGrid(
                        profiles: profiles,
                        onSelect: (profile) {
                          ref.read(audioServiceProvider).playButtonClick();
                          profileNotifier.selectProfile(profile);
                          ref.read(audioServiceProvider).playWhoosh();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainMenuScreen(),
                            ),
                          );
                        },
                        onCreate: () {
                          ref.read(audioServiceProvider).playButtonClick();
                          setState(() {
                            _nameController.clear();
                            _gender = 'Laki-laki';
                            _age = 7;
                            _grade = 1;
                            _showForm = true;
                          });
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final String gender;
  final int age;
  final int grade;
  final bool canCancel;
  final ValueChanged<String> onGenderChanged;
  final ValueChanged<int> onAgeChanged;
  final ValueChanged<int> onGradeChanged;
  final VoidCallback onCancel;
  final VoidCallback onSubmit;

  const _ProfileForm({
    required this.formKey,
    required this.nameController,
    required this.gender,
    required this.age,
    required this.grade,
    required this.canCancel,
    required this.onGenderChanged,
    required this.onAgeChanged,
    required this.onGradeChanged,
    required this.onCancel,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.18),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: nameController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Nama',
                prefixIcon: Icon(Icons.badge_outlined),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nama wajib diisi';
                }
                return null;
              },
            ),
            const SizedBox(height: 18),
            Text('Jenis Kelamin',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            _GenderSelector(
              value: gender,
              onChanged: onGenderChanged,
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<int>(
                    initialValue: age,
                    decoration: const InputDecoration(
                      labelText: 'Usia',
                      prefixIcon: Icon(Icons.cake_outlined),
                    ),
                    items: [
                      for (var value = 5; value <= 13; value++)
                        DropdownMenuItem(
                          value: value,
                          child: Text('$value tahun'),
                        ),
                    ],
                    onChanged: (value) {
                      if (value != null) onAgeChanged(value);
                    },
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    initialValue: grade,
                    decoration: const InputDecoration(
                      labelText: 'Kelas',
                      prefixIcon: Icon(Icons.school_outlined),
                    ),
                    items: [
                      for (var value = 1; value <= 6; value++)
                        DropdownMenuItem(
                          value: value,
                          child: Text('Kelas $value'),
                        ),
                    ],
                    onChanged: (value) {
                      if (value != null) onGradeChanged(value);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onSubmit,
              icon: const Icon(Icons.play_arrow_rounded),
              label: const Text('MULAI BELAJAR'),
            ),
            if (canCancel) ...[
              const SizedBox(height: 8),
              TextButton(
                onPressed: onCancel,
                child: const Text('Batal'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _GenderSelector extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;

  const _GenderSelector({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 360;
        final children = [
          _GenderButton(
            label: 'Laki-laki',
            icon: Icons.face_6,
            selected: value == 'Laki-laki',
            onTap: () {
              ref.read(audioServiceProvider).playButtonClick();
              onChanged('Laki-laki');
            },
          ),
          _GenderButton(
            label: 'Perempuan',
            icon: Icons.face_3,
            selected: value == 'Perempuan',
            onTap: () {
              ref.read(audioServiceProvider).playButtonClick();
              onChanged('Perempuan');
            },
          ),
        ];

        if (isNarrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              children[0],
              const SizedBox(height: 10),
              children[1],
            ],
          );
        }

        return Row(
          children: [
            Expanded(child: children[0]),
            const SizedBox(width: 12),
            Expanded(child: children[1]),
          ],
        );
      },
    );
  }
}

class _GenderButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _GenderButton({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 20),
      label: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(0, 52),
        foregroundColor: selected ? Colors.white : AppColors.textDark,
        backgroundColor: selected ? AppColors.primary : Colors.white,
        side: BorderSide(
          color: selected
              ? AppColors.primary
              : AppColors.primary.withValues(alpha: 0.35),
          width: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}

class _ProfileGrid extends StatelessWidget {
  final List<UserProfile> profiles;
  final ValueChanged<UserProfile> onSelect;
  final VoidCallback onCreate;

  const _ProfileGrid({
    required this.profiles,
    required this.onSelect,
    required this.onCreate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 24,
          runSpacing: 24,
          alignment: WrapAlignment.center,
          children: [
            for (final profile in profiles)
              InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () => onSelect(profile),
                child: Container(
                  width: 150,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Column(
                    children: [
                      ProfileAvatar(profile: profile),
                      const SizedBox(height: 12),
                      Text(
                        profile.name,
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '${profile.gender} - Kelas ${profile.grade}',
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 28),
        OutlinedButton.icon(
          onPressed: onCreate,
          icon: const Icon(Icons.add_circle_outline),
          label: const Text('Tambah Profil'),
        ),
      ],
    );
  }
}

class _CheerfulBackground extends StatelessWidget {
  final Widget child;

  const _CheerfulBackground({required this.child});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFF2B8),
            Color(0xFFE3FAFF),
            Color(0xFFFFE1EC),
          ],
        ),
      ),
      child: CustomPaint(
        painter: _ConfettiPainter(),
        child: child,
      ),
    );
  }
}

class _ConfettiPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paints = [
      Paint()..color = AppColors.primary.withValues(alpha: 0.22),
      Paint()..color = AppColors.secondary.withValues(alpha: 0.20),
      Paint()..color = AppColors.accent.withValues(alpha: 0.26),
    ];

    for (var i = 0; i < 18; i++) {
      final x = (i * 73) % size.width;
      final y = (i * 91) % size.height;
      final rect = Rect.fromLTWH(x, y, 26 + (i % 3) * 8, 8);
      canvas.save();
      canvas.translate(rect.center.dx, rect.center.dy);
      canvas.rotate((i % 5) * 0.35);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset.zero,
            width: rect.width,
            height: rect.height,
          ),
          const Radius.circular(4),
        ),
        paints[i % paints.length],
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
