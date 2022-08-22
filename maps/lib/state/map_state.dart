import 'package:yandex_mapkit/yandex_mapkit.dart';

abstract class MapState {}

class MapReadyState extends MapState {
  final double zoom;
  final YandexMapController controller;

  MapReadyState(this.controller, this.zoom);
}

class MapLoadingState extends MapState {}
