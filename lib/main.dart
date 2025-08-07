import 'package:flutter/material.dart';
import 'screens/register_page2.dart';
import 'screens/welcome_page.dart';
import 'screens/tutorial_step_one.dart';
import 'screens/tutorial_step_two.dart';
import 'screens/tutorial_step_three.dart';
import 'screens/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Helapiyasa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFFF8E14), // ✅ Corrected color
        fontFamily: 'Roboto',
      ),
      home: const WelcomePage(), // ✅ Starts with your custom screen
      routes: {
        '/welcome': (context) => const WelcomePage(),
        '/tutorial_step_one': (context) => const TutorialStepOne(),
        '/tutorial_step_two': (context) => const TutorialStepTwo(),
        '/tutorial_step_three': (context) => const TutorialStepThree(),
        '/login_page': (context) => const LoginScreen(),
        '/register_page': (context) => const RegisterPersonalInfoScreen(),
        '/register_page2': (context) => const RegisterPersonalInfoScreen(),
      },
    );
  }
}