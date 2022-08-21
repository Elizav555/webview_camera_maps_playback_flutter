import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class ZoomSlider extends StatefulWidget {
  const ZoomSlider({Key? key, required this.controller}) : super(key: key);
  final YandexMapController controller;

  @override
  State<StatefulWidget> createState() => ZoomSliderState();
}

class ZoomSliderState extends State<ZoomSlider> {
  static const double _scale = 17.0;
  double _currentSliderValue = _scale;
  final animation =
      const MapAnimation(type: MapAnimationType.smooth, duration: 2.0);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Slider(
        value: _currentSliderValue,
        min: -10,
        max: _scale,
        divisions: 100,
        label: _currentSliderValue.round().toString(),
        onChanged: (double value) {
          setState(() {
            _currentSliderValue = value;
            widget.controller.moveCamera(
                CameraUpdate.zoomTo(_currentSliderValue),
                animation: animation);
          });
        },
      ),
    );
  }
}
