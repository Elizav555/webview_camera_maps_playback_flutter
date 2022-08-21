import 'package:flutter/material.dart';

class PauseWidget extends StatelessWidget {
  final bool isPlaying;

  const PauseWidget({
    Key? key,
    required this.isPlaying,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 70,
      height: 70,
      child: Icon(
        isPlaying ? Icons.pause : Icons.play_arrow,
        size: 50,
      ),
    );
  }
}
