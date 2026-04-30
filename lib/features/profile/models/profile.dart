class UserProfile {
  final String id;
  final String name;
  final String avatarUrl;
  final int level;
  final int totalXp;
  final int grade; // Kelas 1-6
  final bool isParent;

  UserProfile({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.level,
    required this.totalXp,
    required this.grade,
    this.isParent = false,
  });
}
