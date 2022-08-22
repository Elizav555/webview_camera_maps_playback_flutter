import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

enum BtnType { up, down, right, left, home }

class MapIconButton extends StatefulWidget {
  const MapIconButton(
      {Key? key,
      required this.controller,
      required this.iconData,
      required this.type,
      required this.onHomePressed})
      : super(key: key);
  final YandexMapController controller;
  final IconData iconData;
  final BtnType type;
  final Future<void> Function() onHomePressed;

  @override
  State<StatefulWidget> createState() => MapIconButtonState();
}

class MapIconButtonState extends State<MapIconButton> {
  final shift = 0.001;

  Future<void> onArrowPressed(
      {double left = 0,
      double right = 0,
      double up = 0,
      double down = 0}) async {
    final position = await widget.controller.getCameraPosition();
    await widget.controller.moveCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: Point(
                latitude: position.target.latitude + up - down,
                longitude: position.target.longitude + right - left))));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(16)),
        child: IconButton(
            color: Colors.black54,
            onPressed: () {
              setState(() async {
                switch (widget.type) {
                  case BtnType.right:
                    await onArrowPressed(right: shift);
                    break;
                  case BtnType.up:
                    await onArrowPressed(up: shift);
                    break;
                  case BtnType.down:
                    await onArrowPressed(down: shift);
                    break;
                  case BtnType.left:
                    await onArrowPressed(left: shift);
                    break;
                  case BtnType.home:
                    await widget.onHomePressed();
                    break;
                }
              });
            },
            icon: Icon(widget.iconData)));
  }
}
