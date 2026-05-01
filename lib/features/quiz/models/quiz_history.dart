import 'package:isar/isar.dart';

part 'quiz_history.g.dart';

@collection
class QuizHistory {
  Id id = Isar.autoIncrement;

  late int profileId; // Relasi ke UserProfile.id
  late String questionId; // ID soal dari Question model
  late String mapel;
  late String kategoriUjian;
  late int score;
  late DateTime completedAt;

  QuizHistory();

  QuizHistory.create({
    required this.profileId,
    required this.questionId,
    required this.mapel,
    required this.kategoriUjian,
    required this.score,
    required this.completedAt,
  });
}
