import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project2_flutter/firebase_options.dart';
import 'app.dart';
import 'screens/profile.dart';
import 'screens/routes.dart';
import 'screens/contactus.dart';
import 'screens/share.dart';
import 'screens/settings.dart';
import 'screens/map.dart';
import 'package:logger/logger.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options : DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Building MyHomePage');
    var logger = Logger();
    logger.d('Building MyHomePage');

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
        title: Text(AppLocalizations.of(context)!.home_text),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF1c2143),
              ),
              padding: EdgeInsets.all(60.0),
              child: Text('Tripify Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24.0)),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Color(0xFF1c2143)),
              title:  Text(AppLocalizations.of(context)!.home_text),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle, color: Color(0xFF1c2143)),
              title:  Text(AppLocalizations.of(context)!.profile_text),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.collections, color: Color(0xFF1c2143)),
              title: Text(AppLocalizations.of(context)!.routes_text),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RoutesPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.map_rounded, color: Color(0xFF1c2143)),
              title:  Text(AppLocalizations.of(context)!.map_text),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.call, color: Color(0xFF1c2143)),
              title: Text(AppLocalizations.of(context)!.feedback_text),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactusPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.ios_share_outlined, color: Color(0xFF1c2143)),
              title: Text(AppLocalizations.of(context)!.share_text),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SharePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Color(0xFF1c2143)),
              title: Text(AppLocalizations.of(context)!.settings_text),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),
          ]
        )
      ),
      body: Center(
        child: Column(
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/logo_tripify.jpg"),
            const SizedBox(height: 20),
            Text(AppLocalizations.of(context)!.home_welcome_text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1c2143),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed:() {
                // navigate to the profile page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF2a9d8f)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(AppLocalizations.of(context)!.home_go_to_profile,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

