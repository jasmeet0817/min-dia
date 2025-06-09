import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioController extends GetxController {
  final player = AudioPlayer();
  Rx<Duration> currentPosition = Duration.zero.obs;
  Rx<Duration> totalDuration = Duration.zero.obs;
  RxBool isPlaying = false.obs;
  RxBool showWidget = false.obs;
  RxBool isLoading = false.obs;

  static const String _keyLastPosition = 'last_played_position';

  @override
  void onInit() {
    super.onInit();
    _loadLastPosition();
    _setupListeners();
  }

  void _setupListeners() {
    player.positionStream.listen((position) {
      currentPosition.value = position;
      _saveLastPosition(position);
    });

    player.durationStream.listen((duration) {
      if (duration != null) {
        totalDuration.value = duration;
      }
    });

    player.playingStream.listen((playing) {
      isPlaying.value = playing;
    });
  }

  Future<void> playAudio({bool resume = false}) async {
    const audioUrl = 'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3';

    // Only load URL once
    if (player.audioSource == null) {
      isLoading.value = true;
      await player.setUrl(audioUrl);
    }

    if (resume) {
      final prefs = await SharedPreferences.getInstance();
      final lastPosMillis = prefs.getInt(_keyLastPosition) ?? 0;
      await player.seek(Duration(milliseconds: lastPosMillis));
    }

    showWidget.value = true;
    isLoading.value = false;
    await player.play();
  }

  Future<void> _saveLastPosition(Duration position) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyLastPosition, position.inMilliseconds);
  }

  Future<void> _loadLastPosition() async {
    final prefs = await SharedPreferences.getInstance();
    final lastPosMillis = prefs.getInt(_keyLastPosition) ?? 0;
    currentPosition.value = Duration(milliseconds: lastPosMillis);
  }

  Future<void> handleDisposeEvent() async {
    await player.pause();

    final current = currentPosition.value.inMilliseconds;
    final total = totalDuration.value.inMilliseconds;

    if (total > 0) {
      final percent = ((current / total) * 100).toStringAsFixed(2);
      print('[DisposeEvent] Listened: $percent%');
    }
  }

  void togglePlayback() {
    if (player.playing) {
      player.pause();
    } else {
      playAudio(resume: true); // Resume from last point
    }
  }

  @override
  void onClose() {
    handleDisposeEvent();
    player.dispose();
    super.onClose();
  }
}