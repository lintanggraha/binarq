import 'package:flutter/material.dart';

import '../../models/profile.dart';

class ProfileAvatar extends StatefulWidget {
  final UserProfile profile;
  final double size;

  const ProfileAvatar({
    super.key,
    required this.profile,
    this.size = 96,
  });

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    final color = Color(widget.profile.avatarColorValue);
    final icon = widget.profile.gender == 'Perempuan' ? Icons.face_3 : Icons.face_6;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: _scale),
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOutSine,
      onEnd: () {
        setState(() {
          _scale = _scale == 1.0 ? 1.05 : 1.0;
        });
      },
      builder: (context, scale, child) => Transform.scale(scale: scale, child: child),
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withValues(alpha: 0.95),
              color.withValues(alpha: 0.68),
            ],
          ),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 4),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.35),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: widget.size * 0.48,
            ),
            Positioned(
              bottom: widget.size * 0.15,
              child: Text(
                widget.profile.name.substring(0, 1).toUpperCase(),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontSize: widget.size * 0.24,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
