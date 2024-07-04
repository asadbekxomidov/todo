import 'package:flutter/material.dart';
import 'package:todo/views/screens/auth/register_screen.dart';
import 'package:todo/views/screens/home/index_screen.dart';
import 'package:todo/views/screens/intro/intro_screen.dart';
import 'package:todo/views/screens/auth/login_screen.dart';
import 'package:todo/views/screens/start/start_screen.dart';
import 'package:todo/views/screens/onboarding/onboarding_screen.dart';

class RouteNames {
  static const String introScreen = '/';
  static const String onboardingScreen = '/onboarding';
  static const String startScreen = '/start';
  static const String loginScreen = '/login';
  static const String registerScreen = '/register';
  static const String homeScreen = '/home';

  static Map<String, WidgetBuilder> routes = {
    introScreen: (context) => const IntroScreen(),
    onboardingScreen: (context) => OnboardingScreen(),
    startScreen: (context) => const StartScreen(),
    loginScreen: (context) => const LoginScreen(),
    registerScreen: (context) => const RegisterScreen(),
    homeScreen: (context) => const HomeSCreens(),
  };
}
