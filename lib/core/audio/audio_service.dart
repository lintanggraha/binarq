import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AudioService {
  final AudioPlayer _sfxPlayer = AudioPlayer();
  final AudioPlayer _bgmPlayer = AudioPlayer();

  // URL sementara (placeholder) dari internet untuk SFX dasar
  // Nanti akan diganti dengan asset lokal (contoh: 'assets/audio/correct.mp3')
  static const String _correctSoundUrl = 'https://actions.google.com/sounds/v1/cartoon/clown_horn.ogg';
  static const String _wrongSoundUrl = 'https://actions.google.com/sounds/v1/cartoon/slide_whistle.ogg';
  static const String _buttonClickUrl = 'https://actions.google.com/sounds/v1/cartoon/pop.ogg';
  static const String _levelUpUrl = 'https://actions.google.com/sounds/v1/cartoon/magic_chime_chord.ogg';

  Future<void> playCorrectAnswer() async {
    await _sfxPlayer.play(UrlSource(_correctSoundUrl), volume: 0.8);
  }

  Future<void> playWrongAnswer() async {
    await _sfxPlayer.play(UrlSource(_wrongSoundUrl), volume: 0.8);
  }

  Future<void> playButtonClick() async {
    await _sfxPlayer.play(UrlSource(_buttonClickUrl), volume: 0.5);
  }

  Future<void> playLevelUp() async {
    await _sfxPlayer.play(UrlSource(_levelUpUrl), volume: 1.0);
  }

  // BGM (Bisa dilooping saat masuk menu utama)
  Future<void> startBgm() async {
    _bgmPlayer.setReleaseMode(ReleaseMode.loop);
    // Placeholder BGM santai
    // await _bgmPlayer.play(UrlSource('URL_BGM_ISLAMI_SANTAI'));
  }

  Future<void> stopBgm() async {
    await _bgmPlayer.stop();
  }
}

// Provider global agar mudah dipanggil dari mana saja
final audioServiceProvider = Provider<AudioService>((ref) => AudioService());
