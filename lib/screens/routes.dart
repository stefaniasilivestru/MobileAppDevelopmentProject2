import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:project2_flutter/screens/profile.dart';
import 'package:project2_flutter/screens/viewPlaces.dart';
import 'package:project2_flutter/screens/viewPlacesOnline..dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoutesPage extends StatefulWidget {
  const RoutesPage({super.key});

  @override
  _RoutesPageState createState() => _RoutesPageState();
}

class _RoutesPageState extends State<RoutesPage> {
  final TextEditingController _routeNameController = TextEditingController();
  final TextEditingController _placeNameController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;

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
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _viewPlacesOffline();
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xFF2a9d8f)),
                  // Background color
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  // Text color
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                      // Set border radius to zero for square corners
                      side: BorderSide.none, // Remove border
                    ),
                  ),
                ),
                child: const Text('View Places Offline Mode'),
              ),
              StreamBuilder(
                  stream: FirebaseDatabase.instance
                      .reference()
                      .child('routes')
                      .onValue,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text('An error occurred'),
                      );
                    } else {
                      List<Widget> routesList = [];
                      Map<dynamic, dynamic> routes = snapshot
                          .data!.snapshot.value as Map<dynamic, dynamic>;
                      if (routes != null) {
                        routes.forEach((key, value) {
                          routesList.add(
                           Card(
                             margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                             elevation: 4.0,
                             child: Padding(
                               padding: const EdgeInsets.all(10.0),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text(
                                     value['routeName'],
                                     style: const TextStyle(
                                       fontSize: 20.0,
                                       fontWeight: FontWeight.bold,
                                       color: Color(0xFF1c2143),
                                     ),
                                   ),
                                   const SizedBox(height: 8.0),
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       Expanded(
                                           child: ElevatedButton(
                                             onPressed: () {
                                               // view weather
                                           },
                                             style: ButtonStyle(
                                               backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF1c2143)), // Background color
                                               foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Text color
                                               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                 const RoundedRectangleBorder(
                                                   borderRadius: BorderRadius.zero, // Set border radius to zero for square corners
                                                   side: BorderSide.none, // Remove border
                                                 ),
                                               ),
                                             ),
                                             child: const Text('View Weather', style: TextStyle(fontSize: 14.0), textAlign: TextAlign.center),
                                           ),
                                       ),
                                       const SizedBox(width: 8.0),
                                       Expanded(
                                           child: ElevatedButton(
                                             onPressed: () {
                                               // view route
                                           },
                                             style: ButtonStyle(
                                               backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF1c2143)), // Background color
                                               foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Text color
                                               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                 const RoundedRectangleBorder(
                                                   borderRadius: BorderRadius.zero, // Set border radius to zero for square corners
                                                   side: BorderSide.none, // Remove border
                                                 ),
                                               ),
                                             ),
                                             child: const Text('View Route'),
                                           ),
                                       ),
                                     ],
                                   ),
                                   const SizedBox(height: 8.0),
                                   Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                // save the routeId in the shared preferences to be able to get it in the view places page
                                                SharedPreferences.getInstance().then((prefs) {
                                                  prefs.setString('routeId', key);
                                                });
                                                Logger().d('Route ID: $key');

                                                _addPlace(context, user);
                                            },
                                              style: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF2a9d8f)), // Background color
                                                foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Text color
                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.zero, // Set border radius to zero for square corners
                                                    side: BorderSide.none, // Remove border
                                                  ),
                                                ),
                                              ),
                                              child: const Text('Add Place', style: TextStyle(fontSize: 14.0), textAlign: TextAlign.center),
                                            ),
                                        ),
                                        const SizedBox(width: 8.0),
                                        Expanded(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                // view places
                                                SharedPreferences.getInstance().then((prefs) {
                                                  prefs.setString('routeId', key);
                                                });
                                                Logger().d('Route ID: $key');
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPlacesOnlinePage()));
                                            },
                                              style: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF1c2143)), // Background color
                                                foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Text color
                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.zero, // Set border radius to zero for square corners
                                                    side: BorderSide.none, // Remove border
                                                  ),
                                                ),
                                              ),
                                              child: const Text('View Places', style: TextStyle(fontSize: 14.0), textAlign: TextAlign.center),
                                            ),
                                        ),
                                        const SizedBox(width: 8.0),
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              _deleteRoute(key);
                                            },
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all<Color>(Colors.black), // Background color
                                              foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Text color
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.zero, // Set border radius to zero for square corners
                                                  side: BorderSide.none, // Remove border
                                                ),
                                              ),
                                            ),
                                            child: const Text('Delete Route', style: TextStyle(fontSize: 14.0), textAlign: TextAlign.center),
                                          ),
                                        ),
                                      ],
                                   )
                                 ]
                               )
                             )
                           )
                          );
                        });
                      }
                      return Column(
                        children: routesList,
                      );
                    }
                  })
            ],
          )),),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add route functionality
          _addRoute(context, user);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addRoute(BuildContext context, User? user) {
    // show dialog to add route name into the database
    // if user is not logged in, show a dialog to ask user to login
    if (user == null) {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Log in Required'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('You need to log in to add routes.'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Log in'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
              ),
            ],
          );
        },
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Route'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _routeNameController,
                decoration: const InputDecoration(labelText: 'Route Name'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _addRouteToDatabase(user);
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addRouteToDatabase(User? user) {
    DatabaseReference routesRef =
        FirebaseDatabase.instance.reference().child('routes');

    String newRouteKey = routesRef.push().key ?? '';
    String routeName = _routeNameController.text;
    // Create a map for the route data
    Map<String, dynamic> routeData = {
      'routeName': routeName,
      'routeId': newRouteKey,
      'places': [],
    };

    // Add places to the route
    // List<Map<String, dynamic>> places = [];
    // Map<String, dynamic> placeData = {
    //   'latitude': 40.4168, // Example latitude
    //   'longitude': -3.7038, // Example longitude
    //   'placeName': 'Casa de Papel', // Example place name
    // };

    // String newPlaceKey = FirebaseDatabase.instance
    //         .reference()
    //         .child('routes/$newRouteKey/places')
    //         .push()
    //         .key ??
    //     '';
    // placeData['placeId'] = newPlaceKey;
    //
    // places.add(placeData);
    // routeData['places'] = places;

    // set in the database
    routesRef.child(newRouteKey).set(routeData).then((_) {
      _showToast('Route added successfully');
    }).catchError((error) {
      _showToast('Failed to add route: $error');
    });
  }

  void _addPlace(BuildContext context, User? user) {
    // show dialog to add route name into the database
    // if user is not logged in, show a dialog to ask user to login
    if (user == null) {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Log in Required'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('You need to log in to add places on routes.'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Log in'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
              ),
            ],
          );
        },
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Place'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _placeNameController,
                decoration: const InputDecoration(labelText: 'Place Name'),
              ),
              TextField(
                controller: _latitudeController,
                decoration: const InputDecoration(labelText: 'Latitude'),
              ),
              TextField(
                controller: _longitudeController,
                decoration: const InputDecoration(labelText: 'Longitude'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Add place to the route
                SharedPreferences.getInstance().then((prefs) {
                  String routeId = prefs.getString('routeId') ?? '';
                  Map<String, dynamic> placeData = {
                    'placeName': _placeNameController.text,
                    'latitude': double.parse(_latitudeController.text),
                    'longitude': double.parse(_longitudeController.text),
                  };
                  _addPlaceToDatabase(user, routeId, placeData);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addPlaceToDatabase(User? user, String routeId, Map<String, dynamic> placeData) {
    DatabaseReference placesRef = FirebaseDatabase.instance.reference().child('routes/$routeId/places');
    String newPlaceKey = placesRef.push().key ?? '';
    placeData['placeId'] = newPlaceKey;
    placesRef.child(newPlaceKey).set(placeData).then((_) {
      _showToast('Place added successfully');
    }).catchError((error) {
      _showToast('Failed to add place: $error');
    });

  }



  void _deleteRoute(String key) {

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delete route"),
            content: const Text("Are you sure you want to delete this route?"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // Delete feedback from database
                  DatabaseReference feedbackRef = FirebaseDatabase.instance.reference().child('routes').child(key);
                  feedbackRef.remove().then((_) {
                    Fluttertoast.showToast(
                        msg: "Route deleted successfully.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: const Color(0xFF2a9d8f)
                    );
                  }).catchError((error) {
                    print("Failed to delete route: $error");
                    Fluttertoast.showToast(
                        msg: "Failed to delete route.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red
                    );
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('Delete'),
              ),
            ],
          );
        }
    );
  }
  // list of places saved from CSV and local DB
  void _viewPlacesOffline() {
    _showToast('Viewing places');
    Navigator.push(
      context as BuildContext,
      MaterialPageRoute(builder: (context) => ViewPlacesPage()),
    );
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
}
