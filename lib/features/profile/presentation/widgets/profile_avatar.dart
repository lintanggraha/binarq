import 'package:flutter/material.dart';

import '../../models/profile.dart';

class ProfileAvatar extends StatelessWidget {
  final UserProfile profile;
  final double size;

  const ProfileAvatar({
    super.key,
    required this.profile,
    this.size = 96,
  });

  @override
  Widget build(BuildContext context) {
    final color = Color(profile.avatarColorValue);
    final icon = profile.gender == 'Perempuan' ? Icons.face_3 : Icons.face_6;

    return Container(
      width: size,
      height: size,
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
            size: size * 0.48,
          ),
          Positioned(
            bottom: size * 0.15,
            child: Text(
              profile.name.substring(0, 1).toUpperCase(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontSize: size * 0.24,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
