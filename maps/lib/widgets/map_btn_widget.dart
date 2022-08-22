import 'package:flutter/material.dart';

class MapIconButton extends StatelessWidget {
  const MapIconButton({
    Key? key,
    required this.iconData,
    required this.onBtnPressed,
  }) : super(key: key);
  final Function() onBtnPressed;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(16)),
        child: IconButton(
            color: Colors.black54,
            onPressed: () async {
              onBtnPressed();
            },
            icon: Icon(iconData)));
  }
}
