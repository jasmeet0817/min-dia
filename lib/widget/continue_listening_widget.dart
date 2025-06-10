import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

import '../services/audio_controller.dart';

class ContinueListeningWidget extends StatefulWidget {
  const ContinueListeningWidget({super.key});

  @override
  State<ContinueListeningWidget> createState() =>
      _ContinueListeningWidgetState();
}

class _ContinueListeningWidgetState extends State<ContinueListeningWidget>
    with WidgetsBindingObserver {
  late AudiController _audiController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _audiController = AudiController(
      AudioSource.uri(
        Uri.parse('http://daq7nasbr6dck.cloudfront.net/7habits/1.mp3'),
        tag: MediaItem(
          id: '1',
          album: '7 Habits of Highly Effective People',
          title: 'Chapter 1',
          artist: 'Stephen R. Covey',
          artUri: Uri.parse(
            'http://daq7nasbr6dck.cloudfront.net/7habits/cover.jpg',
          ),
        ),
      ),
    );
    _audiController.initPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //Todo: Use Constants for colors
        color: Color(0xFFd5efb2), // Dark background color
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Continue Listening',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Podcast Name',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: _audiController.isPlaying,
            builder: (context, isPlaying, child) {
              print('isPlaying: $isPlaying');
              return IconButton(
                iconSize: 64,
                icon: Icon(
                  isPlaying
                      ? Icons.pause_circle_filled
                      : Icons.play_circle_filled,
                  color: Colors.black,
                ),
                onPressed: _togglePlayback,
              );
            },
          ),
        ],
      ),
    );
  }

  void _togglePlayback() {
    if (_audiController.isPlaying.value) {
      _audiController.pause();
    } else {
      _audiController.play();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        _audiController.dispose();
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }
}
