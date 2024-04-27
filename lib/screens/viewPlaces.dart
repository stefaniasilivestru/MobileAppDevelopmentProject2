import 'package:flutter/material.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project2_flutter/db/database_helper.dart';


class ViewPlacesPage extends StatefulWidget {
  @override
  _ViewPlacesPageState createState() => _ViewPlacesPageState();
}

class _ViewPlacesPageState extends State<ViewPlacesPage> {
  List<List<String>> _coordinates = [];
  List<List<String>> _dbCoordinates = [];
  Logger logger = Logger();

  @override
  void initState() {
    super.initState();
    _loadCoordinates();
    _loadDbCoordinates();
    logger.d('Loaded coordinates: $_coordinates');
  }


  Future<void> _loadCoordinates() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/gps_coordinates.csv');
    logger.d('Loading file: ${file.path}');

    List<String> lines = await file.readAsLines();
    logger.d('Loaded lines: $lines');

    setState(() {
      _coordinates = lines.map((line) => line.split(';')).toList();
    });
  }

  Future<void> _loadDbCoordinates() async {
    final db = DatabaseHelper.instance;
    final coordinates = await db.getCoordinates();
    logger.d('Loaded coordinates from database: $coordinates');

    setState(() {
      _dbCoordinates = coordinates.map((coordinate) => [
        coordinate['timestamp'].toString(),
        coordinate['latitude'].toString(),
        coordinate['longitude'].toString(),
      ]).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1c2143),
        title: const Text(
          'View Places',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemCount: _coordinates.length + _dbCoordinates.length,
        itemBuilder: (context, index) {
          if (index < _coordinates.length) {
            final coordinates = _coordinates[index];
            final latitude = double.parse(coordinates[1]);
            final longitude = double.parse(coordinates[2]);
            final timestamp = DateTime.fromMillisecondsSinceEpoch(int.parse(coordinates[0]));
            final formattedTimestamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(timestamp);
            return ListTile(
              title: Text('CSV data:\n Latitude: $latitude, Longitude: $longitude'),
              subtitle: Text('Timestamp: $formattedTimestamp'),
            );
          } else {
            final dbIndex = index - _coordinates.length;
            final coordinates = _dbCoordinates[dbIndex];
            final latitude = double.parse(coordinates[1]);
            final longitude = double.parse(coordinates[2]);
            final timestamp = DateTime.fromMillisecondsSinceEpoch(int.parse(coordinates[0]));
            final formattedTimestamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(timestamp);
            return ListTile(
              title: Text('DB data:\n Timestamp: $formattedTimestamp, Latitude: $latitude, Longitude: $longitude', style: const TextStyle(color: Colors.blueAccent)),
              onTap: () {
                _showDeleteDialog(coordinates[0]);
              },
              onLongPress: () {
                _showUpdateDialog(coordinates[0], coordinates[1], coordinates[2]);
              },
            );
          }
        },
      ),
    );
  }

  void _showDeleteDialog(String timestamp) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete this coordinate?'),
          content: const Text('This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final db = DatabaseHelper.instance;
                db.deleteCoordinate(timestamp);
                _loadDbCoordinates();
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showUpdateDialog(String timestamp, String currentLat, String currentLong) {
    TextEditingController latController = TextEditingController(text: currentLat);
    TextEditingController longController = TextEditingController(text: currentLong);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update this coordinate?'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget> [
              TextField(
                controller: latController,
                decoration: const InputDecoration(labelText: 'Latitude'),
              ),
              TextField(
                controller: longController,
                decoration: const InputDecoration(labelText: 'Longitude'),
              ),
            ],
          ),
          actions: <Widget> [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final db = DatabaseHelper.instance;
                await db.updateCoordinate(timestamp, latController.text, longController.text);
                _loadDbCoordinates();
                Navigator.of(context).pop();
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }


}