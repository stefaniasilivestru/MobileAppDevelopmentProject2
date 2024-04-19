import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'register.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             ElevatedButton(
               onPressed: () {
                 // Navigate to the home page
                 _showToast("Back to home page");
                 Navigator.pop(context);
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
               child: const Text('Go back to home page',
                 style: TextStyle(
                   fontSize: 20.0,
                 ),
               ),
             ),
             const SizedBox(height: 16.0),
             const TextField(
               decoration: InputDecoration(
                 labelText: 'Email',
                 hintText: 'Type your email address',
                 border: OutlineInputBorder(),
                 contentPadding: EdgeInsets.all(12.0),
               ),
             ),
             const SizedBox(height: 16.0),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Type your password',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12.0),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Perform login
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
                child: const Text('Log in',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              const SizedBox(height: 60.0),
             const Text(
                'Don\'t have an account? Register here',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xFF1c2143),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the registration page and show toast
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterPage()),
                  );
                  _showToast("Ready to register!");
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
                child: const Text('Register',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
           ]
        )
      ),
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