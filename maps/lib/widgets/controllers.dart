import 'package:flutter/material.dart';
import 'package:maps/widgets/zoom_slider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'arrow_widget.dart';

class MapControllers extends StatelessWidget {
  const MapControllers(
      {Key? key, required this.controller, required this.onHomePressed})
      : super(key: key);
  final shift = 0.001;
  final YandexMapController controller;
  final Future<void> onHomePressed;

  Future<void> onArrowPressed(YandexMapController localController,
      {double left = 0,
      double right = 0,
      double up = 0,
      double down = 0}) async {
    final position = await localController.getCameraPosition();
    await localController.moveCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: Point(
                latitude: position.target.latitude + up - down,
                longitude: position.target.longitude + right - left))));
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Align(
          alignment: Alignment.bottomLeft,
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.height / 6,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    MapIconButton(
                        onBtnPressed: onHomePressed,
                        iconData: Icons.home_outlined)
                  ],
                )
              ],
            ),
          )),
      Align(
          alignment: Alignment.bottomRight,
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 3 + 40,
            height: MediaQuery.of(context).size.height / 5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    MapIconButton(
                        onBtnPressed: onArrowPressed(controller, left: shift),
                        iconData: Icons.arrow_circle_left_outlined),
                    Column(
                      children: [
                        MapIconButton(
                            onBtnPressed: onArrowPressed(controller, up: shift),
                            iconData: Icons.arrow_circle_up_outlined),
                        MapIconButton(
                            onBtnPressed:
                                onArrowPressed(controller, down: shift),
                            iconData: Icons.arrow_circle_down_outlined)
                      ],
                    ),
                    MapIconButton(
                        onBtnPressed: onArrowPressed(controller, right: shift),
                        iconData: Icons.arrow_circle_right_outlined),
                  ],
                )
              ],
            ),
          )),
      Align(
          alignment: Alignment.bottomCenter,
          child: ZoomSlider(
            controller: controller,
          )),
    ]);
  }
}
