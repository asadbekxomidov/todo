// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todo/utils/app_routes.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, AppRoutes.onboardingScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          'assets/images/introimages.png',
          alignment: Alignment.bottomCenter,
          height: 280,
          width: 280,
        ),
      ),
    );
  }
}
