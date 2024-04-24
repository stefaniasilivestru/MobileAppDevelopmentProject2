import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapViewPage extends StatefulWidget {

  @override
  _MapViewPageState createState() => _MapViewPageState();
}

class _MapViewPageState extends State<MapViewPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1c2143),
        title: const Text(
          'Map View',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: content(), // Return the content widget here
    );
  }


  Widget content() {
    return FlutterMap(
        options: const MapOptions(
            initialCenter: LatLng(40.38923590951672, -3.627749768768932),
            initialZoom: 13,
            interactionOptions: InteractionOptions(flags: InteractiveFlag.doubleTapZoom | InteractiveFlag.pinchZoom | InteractiveFlag.drag),
        ),
        children: [openStreetMapTileLayer,
          MarkerLayer(markers: [
            Marker(
                point: const LatLng(40.38923590951672, -3.627749768768932),
                width: 80,
                height: 80,
                child: Stack(
                  children: [
                    const Icon(
                      Icons.location_pin,
                      size: 60,
                      color: Colors.yellow,
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Colors.white,
                        child: const Text(
                          'You are here!',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                )
            ),
            Marker(
                point: const LatLng(40.38988743556828, -3.633014220376507),
                width: 80,
                height: 80,
                child: Stack(
                  children: [
                    const Icon(
                      Icons.location_pin,
                      size: 60,
                      color: Colors.red,
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Colors.white,
                        child: const Text(
                          'Another spot!',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                )


            ),
            const Marker(
                point: LatLng(40.39527505048739, -3.630359246796122),
                width: 60,
                height: 60,
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.location_pin,
                  size: 60,
                  color: Colors.green,
                )
            ),
            const Marker(
                point: LatLng(40.39300371783269, -3.622394326054965),
                width: 60,
                height: 60,
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.location_pin,
                  size: 60,
                  color: Colors.blue,
                )
            ),
          ])]
    );
  }
}

TileLayer get openStreetMapTileLayer => TileLayer(
  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
);