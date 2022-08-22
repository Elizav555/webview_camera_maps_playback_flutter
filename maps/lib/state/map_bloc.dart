import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../utils/btn_direction.dart';
import '../utils/map_constants.dart';
import 'map_events.dart';
import 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapLoadingState()) {
    on<LoadedEvent>(handleLoadedEvent);
    on<ZoomEvent>(handleZoomEvent);
    on<ArrowClickedEvent>(handleArrowClickedEvent);
    on<MoveEvent>(handleMoveEvent);
  }

  final _animation =
      const MapAnimation(type: MapAnimationType.smooth, duration: 2.0);

  FutureOr<void> handleLoadedEvent(LoadedEvent event, Emitter<MapState> emit) {
    emit(MapReadyState(event.controller, event.zoom));
    handleMoveEvent(MoveEvent(myHomePoint, event.controller, event.zoom), emit);
  }

  Future<FutureOr<void>> handleZoomEvent(
      ZoomEvent event, Emitter<MapState> emit) async {
    await event.controller
        .moveCamera(CameraUpdate.zoomTo(event.zoom), animation: _animation);
    emit(MapReadyState(event.controller, event.zoom));
  }

  Future<FutureOr<void>> handleMoveEvent(
      MoveEvent event, Emitter<MapState> emit) async {
    await event.controller.moveCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(target: event.newPoint, zoom: event.zoom)),
        animation: _animation);
    emit(MapReadyState(event.controller, event.zoom));
  }

  Future<void> handleArrowClickedEvent(
      ArrowClickedEvent event, Emitter<MapState> emit) async {
    final position = await event.controller.getCameraPosition();
    final newPoint = _calculateNewPoint(event.direction, event.zoom, position);
    handleMoveEvent(MoveEvent(newPoint, event.controller, event.zoom), emit);
  }

  Point _calculateNewPoint(
      BtnDirection direction, double zoom, CameraPosition position) {
    double up = 0, down = 0, left = 0, right = 0;
    final constant = scale - zoom == 0 ? 1 : pow(scale - zoom, 3);
    final newShift = shift * constant;
    switch (direction) {
      case BtnDirection.up:
        up = newShift;
        break;
      case BtnDirection.down:
        down = newShift;
        break;
      case BtnDirection.right:
        right = newShift;
        break;
      case BtnDirection.left:
        left = newShift;
        break;
    }
    return Point(
        latitude: position.target.latitude + up - down,
        longitude: position.target.longitude + right - left);
  }
}
