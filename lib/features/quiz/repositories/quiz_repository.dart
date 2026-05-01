import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/isar_service.dart';
import '../models/question.dart';
import '../models/quiz_history.dart';

final isarServiceProvider = Provider<IsarService>((ref) => IsarService());

final quizRepositoryProvider = Provider<QuizRepository>((ref) {
  final isarService = ref.read(isarServiceProvider);
  return QuizRepository(isarService);
});

class QuizRepository {
  final IsarService _isarService;

  QuizRepository(this._isarService);

  Future<List<Question>> fetchQuestions(
      String mapel, String kategoriUjian, int kelas, {int? profileId}) async {
    // Memberi sedikit delay buatan agar terlihat "loading" dan animasinya mulus
    await Future.delayed(const Duration(milliseconds: 800));

    List<String>? excludeIds;
    if (profileId != null) {
      excludeIds = await _isarService.getAnsweredQuestionIds(profileId, mapel, kategoriUjian);
    }

    // Mengambil langsung dari Database Isar secara offline!
    final questions = await _isarService.getQuestionsBySubject(
      mapel,
      kategoriUjian,
      kelas,
      excludeIds: excludeIds,
    );

    // Jika soal yang belum dikerjakan habis, mungkin kita reset atau ambil lagi saja?
    // Tapi user minta "generate soal yang berbeda", biasanya ada batas jumlah soal per kuis (misal 10-20).
    // Jika data soal ada ribuan (5400), kemungkinan besar masih banyak yang belum dikerjakan.
    
    return questions;
  }

  Future<void> saveHistory(QuizHistory history) async {
    await _isarService.saveQuizHistory(history);
  }
}
