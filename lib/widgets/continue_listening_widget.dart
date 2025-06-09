import 'package:flutter/material.dart';

class ContinueListeningWidget extends StatelessWidget {
  final String bookTitle;
  final VoidCallback onPlayPressed;
  final bool isPlaying;

  const ContinueListeningWidget({
    super.key,
    required this.bookTitle,
    required this.onPlayPressed,
    required this.isPlaying,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      left: false,
      right: false,
      minimum: EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFE6F4E6),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 3),
                blurRadius: 6,
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            children: [
              // Book Icon Placeholder
              Container(
                width: 40,
                height: 40,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: Colors.green.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.book, color: Colors.white),
              ),

              // Book Title
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Continue Listening',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      bookTitle,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),

              // Play Button
              IconButton(
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow, size: 28),
                onPressed: onPlayPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}