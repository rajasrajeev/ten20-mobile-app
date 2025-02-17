// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ten20/screens/auth/login.dart';
import 'package:ten20/screens/home/home_screen.dart';
import 'package:ten20/screens/splash/splash_continue.dart';
import 'package:ten20/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loadUserId(); // Load user data

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prefs = await SharedPreferences.getInstance();
      final isFirstLaunch = prefs.getBool('is_first_launch') ?? true;
      print(prefs.getBool('is_first_launch'));

      if (mounted) {
        // Check if it's not the first launch
        if (!isFirstLaunch) {
          if (isLoggedIn) {
            if (mounted) {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            }
          } else {
            if (mounted) {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const Login()),
              );
            }
          }
        } else {
          await prefs.setBool('is_first_launch', false);

          // Adding a delay before navigating
          Timer(const Duration(seconds: 3), () {
            if (mounted) {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SplashContinue()),
              );
            }
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.width / 3,
          child: Image.asset(
            'assets/images/splash_screen_image.png',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
