import 'package:flutter/material.dart';
import 'package:maps/widgets/controllers.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  YandexMapController? controller;

  static const Point _myHomePoint =
      Point(latitude: 4.175446, longitude: 73.501908);
  final animation =
      const MapAnimation(type: MapAnimationType.smooth, duration: 2.0);
  final shift = 0.001;
  static const double _scale = 17.0;
  double currentSliderValue = _scale;
  late YandexMap _map;

  Future<void> onHomePressed(YandexMapController localController) =>
      localController.moveCamera(
          CameraUpdate.newCameraPosition(
              CameraPosition(target: _myHomePoint, zoom: currentSliderValue)),
          animation: animation);

  @override
  void initState() {
    _map = YandexMap(
      mapType: MapType.map,
      logoAlignment: const MapAlignment(
          horizontal: HorizontalAlignment.left,
          vertical: VerticalAlignment.bottom),
      onMapCreated: (YandexMapController yandexMapController) async {
        controller = yandexMapController;
        await onHomePressed(controller!);
      },
      onMapTap: (Point point) async {
        await controller?.deselectGeoObject();
      },
      onObjectTap: (GeoObject geoObject) async {
        if (geoObject.selectionMetadata != null) {
          await controller?.selectGeoObject(geoObject.selectionMetadata!.id,
              geoObject.selectionMetadata!.layerId);
        }
      },
    );
    setState(() {
      controller;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        _map,
        controller != null
            ? MapControllers(
                controller: controller!,
                onHomePressed: onHomePressed(controller!))
            : Container()
      ]),
    );
  }
}
