import 'package:flutter/material.dart';

import '../utils/map_constants.dart';

class ZoomSlider extends StatelessWidget {
  const ZoomSlider(
      {Key? key,
      required this.currentSliderValue,
      required this.onSliderChanged})
      : super(key: key);
  final double currentSliderValue;

  final Function(double) onSliderChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Slider(
        value: currentSliderValue,
        min: 0,
        max: scale,
        divisions: 100,
        label: currentSliderValue.round().toString(),
        onChanged: (double value) {
          onSliderChanged(value);
        },
      ),
    );
  }
}
