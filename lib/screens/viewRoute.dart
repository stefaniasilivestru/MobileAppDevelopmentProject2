import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ViewRoutePage extends StatefulWidget {
  const ViewRoutePage({Key? key}) : super(key: key);

  @override
  _ViewRoutePageState createState() => _ViewRoutePageState();
}

class _ViewRoutePageState extends State<ViewRoutePage> {
  String routeId = '';
  List<Marker> markers = [];
  List<LatLng> routeCoordinates = [];

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        routeId = prefs.getString('routeId') ?? '';
        Logger().d('Loaded routeId: $routeId');
      });
    });
    // loadMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1c2143),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 24.0,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title:  Text(AppLocalizations.of(context)!.view_route),
      ),
      body: StreamBuilder(
          stream: FirebaseDatabase.instance
              .reference()
              .child('routes')
              .child(routeId)
              .onValue,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('An error occurred'));
            } else {
              var data = snapshot.data!.snapshot.value;
              Logger().d('Loaded data: $data');

              if (data != null && data is Map<dynamic, dynamic>) {
                var placesData = data['places']; // Access the 'places' field
                Logger().d('Loaded places: $placesData');

                if (placesData != null && placesData is Map<dynamic, dynamic>) {
                  placesData.forEach((key, value) {
                    var placeData = value as Map<dynamic, dynamic>;
                    Logger().d('Loaded place: $placeData');

                    var lat = placeData['latitude'] as double?;
                    var lng = placeData['longitude'] as double?;
                    var name = placeData['placeName'] as String?;

                    if (lat != null && lng != null && name != null) {
                      var marker = Marker(
                        width: 40.0,
                        height: 40.0,
                        point: LatLng(lat, lng),
                        child: IconButton(
                          icon: const Icon(Icons.location_on),
                          color: Colors.red,
                          iconSize: 30.0,
                          onPressed: () {
                            Fluttertoast.showToast(
                              msg: name,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: const Color(0xFF2a9d8f),
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          },
                        )
                      );
                      markers.add(marker);
                      routeCoordinates.add(LatLng(lat, lng));
                    }
                  });
                } else {
                  Logger().d('No places found');
                }
              } else {
                Logger().d('Data is not in the expected format');
              }
            }
            return _loadContent();
          }
      )

    );
  }

  Widget _loadContent() {
    if (routeCoordinates.isEmpty) {
      return const Center(child: Text('No route data found'));
    }


      LatLng initialCenter = markers.isNotEmpty ? markers.first.point : LatLng(40.38923590951672, -3.627749768768932);

      return FlutterMap(
        options: MapOptions(
          initialCenter: initialCenter,
          initialZoom: 13,
          interactionOptions: const InteractionOptions(
            flags: InteractiveFlag.doubleTapZoom |
            InteractiveFlag.pinchZoom |
            InteractiveFlag.drag,
          ),
        ),
        children: [
          openStreetMapTileLayer,
          MarkerLayer(markers: markers),
          PolylineLayer(
            polylines: [
              Polyline(
                points: routeCoordinates,
                strokeWidth: 4.0,
                color: const Color(0xFF2a9d8f),
              ),
            ],
          ),
        ],
      );
    }


  }

  TileLayer get openStreetMapTileLayer => TileLayer(
  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
);
