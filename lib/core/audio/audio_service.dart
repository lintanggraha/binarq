import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AudioService {
  final AudioPlayer _sfxPlayer = AudioPlayer();
  final AudioPlayer _bgmPlayer = AudioPlayer();

  static const String _correctSoundAsset = 'audio/answer_correct.wav';
  static const String _wrongSoundAsset = 'audio/answer_wrong.wav';
  static const String _buttonClickUrl =
      'https://actions.google.com/sounds/v1/cartoon/pop.ogg';
  static const String _levelUpUrl =
      'https://actions.google.com/sounds/v1/cartoon/magic_chime_chord.ogg';
  static const String _quizBgmAsset = 'audio/cheerful_quiz_loop.wav';
  static const double _bgmVolume = 0.26;

  bool _isBgmPlaying = false;

  Future<void> playCorrectAnswer() async {
    await _sfxPlayer.play(AssetSource(_correctSoundAsset), volume: 0.85);
  }

  Future<void> playWrongAnswer() async {
    await _sfxPlayer.play(AssetSource(_wrongSoundAsset), volume: 0.75);
  }

  Future<void> playButtonClick() async {
    await _sfxPlayer.play(UrlSource(_buttonClickUrl), volume: 0.5);
  }

  Future<void> playLevelUp() async {
    await _sfxPlayer.play(UrlSource(_levelUpUrl), volume: 1.0);
  }

  Future<void> startBgm() async {
    if (_isBgmPlaying) return;

    await _bgmPlayer.setPlayerMode(PlayerMode.mediaPlayer);
    await _bgmPlayer.setReleaseMode(ReleaseMode.loop);
    await _bgmPlayer.play(AssetSource(_quizBgmAsset), volume: 0);
    _isBgmPlaying = true;

    for (var step = 1; step <= 12; step++) {
      await Future.delayed(const Duration(milliseconds: 90));
      await _bgmPlayer.setVolume(_bgmVolume * step / 12);
    }
  }

  Future<void> stopBgm() async {
    if (!_isBgmPlaying) return;

    for (var step = 11; step >= 0; step--) {
      await _bgmPlayer.setVolume(_bgmVolume * step / 12);
      await Future.delayed(const Duration(milliseconds: 50));
    }

    await _bgmPlayer.stop();
    _isBgmPlaying = false;
  }

  Future<void> resumeBgm() async {
    if (!_isBgmPlaying) {
      await startBgm();
      return;
    }

    await _bgmPlayer.setVolume(_bgmVolume);
  }

  Future<void> dispose() async {
    await _sfxPlayer.dispose();
    await _bgmPlayer.dispose();
  }
}

// Provider global agar mudah dipanggil dari mana saja
final audioServiceProvider = Provider<AudioService>((ref) {
  final audioService = AudioService();
  ref.onDispose(() {
    audioService.dispose();
  });
  return audioService;
});
