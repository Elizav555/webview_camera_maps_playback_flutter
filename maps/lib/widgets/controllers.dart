import 'package:flutter/material.dart';
import 'package:maps/widgets/zoom_slider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../utils/btn_direction.dart';
import 'map_btn_widget.dart';

class MapControllers extends StatelessWidget {
  const MapControllers(
      {Key? key,
      required this.controller,
      required this.onHomePressed,
      required this.onArrowPressed,
      required this.onSliderChanged,
      required this.currentSliderValue})
      : super(key: key);
  final shift = 0.001;
  final YandexMapController controller;
  final Future<void> Function() onHomePressed;
  final Future<void> Function(BtnDirection direction) onArrowPressed;
  final Future<void> Function(double) onSliderChanged;
  final double currentSliderValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MapIconButton(
                onHomePressed: onHomePressed,
                iconData: Icons.home_outlined,
                direction: null,
              ),
              Row(
                children: [
                  MapIconButton(
                    onArrowPressed: onArrowPressed,
                    iconData: Icons.arrow_circle_left_outlined,
                    direction: BtnDirection.left,
                  ),
                  Column(
                    children: [
                      MapIconButton(
                        onArrowPressed: onArrowPressed,
                        iconData: Icons.arrow_circle_up_outlined,
                        direction: BtnDirection.up,
                      ),
                      MapIconButton(
                        onArrowPressed: onArrowPressed,
                        iconData: Icons.arrow_circle_down_outlined,
                        direction: BtnDirection.down,
                      )
                    ],
                  ),
                  MapIconButton(
                    onArrowPressed: onArrowPressed,
                    iconData: Icons.arrow_circle_right_outlined,
                    direction: BtnDirection.right,
                  ),
                ],
              )
            ],
          ),
          ZoomSlider(
            currentSliderValue: currentSliderValue,
            onSliderChanged: onSliderChanged,
          )
        ]));
  }
}
