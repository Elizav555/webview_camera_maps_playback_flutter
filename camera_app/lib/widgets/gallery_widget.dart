import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class GalleryWidget extends StatelessWidget {
  const GalleryWidget({
    Key? key,
    required this.images,
  }) : super(key: key);

  final List<XFile> images;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: images
          .map((e) => Image.file(
                File(e.path),
              ))
          .toList(),
    );
  }
}
