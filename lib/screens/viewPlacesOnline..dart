import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ViewPlacesOnlinePage extends StatefulWidget {
  const ViewPlacesOnlinePage({Key? key}) : super(key: key);

  @override
  _ViewPlacesOnlinePageState createState() => _ViewPlacesOnlinePageState();
}

class _ViewPlacesOnlinePageState extends State<ViewPlacesOnlinePage> {

  String routeId = '';

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        routeId = prefs.getString('routeId') ?? '';
        Logger().d('Loaded routeId: $routeId');
      });
    });
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
        title: Text(AppLocalizations.of(context)!.view_place),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              AppLocalizations.of(context)!.view_places_online,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1c2143),
              ),
            ),
            const SizedBox(height: 16.0),
            StreamBuilder(
                stream: FirebaseDatabase.instance.reference().child('routes').child(routeId).child('places').onValue,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('An error occurred'));
                  } else {
                    List<Widget> placesList = [];
                    var places = snapshot.data!.snapshot.value;
                    Logger().d('Loaded places: $places');
                    if (places != null && places is Map<dynamic, dynamic>) {
                      places.forEach((key, value) {
                        placesList.add(
                            Card(
                              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              elevation: 4.0,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      value['placeName'],
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF1c2143),
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on, color: Color(0xFF1c2143)),
                                        const SizedBox(width: 8.0),
                                        Text(
                                          "Latitude: ${value['latitude']}",
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                            color: Color(0xFF1c2143),
                                          ),
                                        ),
                                        const SizedBox(width: 8.0),
                                        Text(
                                          "Longitude: ${value['longitude']}",
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                            color: Color(0xFF1c2143),
                                          ),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete, color: Color(0xFF2a9d8f),),
                                      onPressed: () {
                                        FirebaseDatabase.instance.reference().child('routes').child(routeId).child('places').child(key).remove();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        );
                      });
                    } else {
                      placesList.add(const Center(child: Text('No places found')));
                    }
                    return Column(
                      children: placesList,
                    );
                  }
                }
            )
          ],
        ),
        ),
      ),

    );
  }
}