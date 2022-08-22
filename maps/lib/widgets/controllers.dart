import 'package:flutter/material.dart';
import 'package:maps/widgets/zoom_slider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'arrow_widget.dart';

class MapControllers extends StatelessWidget {
  const MapControllers(
      {Key? key, required this.controller, required this.onHomePressed})
      : super(key: key);
  final YandexMapController controller;
  final Future<void> Function() onHomePressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MapIconButton(
                  controller: controller,
                  iconData: Icons.home_outlined,
                  type: BtnType.home,
                  onHomePressed: onHomePressed),
              Row(
                children: [
                  MapIconButton(
                      controller: controller,
                      type: BtnType.left,
                      iconData: Icons.arrow_circle_left_outlined,
                      onHomePressed: onHomePressed),
                  Column(
                    children: [
                      MapIconButton(
                          controller: controller,
                          type: BtnType.up,
                          iconData: Icons.arrow_circle_up_outlined,
                          onHomePressed: onHomePressed),
                      MapIconButton(
                          controller: controller,
                          type: BtnType.down,
                          iconData: Icons.arrow_circle_down_outlined,
                          onHomePressed: onHomePressed)
                    ],
                  ),
                  MapIconButton(
                      controller: controller,
                      type: BtnType.right,
                      iconData: Icons.arrow_circle_right_outlined,
                      onHomePressed: onHomePressed),
                ],
              )
            ],
          ),
          ZoomSlider(
            controller: controller,
          )
        ]));
  }
}
