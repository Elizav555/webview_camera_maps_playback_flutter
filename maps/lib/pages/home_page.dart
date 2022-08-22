import 'package:flutter/material.dart';
import 'package:maps/widgets/controllers.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late YandexMapController controller;
  bool _isMapInitialized = false;
  static const Point _myHomePoint =
      Point(latitude: 55.796127, longitude: 49.106414);
  final animation =
      const MapAnimation(type: MapAnimationType.smooth, duration: 2.0);
  final shift = 0.001;
  static const double _scale = 17.0;
  double currentSliderValue = _scale;

  Future<void> onHomePressed() async {
    setState(() async {
      await controller.moveCamera(
          CameraUpdate.newCameraPosition(
              CameraPosition(target: _myHomePoint, zoom: currentSliderValue)),
          animation: animation);
    });
  }

  Future<void> onArrowPressed(
      {double left = 0,
      double right = 0,
      double up = 0,
      double down = 0}) async {
    setState(() async {
      final position = await controller.getCameraPosition();
      await controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: Point(
              latitude: position.target.latitude + up - down,
              longitude: position.target.longitude + right - left),
          zoom: currentSliderValue)));
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Expanded(
          child: YandexMap(
            mapType: MapType.map,
            logoAlignment: const MapAlignment(
                horizontal: HorizontalAlignment.left,
                vertical: VerticalAlignment.bottom),
            onMapCreated: (YandexMapController yandexMapController) async {
              controller = yandexMapController;
              setState(() {
                _isMapInitialized = true;
              });
              await onHomePressed();
            },
            onMapTap: (Point point) async {
              await controller.deselectGeoObject();
            },
            onObjectTap: (GeoObject geoObject) async {
              if (geoObject.selectionMetadata != null) {
                await controller.selectGeoObject(
                    geoObject.selectionMetadata!.id,
                    geoObject.selectionMetadata!.layerId);
              }
            },
            onCameraPositionChanged: (CameraPosition cameraPosition,
                CameraUpdateReason reason, bool finished) {
              print('Camera position: $cameraPosition, Reason: $reason');

              if (finished) {
                print('Camera position movement has been finished');
              }
            },
          ),
        ),
        _isMapInitialized
            ? MapControllers(
                controller: controller, onHomePressed: onHomePressed)
            : const CircularProgressIndicator()
      ]),
    );
  }
}
