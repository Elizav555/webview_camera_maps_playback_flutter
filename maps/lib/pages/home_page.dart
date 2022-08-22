import 'package:flutter/material.dart';
import 'package:maps/utils/btn_direction.dart';
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
    await controller.moveCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(target: _myHomePoint, zoom: currentSliderValue)),
        animation: animation);
    setState(() {
      controller;
    });
  }

  Future<void> onArrowPressed(BtnDirection direction) async {
    double up = 0, down = 0, left = 0, right = 0;
    switch (direction) {
      case BtnDirection.up:
        up = shift * currentSliderValue;
        break;
      case BtnDirection.down:
        down = shift * currentSliderValue;
        break;
      case BtnDirection.right:
        right = shift * currentSliderValue;
        break;
      case BtnDirection.left:
        left = shift * currentSliderValue;
        break;
    }
    final position = await controller.getCameraPosition();
    final newPoint = Point(
        latitude: position.target.latitude + up - down,
        longitude: position.target.longitude + right - left);
    await controller.moveCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: newPoint, zoom: currentSliderValue)));
    setState(() {
      controller;
    });
  }

  Future<void> onSliderChange(double value) async {
    setState(() {
      currentSliderValue = value;
      controller.moveCamera(CameraUpdate.zoomTo(currentSliderValue),
          animation: animation);
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
        YandexMap(
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
              await controller.selectGeoObject(geoObject.selectionMetadata!.id,
                  geoObject.selectionMetadata!.layerId);
            }
          },
        ),
        _isMapInitialized
            ? MapControllers(
                controller: controller,
                onHomePressed: onHomePressed,
                onArrowPressed: onArrowPressed,
                currentSliderValue: currentSliderValue,
                onSliderChanged: onSliderChange,
              )
            : const CircularProgressIndicator()
      ]),
    );
  }
}
