import 'package:flutter/material.dart';

import 'continue_listening_widget.dart';

class CustomBodyWithAudioPlayerWidget extends StatelessWidget {
  const CustomBodyWithAudioPlayerWidget({super.key, required this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        body,
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ContinueListeningWidget(),
        ),
      ],
    );
  }
}
