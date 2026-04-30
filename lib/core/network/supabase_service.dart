import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/isar_service.dart';
import '../../features/quiz/models/question.dart';
import '../../features/quiz/repositories/quiz_repository.dart';

class SupabaseSyncService {
  final SupabaseClient _client = Supabase.instance.client;
  final IsarService _isarService;

  SupabaseSyncService(this._isarService);

  /// Menarik semua bank soal terbaru dari Cloud (Supabase) 
  /// lalu menyimpannya ke dalam Database Offline (Isar)
  Future<void> syncQuestionsFromCloud() async {
    try {
      // 1. Ambil data dari tabel 'questions' di Supabase
      final response = await _client.from('questions').select();
      
      // 2. Parse data JSON dari cloud menjadi Model Isar
      final List<Question> cloudQuestions = (response as List).map((row) {
        return Question.fromJson(row['data_json']); 
      }).toList();

      // 3. Simpan massal ke Isar (Offline Storage)
      final isar = await _isarService.db;
      await isar.writeTxn(() async {
        // Hapus data lama yang mungkin usang (Opsional, tergantung strategi)
        // await isar.questions.clear(); 
        
        // Masukkan data baru yang fresh dari internet
        await isar.questions.putAll(cloudQuestions);
      });

      print("✅ Sinkronisasi berhasil! ${cloudQuestions.length} soal tersimpan offline.");
    } catch (e) {
      print("❌ Sinkronisasi gagal (Mode Offline aktif): $e");
    }
  }

  /// Membackup progress XP dan Nyawa anak ke Cloud
  Future<void> backupProfileProgress(String profileId, int xp, int grade) async {
    try {
      await _client.from('profiles').upsert({
        'id': profileId,
        'total_xp': xp,
        'grade': grade,
        'last_played': DateTime.now().toIso8601String(),
      });
      print("✅ Progress berhasil dibackup ke cloud!");
    } catch (e) {
      print("❌ Gagal backup progress: $e");
    }
  }
}

final supabaseSyncProvider = Provider<SupabaseSyncService>((ref) {
  final isar = ref.read(isarServiceProvider);
  return SupabaseSyncService(isar);
});
