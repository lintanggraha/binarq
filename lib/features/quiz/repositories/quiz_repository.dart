import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/isar_service.dart';
import '../models/question.dart';

final isarServiceProvider = Provider<IsarService>((ref) => IsarService());

final quizRepositoryProvider = Provider<QuizRepository>((ref) {
  final isarService = ref.read(isarServiceProvider);
  return QuizRepository(isarService);
});

class QuizRepository {
  final IsarService _isarService;

  QuizRepository(this._isarService);

  Future<List<Question>> fetchQuestions(
      String mapel, String kategoriUjian, int kelas) async {
    // Memberi sedikit delay buatan agar terlihat "loading" dan animasinya mulus
    await Future.delayed(const Duration(milliseconds: 800));

    // Mengambil langsung dari Database Isar secara offline!
    return await _isarService.getQuestionsBySubject(
      mapel,
      kategoriUjian,
      kelas,
    );
  }
}
