import 'package:flutter/material.dart';
import 'dart:async';
import 'sign_in.dart'; // Import the sign-in page

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      // Navigate to SignInPage after 4 seconds
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const SignInPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/splash.png'), // Use your asset image
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
