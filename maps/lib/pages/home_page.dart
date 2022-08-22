import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../widgets/arrow_widget.dart';
import '../widgets/zoom_slider.dart';

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
    controller.moveCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(target: _myHomePoint, zoom: currentSliderValue)),
        animation: animation);
  }

  Future<void> onArrowPressed(
      {double left = 0,
      double right = 0,
      double up = 0,
      double down = 0}) async {
    final position = await controller.getCameraPosition();
    await controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: Point(
            latitude: position.target.latitude + up - down,
            longitude: position.target.longitude + right - left))));
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
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MapIconButton(
                          onBtnPressed: () async {
                            await onHomePressed();
                          },
                          iconData: Icons.home_outlined),
                      Row(
                        children: [
                          MapIconButton(
                              onBtnPressed: () async {
                                await onArrowPressed(left: shift);
                              },
                              iconData: Icons.arrow_circle_left_outlined),
                          Column(
                            children: [
                              MapIconButton(
                                  onBtnPressed: () async {
                                    await onArrowPressed(up: shift);
                                  },
                                  iconData: Icons.arrow_circle_up_outlined),
                              MapIconButton(
                                  onBtnPressed: () async {
                                    await onArrowPressed(down: shift);
                                  },
                                  iconData: Icons.arrow_circle_down_outlined)
                            ],
                          ),
                          MapIconButton(
                              onBtnPressed: () async {
                                await onArrowPressed(right: shift);
                              },
                              iconData: Icons.arrow_circle_right_outlined),
                        ],
                      )
                    ],
                  ),
                  ZoomSlider(
                    controller: controller,
                  )
                ]))
            : const CircularProgressIndicator()
      ]),
    );
  }
}
