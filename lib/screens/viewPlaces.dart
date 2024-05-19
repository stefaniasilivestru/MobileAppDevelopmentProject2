import 'package:flutter/material.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project2_flutter/db/database_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  }

  Future<void> _loadCoordinates() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/gps_coordinates.csv');
    List<String> lines = await file.readAsLines();

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


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1c2143),
        title:  Text(AppLocalizations.of(context)!.view_place,
          style: const TextStyle(
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
            return _buildListItem(
              placeName: 'CSV data',
              latitude: latitude,
              longitude: longitude,
              timestamp: formattedTimestamp,
              isCSV: true,
            );
          } else {
            final dbIndex = index - _coordinates.length;
            final coordinates = _dbCoordinates[dbIndex];
            final latitude = double.parse(coordinates[1]);
            final longitude = double.parse(coordinates[2]);
            final timestamp = DateTime.fromMillisecondsSinceEpoch(int.parse(coordinates[0]));
            final formattedTimestamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(timestamp);
            return _buildListItem(
              placeName: 'DB data',
              latitude: latitude,
              longitude: longitude,
              timestamp: formattedTimestamp,
              isCSV: false,
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

  Widget _buildListItem({
    required String placeName,
    required double latitude,
    required double longitude,
    required String timestamp,
    required bool isCSV,
    Function()? onTap,
    Function()? onLongPress,
  }) {
    final textColor = isCSV ? Colors.blueAccent : Color(0xFF1c2143);
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              placeName,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            Text(
              "Timestamp: $timestamp",
              style: TextStyle(
                fontSize: 14.0,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Icon(Icons.location_on, color: Color(0xFF1c2143)),
                const SizedBox(width: 8.0),
                Text(
                  "Latitude: $latitude",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: textColor,
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  "Longitude: $longitude",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: textColor,
                  ),
                ),
              ],
            ),

          ],
        ),
        onTap: onTap,
        onLongPress: onLongPress,
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