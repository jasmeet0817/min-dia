import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:min_dia/controllers/audio_controller.dart';

class AudioView extends StatelessWidget {
  const AudioView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AudioController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Audio Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Now Playing: The Subtle Art of Not Giving A F*ck'),
            const SizedBox(height: 16),
            Obx(() {
              if (controller.isLoading.value) {
                return const CircularProgressIndicator();
              }

              return ElevatedButton.icon(
                icon: Icon(
                  controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
                ),
                label: Text(controller.isPlaying.value ? 'Pause' : 'Play'),
                onPressed: controller.togglePlayback,
              );
            }),
          ],
        ),
      ),
    );
  }
}
