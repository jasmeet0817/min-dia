import 'package:flutter/material.dart';
import 'package:min_dia/widget/continue_listening_widget.dart';
import 'package:min_dia/widget/custom_body_with_audio_player_widget.dart';
import 'book.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    debugPrint('✅ HomePage initState called');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Podcast Reader')),
      body: CustomBodyWithAudioPlayerWidget(
        body: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BookPage()),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.book, size: 150, color: Colors.blue),
                const SizedBox(height: 20),
                const Text(
                  'Open Book',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
