import 'package:flutter/material.dart';
import 'package:task_login/screens/LoginScreen.dart';
import 'package:task_login/screens/SignupScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple, // Or any color you prefer
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login', // Start with login screen
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen()
      },
    );
  }
}