import 'package:isar/isar.dart';

part 'profile.g.dart';

@collection
class UserProfile {
  Id id = Isar.autoIncrement;

  late String name;
  late String gender;
  late int age;
  late int level;
  late int totalXp;
  late int grade; // Kelas 1-6
  late int avatarColorValue;

  UserProfile();

  UserProfile.create({
    required this.name,
    required this.gender,
    required this.age,
    required this.level,
    required this.totalXp,
    required this.grade,
    required this.avatarColorValue,
  });
}
