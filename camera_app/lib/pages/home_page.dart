import 'dart:async';

import 'package:camera/camera.dart';
import 'package:camera_app/widgets/gallery_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/camera_widget.dart';

const pages = {0: 'Camera', 1: 'Gallery'};

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  String get _title => '${pages[_selectedIndex]} Preview';

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addImage(XFile image) => setState(() {
        images = [...images, image];
      });

  List<CameraDescription> cameras = [];
  CameraController? controller;
  List<XFile> images = [];

  @override
  void initState() {
    initCamera();
    super.initState();
  }

  Future<void> initCamera() async {
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  Future<void> _takePicture() async {
    XFile? image = await controller?.takePicture();
    if (image != null) _addImage(image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: SafeArea(
        child: Center(
          child: pages[_selectedIndex] == 'Camera'
              ? CameraWidget(controller: controller)
              : GalleryWidget(images: images),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'Gallery',
          ),
        ],
      ),
      floatingActionButton: pages[_selectedIndex] == 'Camera' &&
              controller?.value.isInitialized == true
          ? FloatingActionButton(
              onPressed: _takePicture,
              child: const Icon(Icons.camera),
            )
          : null,
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
