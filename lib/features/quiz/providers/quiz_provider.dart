import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/question.dart';
import '../repositories/quiz_repository.dart';
import '../../profile/providers/profile_provider.dart';

// Provider untuk menyimpan Mapel yang dipilih (contoh: 'MTK', 'PAI')
final selectedSubjectProvider = StateProvider<String>((ref) => 'MTK');

// Provider untuk menyimpan jenis sumatif yang dipilih.
final selectedExamCategoryProvider =
    StateProvider<String>((ref) => 'Sumatif Awal Semester');

// State object untuk kuis
class QuizState {
  final List<Question> questions;
  final int currentIndex;
  final int xp;
  final int correctCount;
  final bool isLoading;
  final String? selectedAnswerId;
  final bool isAnswerChecked;
  final bool isCorrect;
  final bool isFinished;

  QuizState({
    this.questions = const [],
    this.currentIndex = 0,
    this.xp = 0,
    this.correctCount = 0,
    this.isLoading = true,
    this.selectedAnswerId,
    this.isAnswerChecked = false,
    this.isCorrect = false,
    this.isFinished = false,
  });

  QuizState copyWith({
    List<Question>? questions,
    int? currentIndex,
    int? xp,
    int? correctCount,
    bool? isLoading,
    String? selectedAnswerId,
    bool resetAnswer = false,
    bool? isAnswerChecked,
    bool? isCorrect,
    bool? isFinished,
  }) {
    return QuizState(
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      xp: xp ?? this.xp,
      correctCount: correctCount ?? this.correctCount,
      isLoading: isLoading ?? this.isLoading,
      selectedAnswerId:
          resetAnswer ? null : (selectedAnswerId ?? this.selectedAnswerId),
      isAnswerChecked: isAnswerChecked ?? this.isAnswerChecked,
      isCorrect: isCorrect ?? this.isCorrect,
      isFinished: isFinished ?? this.isFinished,
    );
  }

  int get totalQuestions => questions.length;
  int get questionNumber => currentIndex + 1;
  int get score =>
      totalQuestions == 0 ? 0 : ((correctCount / totalQuestions) * 100).round();

  Question? get currentQuestion =>
      questions.isNotEmpty && currentIndex < questions.length
          ? questions[currentIndex]
          : null;
}

// Notifier untuk mengatur logika kuis
class QuizNotifier extends StateNotifier<QuizState> {
  final QuizRepository _repository;
  final String mapel;
  final String kategoriUjian;
  final int kelas;

  QuizNotifier(this._repository, this.mapel, this.kategoriUjian, this.kelas)
      : super(QuizState()) {
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    state = state.copyWith(isLoading: true);
    // Mengambil soal dari Database Isar berdasarkan Mapel dan Kelas Anak
    final questions =
        await _repository.fetchQuestions(mapel, kategoriUjian, kelas);

    questions.sort((a, b) => a.questionId.compareTo(b.questionId));

    state = state.copyWith(
      questions: questions,
      isLoading: false,
    );
  }

  void selectAnswer(String answerId) {
    if (state.isAnswerChecked) return; // Kunci jawaban jika sudah dicek
    if (answerId.trim().isEmpty) {
      state = state.copyWith(resetAnswer: true);
      return;
    }

    state = state.copyWith(selectedAnswerId: answerId);
  }

  void checkAnswer() {
    if (state.selectedAnswerId == null) return;

    final currentQuestion = state.currentQuestion;
    final isIsian = currentQuestion?.content.tipeSoal == 'isian';
    final isBenar = isIsian
        ? _normalizeAnswer(currentQuestion?.content.jawabanBenar) ==
            _normalizeAnswer(state.selectedAnswerId)
        : currentQuestion?.content.jawabanBenar == state.selectedAnswerId;

    int newXp = state.xp;
    int newCorrectCount = state.correctCount;

    if (isBenar) {
      int reward = state.currentQuestion?.metadata.xpReward ?? 10;
      newXp += reward;
      newCorrectCount += 1;
    }

    state = state.copyWith(
      isAnswerChecked: true,
      isCorrect: isBenar,
      xp: newXp,
      correctCount: newCorrectCount,
    );
  }

  void nextQuestion() {
    if (state.currentIndex < state.questions.length - 1) {
      state = state.copyWith(
        currentIndex: state.currentIndex + 1,
        isAnswerChecked: false,
        resetAnswer: true,
      );
    } else {
      state = state.copyWith(isFinished: true);
    }
  }
}

String _normalizeAnswer(String? answer) {
  return (answer ?? '')
      .trim()
      .toLowerCase()
      .replaceAll(RegExp(r'\s+'), ' ')
      .replaceAll(RegExp(r'[.,!?;:]'), '');
}

// Provider Global
final quizNotifierProvider =
    StateNotifierProvider.autoDispose<QuizNotifier, QuizState>((ref) {
  final repository = ref.read(quizRepositoryProvider);
  final mapel = ref.watch(selectedSubjectProvider);
  final kategoriUjian = ref.watch(selectedExamCategoryProvider);
  final profile = ref.watch(profileNotifierProvider);

  // Jika profil belum dipilih, default kelas 1
  final kelas = profile?.grade ?? 1;

  return QuizNotifier(repository, mapel, kategoriUjian, kelas);
});
