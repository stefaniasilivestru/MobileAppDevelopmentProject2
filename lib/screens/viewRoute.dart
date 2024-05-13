import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
        title: const Text('View Route'),
      ),
      body: Text('View Route Page'),
    );
  }


}