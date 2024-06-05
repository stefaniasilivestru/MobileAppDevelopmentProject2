import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project2_flutter/firebase_auth_service/firebase_auth_service.dart';
import 'package:project2_flutter/screens/profile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
        title: Text(AppLocalizations.of(context)!.profile_register),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.profile_email,
                    hintText: AppLocalizations.of(context)!.profile_email_hint,
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.all(12.0),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _passwordController,
                  decoration:  InputDecoration(
                    labelText: AppLocalizations.of(context)!.profile_password,
                    hintText: AppLocalizations.of(context)!.profile_password_hint,
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.all(12.0),
                  ),
                ),
                const SizedBox(height: 16.0),
               TextField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.profile_confirm_password,
                    hintText: AppLocalizations.of(context)!.profile_confirm_password_hint,
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.all(12.0),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    _signUp();
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
                  child: Text(AppLocalizations.of(context)!.profile_create_account,
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

  void _signUp() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if (user != null) {
      Fluttertoast.showToast(
        msg: 'User created successfully!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color(0xFF2a9d8f),
        textColor: Colors.white,
        fontSize: 16.0
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
    } else {
      Fluttertoast.showToast(
        msg: 'User creation failed!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
    }
  }
}