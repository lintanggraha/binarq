import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../features/quiz/models/question.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      final isar = await Isar.open(
        [QuestionSchema],
        directory: dir.path,
        inspector: true,
      );

      // Jalankan Seeding (Isi data awal jika kosong)
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

  // Fungsi untuk mengambil soal berdasarkan mapel, jenis sumatif, dan kelas.
  Future<List<Question>> getQuestionsBySubject(
    String mapel,
    String kategoriUjian,
    int kelas,
  ) async {
    final isar = await db;
    // Query yang sangat cepat dan offline
    return await isar.questions
        .filter()
        .metadata(
          (m) => m
              .mapelEqualTo(mapel)
              .and()
              .kategoriUjianEqualTo(kategoriUjian)
              .and()
              .kelasEqualTo(kelas),
        )
        .findAll();
  }
}
