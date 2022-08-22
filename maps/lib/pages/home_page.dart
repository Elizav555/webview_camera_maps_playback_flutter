import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps/state/map_bloc.dart';
import 'package:maps/state/map_events.dart';
import 'package:maps/state/map_state.dart';
import 'package:maps/widgets/controllers.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../utils/map_constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MapBloc>(
      create: (_) => MapBloc(),
      child: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          return Scaffold(
            body: Stack(children: <Widget>[
              YandexMap(
                mapType: MapType.map,
                logoAlignment: const MapAlignment(
                    horizontal: HorizontalAlignment.left,
                    vertical: VerticalAlignment.bottom),
                onMapCreated: (YandexMapController yandexMapController) {
                  context
                      .read<MapBloc>()
                      .add(LoadedEvent(yandexMapController, scale));
                },
              ),
              (state is MapReadyState)
                  ? MapControllers(
                      state: state,
                    )
                  : const CircularProgressIndicator()
            ]),
          );
        },
      ),
    );
  }
}
