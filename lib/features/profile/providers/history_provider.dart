import 'package:isar/isar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/isar_service.dart';
import '../../quiz/models/quiz_history.dart';
import '../../quiz/repositories/quiz_repository.dart';
import 'profile_provider.dart';

final historyProvider = FutureProvider<List<QuizHistory>>((ref) async {
  final profile = ref.watch(profileNotifierProvider);
  if (profile == null) return [];

  final isarService = ref.read(isarServiceProvider);
  final isar = await isarService.db;
  
  final results = await isar.quizHistorys
      .filter()
      .profileIdEqualTo(profile.id)
      .sortByCompletedAtDesc()
      .findAll();
      
  return results.take(10).toList();
});
