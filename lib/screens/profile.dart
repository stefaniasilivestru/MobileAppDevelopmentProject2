import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project2_flutter/firebase_auth_service/firebase_auth_service.dart';
import 'package:project2_flutter/screens/logout.dart';
import 'package:project2_flutter/screens/routes.dart';
import 'register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
          title: const Text('Profile'),
        ),
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                User? user = snapshot.data;
                if (user != null) {
                  return LogoutPage();
                } else {
                  return Padding(
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
                              child: const Text(
                                'Go back to home page',
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            TextField(
                              controller: _emailController,
                              // Assign controller to TextField
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                hintText: 'Type your email address',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.all(12.0),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            TextField(
                              controller: _passwordController,
                              // Assign controller to TextField
                              decoration: const InputDecoration(
                                labelText: 'Password',
                                hintText: 'Type your password',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.all(12.0),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            ElevatedButton(
                              onPressed: () {
                                _showToast("Logging in...");
                                _signIn();
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color(0xFF1c2143)),
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
                              child: const Text(
                                'Log in',
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            ElevatedButton(
                              // Button for Gmail Sign In
                              onPressed: () {
                                _showToast("Signing in with Google...");
                                _signInWithGoogle();
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color(0xFFDB4437)),
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
                              child: const Text(
                                'Sign in with Google',
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                            const SizedBox(height: 40.0),
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
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterPage()),
                                );
                                _showToast("Ready to register!");
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color(0xFF1c2143)),
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
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ]));
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
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

  void _signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user != null) {
      Fluttertoast.showToast(
          msg: 'User is logged in!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color(0xFF2a9d8f),
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const RoutesPage()));
    } else {
      Fluttertoast.showToast(
          msg: 'User log in failed!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void _signInWithGoogle() async {
    try {
      // Trigger the Google sign-in flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        // Obtain the GoogleSignInAuthentication object
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        // Create a new credential
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Sign in to Firebase with the credential
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        if (userCredential.user != null) {
          // Successfully signed in
          Fluttertoast.showToast(
            msg: 'User is logged in with Google!',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color(0xFF2a9d8f),
            textColor: Colors.white,
            fontSize: 16.0,
          );
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LogoutPage()));
        } else {
          // Sign in failed
          Fluttertoast.showToast(
            msg: 'User sign in with Google failed!',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } else {
        // Google sign in cancelled
        Fluttertoast.showToast(
          msg: 'Google sign in cancelled!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print(e.toString());
      // Handle sign in errors
      Fluttertoast.showToast(
        msg: 'Sign in with Google failed: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
