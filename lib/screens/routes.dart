import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:project2_flutter/screens/viewPlaces.dart';

class RoutesPage extends StatefulWidget {
  const RoutesPage({super.key});

  @override
  _RoutesPageState createState() => _RoutesPageState();
}

class _RoutesPageState extends State<RoutesPage> {
  final List<String> routes = [];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1c2143),
        title: const Text(
          'Routes',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding (
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget> [
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _viewPlacesOffline();
              },
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all<Color>(
                    const Color(0xFF2a9d8f)),
                // Background color
                foregroundColor:
                MaterialStateProperty.all<Color>(
                    Colors.white),
                // Text color
                shape: MaterialStateProperty.all<
                    RoundedRectangleBorder>(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    // Set border radius to zero for square corners
                    side: BorderSide.none, // Remove border
                  ),
                ),
              ),
              child: const Text('View Places Offline Mode'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _showToast('View Places Online Mode');
                StreamBuilder(
                  stream: FirebaseDatabase.instance.reference().child('routes').onValue,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text('Error loading feedbacks');
                    } else {
                      List<Widget> routeList = [];
                      Map<dynamic, dynamic> routes = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                      if (routes != null) {
                        routes.forEach((key, value) {
                          routeList.add(
                            ListTile(
                              title: Text(value['routeName']),
                            ),
                          );
                        });
                      }
                      Logger().d('Route list: $routeList');
                      return ListView(
                        children: routeList,
                      );
                    }
                  },
                );
              },
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all<Color>(
                    const Color(0xFF2a9d8f)),
                // Background color
                foregroundColor:
                MaterialStateProperty.all<Color>(
                    Colors.white),
                // Text color
                shape: MaterialStateProperty.all<
                    RoundedRectangleBorder>(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    // Set border radius to zero for square corners
                    side: BorderSide.none, // Remove border
                  ),
                ),
              ),
              child: const Text('List Routes'),
            ),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add route functionality
          _addRoute();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addRoute() {
    // show dialog to add route
    String newRoute = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Route'),
          content: TextField(
            onChanged: (value) {
              newRoute = value; // update the name
            },
            decoration: const InputDecoration(
              hintText: 'Enter route name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _showToast('Route not added');
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  routes.add(newRoute);
                });
                Navigator.pop(context);
                _showToast('Route added: $newRoute');
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _deleteRoute(int index) {
    // show dialog to delete route
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Route'),
          content: Text('Are you sure you want to delete ${routes[index]}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _showToast('Route not deleted');
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  routes.removeAt(index);
                });
                Navigator.pop(context);
                _showToast('Route deleted');
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _addPlace() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Place'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _latitudeController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Latitude'),
              ),
              TextField(
                controller: _longitudeController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Longitude'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String name = _nameController.text;
                double latitude = double.parse(_latitudeController.text);
                double longitude = double.parse(_longitudeController.text);

                // Do something with the entered data, e.g., add to a list
                // or call a function to add the place to your data model
                _savePlace(name, latitude, longitude);
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _savePlace(String name, double latitude, double longitude) {
    print('Adding Place: $name, Latitude: $latitude, Longitude: $longitude');
    _showToast('Place added: $name');
    Logger logger = Logger();
    logger.d('Adding Place: $name, Latitude: $latitude, Longitude: $longitude');
  }

  // list of places saved from CSV and local DB
  void _viewPlacesOffline() {
    _showToast('Viewing places');
    Navigator.push(context,  MaterialPageRoute(builder: (context) => ViewPlacesPage()));
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: const Color(0xFF2a9d8f),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  // List routes from firebase routes database
  void _listRoutes() {

  }

}
