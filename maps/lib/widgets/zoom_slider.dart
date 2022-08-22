import 'package:flutter/material.dart';

class ZoomSlider extends StatelessWidget {
  const ZoomSlider(
      {Key? key,
      required this.currentSliderValue,
      required this.onSliderChanged})
      : super(key: key);
  final double currentSliderValue;
  static const double _scale = 17.0;

  final Future<void> Function(double) onSliderChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Slider(
        value: currentSliderValue,
        min: 0,
        max: _scale,
        divisions: 100,
        label: currentSliderValue.round().toString(),
        onChanged: (double value) async {
          await onSliderChanged(value);
        },
      ),
    );
  }
}
