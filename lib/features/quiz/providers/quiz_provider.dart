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
  final int lives;
  final int xp;
  final bool isLoading;
  final String? selectedAnswerId;
  final bool isAnswerChecked;
  final bool isCorrect;
  final bool isSecondChance;
  final bool isFinished;

  QuizState({
    this.questions = const [],
    this.currentIndex = 0,
    this.lives = 5,
    this.xp = 0,
    this.isLoading = true,
    this.selectedAnswerId,
    this.isAnswerChecked = false,
    this.isCorrect = false,
    this.isSecondChance = false,
    this.isFinished = false,
  });

  QuizState copyWith({
    List<Question>? questions,
    int? currentIndex,
    int? lives,
    int? xp,
    bool? isLoading,
    String? selectedAnswerId,
    bool resetAnswer = false,
    bool? isAnswerChecked,
    bool? isCorrect,
    bool? isSecondChance,
    bool? isFinished,
  }) {
    return QuizState(
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      lives: lives ?? this.lives,
      xp: xp ?? this.xp,
      isLoading: isLoading ?? this.isLoading,
      selectedAnswerId:
          resetAnswer ? null : (selectedAnswerId ?? this.selectedAnswerId),
      isAnswerChecked: isAnswerChecked ?? this.isAnswerChecked,
      isCorrect: isCorrect ?? this.isCorrect,
      isSecondChance: isSecondChance ?? this.isSecondChance,
      isFinished: isFinished ?? this.isFinished,
    );
  }

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

    // Acak urutan pertanyaan agar tidak bosan
    questions.shuffle();

    state = state.copyWith(
      questions: questions,
      isLoading: false,
    );
  }

  void selectAnswer(String answerId) {
    if (state.isAnswerChecked) return; // Kunci jawaban jika sudah dicek
    state = state.copyWith(selectedAnswerId: answerId);
  }

  void checkAnswer() {
    if (state.selectedAnswerId == null) return;

    final isBenar =
        state.currentQuestion?.content.jawabanBenar == state.selectedAnswerId;

    int newXp = state.xp;
    int newLives = state.lives;

    if (isBenar) {
      // Jika second chance, dapat 50% XP
      int reward = state.currentQuestion?.metadata.xpReward ?? 10;
      newXp += state.isSecondChance ? (reward ~/ 2) : reward;
    } else {
      if (!state.isSecondChance) {
        // Kesempatan pertama salah, tidak kurangi nyawa, masuk second chance
      } else {
        // Kesempatan kedua salah, kurangi nyawa
        newLives -= 1;
      }
    }

    state = state.copyWith(
      isAnswerChecked: true,
      isCorrect: isBenar,
      xp: newXp,
      lives: newLives,
    );
  }

  void nextQuestion() {
    if (!state.isCorrect && !state.isSecondChance) {
      // Jika tadi salah di kesempatan pertama, berikan second chance
      state = state.copyWith(
        isAnswerChecked: false,
        resetAnswer: true, // Reset input
        isSecondChance: true,
      );
    } else {
      // Pindah ke soal berikutnya
      if (state.currentIndex < state.questions.length - 1) {
        state = state.copyWith(
          currentIndex: state.currentIndex + 1,
          isAnswerChecked: false,
          resetAnswer: true,
          isSecondChance: false,
        );
      } else {
        // Kuis selesai
        state = state.copyWith(isFinished: true);
      }
    }
  }
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
