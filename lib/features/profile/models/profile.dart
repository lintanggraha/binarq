class UserProfile {
  final String id;
  final String name;
  final String gender;
  final int age;
  final int level;
  final int totalXp;
  final int grade; // Kelas 1-6
  final int avatarColorValue;

  UserProfile({
    required this.id,
    required this.name,
    required this.gender,
    required this.age,
    required this.level,
    required this.totalXp,
    required this.grade,
    required this.avatarColorValue,
  });
}
