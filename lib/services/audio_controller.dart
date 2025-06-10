import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudiController {
  AudiController._internal(this._audioUrl);

  static AudiController? _instance;

  factory AudiController(AudioSource audioUrl) {
    _instance ??= AudiController._internal(audioUrl);
    return _instance!;
  }

  final AudioSource _audioUrl;

  static AudiController get instance => _instance!;

  AudioPlayer? _player;
  ValueNotifier<bool> isPlaying = ValueNotifier<bool>(false);
  Duration _currentPosition = Duration.zero;
  late StreamSubscription<Duration> _positionSubscription;

  /*ValueNotifier<bool> get isPlaying => _isPlaying
      ? ValueNotifier<bool>(true)
      : ValueNotifier<bool>(false);*/

  initPlayer() async {
    if (_player == null) {
      final lastPosition = await getLastAudioPosition();
      _currentPosition = lastPosition;

      _player = AudioPlayer(
        audioLoadConfiguration: AudioLoadConfiguration(
          // iOS/macOS settings
          darwinLoadControl: DarwinLoadControl(
            automaticallyWaitsToMinimizeStalling:
                false, // Start playback immediately
            preferredForwardBufferDuration: Duration(seconds: 15),
          ),
          // Android settings
          androidLoadControl: AndroidLoadControl(
            minBufferDuration: Duration(seconds: 10),
            maxBufferDuration: Duration(seconds: 50),
            bufferForPlaybackDuration: Duration(milliseconds: 2500),
            bufferForPlaybackAfterRebufferDuration: Duration(seconds: 5),
          ),
        ),
      );
      _player!.setAudioSource(
        _audioUrl,
        preload: true,
        initialIndex: 0,
        initialPosition: _currentPosition,
      );

      _positionSubscription = _player!.positionStream.listen((position) {
        _currentPosition = position;
        saveAudioPosition(position);
      });
    }
  }

  Future<void> saveAudioPosition(Duration position) async {
    //Todo: Use Share preferences service
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('last_position', position.inMilliseconds);
  }

  Future<Duration> getLastAudioPosition() async {
    //Todo: Use Share preferences service
    final prefs = await SharedPreferences.getInstance();
    final millis = prefs.getInt('last_position') ?? 0;
    return Duration(milliseconds: millis);
  }

  // Method to play audio
  void play() {
    print('Playing audio: ');
    isPlaying.value = true;
    _player?.play();
  }

  // Method to pause audio
  void pause() {
    print('Audio paused: ');
    isPlaying.value = false;
    _player?.pause();
  }

  // Method to stop audio
  void stop() {
    isPlaying.value = false;
    _player?.stop();
  }

  void dispose() {
    final duration = _player?.duration;
    isPlaying.value = false;
    _player?.dispose();

    _positionSubscription.cancel();
    _player = null;

    final percentageListened =
        duration != null && duration.inSeconds > 0
            ? (_currentPosition.inSeconds / duration.inSeconds * 100).clamp(
              0.0,
              100.0,
            )
            : 0.0;
    print('percentageListened: $percentageListened');
  }
}
