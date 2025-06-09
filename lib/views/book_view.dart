import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:min_dia/controllers/audio_controller.dart';
import 'package:min_dia/routes/routes_name.dart';
import 'package:min_dia/widgets/continue_listening_widget.dart';

class BookView extends StatelessWidget {
  const BookView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AudioController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Book Page')),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('This is the Book Page'),
                  const SizedBox(height: 20),
                  IconButton(
                    icon: const Icon(Icons.music_note),
                    onPressed: () => Get.toNamed(RoutesName.audioView),
                    tooltip: 'Listen to Book',
                  ),
                ],
              ),
            ),
          ),
          Obx(
            () =>
                controller.showWidget.value
                    ? ContinueListeningWidget(
                      bookTitle: 'The Subtle Art of Not Giving A F*ck',
                      onPlayPressed: controller.togglePlayback,
                      isPlaying: controller.isPlaying.value,
                    )
                    : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
