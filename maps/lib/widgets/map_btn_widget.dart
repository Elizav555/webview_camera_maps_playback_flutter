import 'package:flutter/material.dart';

import '../utils/btn_direction.dart';

class MapIconButton extends StatelessWidget {
  const MapIconButton(
      {Key? key,
      required this.iconData,
      required this.direction,
      this.onHomePressed,
      this.onArrowPressed})
      : super(key: key);
  final Future<void> Function()? onHomePressed;
  final Future<void> Function(BtnDirection direction)? onArrowPressed;
  final IconData iconData;
  final BtnDirection? direction;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(16)),
        child: IconButton(
            color: Colors.black54,
            onPressed: () async {
              if (onHomePressed != null) {
                await onHomePressed!();
              } else if (onArrowPressed != null && direction != null) {
                await onArrowPressed!(direction!);
              }
            },
            icon: Icon(iconData)));
  }
}
