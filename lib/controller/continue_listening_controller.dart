import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio/just_audio.dart';

class ContinueListeningController extends GetxController with WidgetsBindingObserver {
  final box = GetStorage();
  final player = AudioPlayer();

  var isPlaying = false.obs;
  var isVisible = true.obs;

  var lastPosition = Duration.zero.obs;
  var totalDuration = const Duration(seconds: 1).obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    loadSavedPosition();
    box.listen(() {
      print("nowwwwwww");
    },);
  }

  @override
  void onClose() {
    saveCurrentPosition();
    player.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
  //     stopAndSavePosition();
  //   }
  // }

  void loadSavedPosition() {
    final seconds = box.read('last_position') ?? 0;
    final totalSeconds = box.read('total_duration') ?? 1;
    lastPosition.value = Duration(seconds: seconds);
    totalDuration.value = Duration(seconds: totalSeconds);
  }

  Future<void> playFromLastPosition() async {
    try {
      loadSavedPosition();
      isPlaying.value = false;
      await player.setUrl('http://daq7nasbr6dck.cloudfront.net/7habits/1.mp3');

      await player.durationStream.firstWhere((d) => d != null);
      await player.seek(lastPosition.value);

      isPlaying.value = true;
      await player.play();
    } catch (e) {
      print("Play error: $e");
    }
  }

  Future<void> pauseAndSavePosition() async {
    await player.pause();
    isPlaying.value = false;
    saveCurrentPosition();
  }

  Future<void> stopAndSavePosition() async {
    await player.stop();
    isPlaying.value = false;
    saveCurrentPosition();
  }

  Future<void> saveCurrentPosition() async {
    final curr = player.position;
    final dur = player.duration ?? const Duration(seconds: 1);
    double percent = (curr.inSeconds / dur.inSeconds) * 100;
    percent = percent.clamp(0.0, 100.0);
    print('percentageListened: $percent');
    print('currInSeconds: ${curr.inSeconds}');

    if (percent > 94) {
      box.write('last_position', 0); // reset
    } else {
      box.write('last_position', curr.inSeconds);
    }

    box.write('total_duration', dur.inSeconds);
  }

  Future<void> rewind30Seconds() async {
    final newPosition = player.position - const Duration(seconds: 30);
    await player.seek(newPosition >= Duration.zero ? newPosition : Duration.zero);
  }

  Future<void> forward30Seconds() async {
    final newPosition = player.position + const Duration(seconds: 30);
    final duration = player.duration ?? const Duration(seconds: 1);
    if (newPosition < duration) {
      await player.seek(newPosition);
    } else {
      await player.seek(duration);
    }
  }
}
