import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../features/quiz/models/question.dart';
import '../../features/profile/models/profile.dart';
import '../../features/quiz/models/quiz_history.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      final isar = await Isar.open(
        [QuestionSchema, UserProfileSchema, QuizHistorySchema],
        directory: dir.path,
      );
      
      // Force refresh data untuk benerin soal Grade 1 yang nyasar
      await isar.writeTxn(() async {
        await isar.questions.clear();
      });
      
      await _seedInitialData(isar);
      return isar;
    }
    return Future.value(Isar.getInstance());
  }

  Future<void> _seedInitialData(Isar isar) async {
    final seedJson = await rootBundle.loadString('bank_soal.json');
    final List<dynamic> jsonList = jsonDecode(seedJson);
    final List<Question> questions =
        jsonList.map((q) => Question.fromJson(q)).toList();
    await isar.writeTxn(() async {
      await isar.questions.clear();
      await isar.questions.putAll(questions);
    });
  }


  // --- Profile Methods ---

  Future<List<UserProfile>> getAllProfiles() async {
    final isar = await db;
    return await isar.userProfiles.where().findAll();
  }

  Future<void> saveProfile(UserProfile profile) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.userProfiles.put(profile);
    });
  }

  // --- History Methods ---

  Future<void> saveQuizHistory(QuizHistory history) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.quizHistorys.put(history);
    });
  }

  Future<List<String>> getAnsweredQuestionIds(int profileId, String mapel, String kategoriUjian) async {
    final isar = await db;
    final history = await isar.quizHistorys
        .filter()
        .profileIdEqualTo(profileId)
        .mapelEqualTo(mapel)
        .kategoriUjianEqualTo(kategoriUjian)
        .findAll();
    
    return history.map((h) => h.questionId).toList();
  }

  // Modified getQuestionsBySubject to potentially filter by history (optional, can be done in repository)
  Future<List<Question>> getQuestionsBySubject(
    String mapel,
    String kategoriUjian,
    int kelas, {
    List<String>? excludeIds,
  }) async {
    final isar = await db;
    var query = isar.questions
        .filter()
        .metadata(
          (m) => m
              .mapelEqualTo(mapel)
              .and()
              .kategoriUjianEqualTo(kategoriUjian)
              .and()
              .kelasEqualTo(kelas),
        );
    
    // Triple Shield: Pastikan tidak ada keyword keliling/luas untuk kelas 1-2
    if (kelas <= 2) {
      query = query.filter().not().content((c) => c.pertanyaanContains('keliling', caseSensitive: false))
                   .and().not().content((c) => c.pertanyaanContains('luas', caseSensitive: false));
    }
    
    if (excludeIds != null && excludeIds.isNotEmpty) {
      // Isar doesn't have a direct "not in" for list of strings easily in one filter call without looping or using a complex query
      // But we can filter them after fetching or use multiple 'and not'
      // For simplicity and speed with 5400 questions, we fetch and filter in memory if the list is small, 
      // or use a more complex query if needed.
    }
    
    final results = await query.findAll();
    
    if (excludeIds != null && excludeIds.isNotEmpty) {
      final excludeSet = excludeIds.toSet();
      return results.where((q) => !excludeSet.contains(q.questionId)).toList();
    }
    
    return results;
  }
}
