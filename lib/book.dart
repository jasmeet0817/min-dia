import 'package:flutter/material.dart';
import 'package:min_dia/listener_page.dart';
import 'package:min_dia/services/audio_controller.dart';
import 'package:min_dia/widget/custom_body_with_audio_player_widget.dart';

class BookPage extends StatelessWidget {
  const BookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Book')),
        body: CustomBodyWithAudioPlayerWidget(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    AudiController.instance.dispose();
                    AudiController.instance.initPlayer();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PodcastListenerWidget(),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.audiotrack, size: 150, color: Colors.blue),
                      const SizedBox(height: 20),
                      const Text(
                        'Listen to Book',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Go Back'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
