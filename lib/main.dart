import 'package:flutter/material.dart';
import 'app.dart';

void main() {
  runApp(const MyApp());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
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
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF1c2143),
              ),
              child: Text('Tripify Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24.0)),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Color(0xFF1c2143)),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle, color: Color(0xFF1c2143)),
              title: const Text('Profile'),
              onTap: () {
                // Go to the profile page

                Navigator.pop(context);
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
            const Text(
              'Welcome to Tripify! Here you can plan your trips and share your experiences with others.',
              textAlign: TextAlign.center,
              style: TextStyle(
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
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF2a9d8f))),
              child: const Text('Go to the profile page',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: const Center(
        child: Text(
          'This is the profile page',
        ),
      ),
    );
  }
}
