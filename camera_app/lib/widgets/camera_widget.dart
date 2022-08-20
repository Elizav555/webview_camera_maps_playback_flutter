import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraWidget extends StatelessWidget {
  final CameraController? controller;

  const CameraWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller?.value.isInitialized == true
        ? Center(
            child: SizedBox.expand(
              child: CameraPreview(controller!),
            ),
          )
        : const SizedBox();
  }
}
