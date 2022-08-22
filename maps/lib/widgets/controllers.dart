import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps/state/map_state.dart';
import 'package:maps/widgets/zoom_slider.dart';

import '../state/map_bloc.dart';
import '../state/map_events.dart';
import '../utils/btn_direction.dart';
import '../utils/map_constants.dart';
import 'map_btn_widget.dart';

class MapControllers extends StatelessWidget {
  const MapControllers({Key? key, required this.state}) : super(key: key);
  final MapReadyState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MapIconButton(
                onBtnPressed: () {
                  context.read<MapBloc>().add(
                      MoveEvent(myHomePoint, state.controller, state.zoom));
                },
                iconData: Icons.home_outlined,
              ),
              Row(
                children: [
                  MapIconButton(
                    onBtnPressed: () {
                      context.read<MapBloc>().add(ArrowClickedEvent(
                          BtnDirection.left, state.controller, state.zoom));
                    },
                    iconData: Icons.arrow_circle_left_outlined,
                  ),
                  Column(
                    children: [
                      MapIconButton(
                        onBtnPressed: () {
                          context.read<MapBloc>().add(ArrowClickedEvent(
                              BtnDirection.up, state.controller, state.zoom));
                        },
                        iconData: Icons.arrow_circle_up_outlined,
                      ),
                      MapIconButton(
                        onBtnPressed: () {
                          context.read<MapBloc>().add(ArrowClickedEvent(
                              BtnDirection.down, state.controller, state.zoom));
                        },
                        iconData: Icons.arrow_circle_down_outlined,
                      )
                    ],
                  ),
                  MapIconButton(
                    onBtnPressed: () {
                      context.read<MapBloc>().add(ArrowClickedEvent(
                          BtnDirection.right, state.controller, state.zoom));
                    },
                    iconData: Icons.arrow_circle_right_outlined,
                  ),
                ],
              )
            ],
          ),
          ZoomSlider(
            currentSliderValue: state.zoom,
            onSliderChanged: (newZoom) {
              context.read<MapBloc>().add(ZoomEvent(state.controller, newZoom));
            },
          )
        ]));
  }
}
