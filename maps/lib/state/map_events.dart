import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../utils/btn_direction.dart';

abstract class MapEvent {
  final YandexMapController controller;
  final double zoom;

  MapEvent(this.controller, this.zoom);
}

class LoadedEvent extends MapEvent {
  LoadedEvent(super.controller, super.zoom);
}

class ZoomEvent extends MapEvent {
  ZoomEvent(super.controller, super.zoom);
}

class MoveEvent extends MapEvent {
  final Point newPoint;

  MoveEvent(this.newPoint, super.controller, super.zoom);
}

class ArrowClickedEvent extends MapEvent {
  final BtnDirection direction;

  ArrowClickedEvent(this.direction, super.controller, super.zoom);
}
