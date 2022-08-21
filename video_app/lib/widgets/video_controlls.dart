import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_app/widgets/pause_widget.dart';
import 'package:video_app/widgets/video_slider.dart';
import 'package:video_player/video_player.dart';

class VideoControls extends StatefulWidget {
  final VideoPlayerController controller;

  const VideoControls({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  VideoControlsState createState() => VideoControlsState();
}

class VideoControlsState extends State<VideoControls> {
  bool isPlaying = true;
  bool controlsShown = false;

  Duration _delay(int after) => Duration(seconds: after);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (_) => _handleTap(),
      onTapDown: (_) => _handleTap(),
      child: Visibility(
        visible: controlsShown,
        replacement: const SizedBox.expand(),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: VideoSlider(controller: widget.controller),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 50,
                    onPressed: () => _rewindVideo(-10),
                    icon: const Icon(
                      Icons.replay_10,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 16),
                  ClipOval(
                    child: InkWell(
                      onTap: _handlePause,
                      child: PauseWidget(isPlaying: isPlaying),
                    ),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    iconSize: 50,
                    onPressed: () => _rewindVideo(10),
                    icon: const Icon(
                      Icons.forward_10,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleTap() {
    setState(() {
      controlsShown = !controlsShown;
    });
    Future.delayed(_delay(3), () {
      if (isPlaying) {
        _hideControls();
      }
    });
  }

  void _handlePause() {
    if (widget.controller.value.isPlaying) {
      widget.controller.pause();
      setState(() {
        isPlaying = false;
      });
    } else {
      widget.controller.play();
      setState(() {
        isPlaying = true;
      });
      _hideControls();
    }
  }

  void _hideControls() {
    if (controlsShown) {
      Timer(_delay(4), () {
        setState(() => controlsShown = false);
      });
    }
  }

  void _rewindVideo(int seconds) {
    widget.controller.seekTo(
      Duration(seconds: widget.controller.value.position.inSeconds + seconds),
    );
    _hideControls();
  }
}
