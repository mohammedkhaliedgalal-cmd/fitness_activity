import 'package:flutter/material.dart';

import 'screens/main_navigation_screen.dart';

void main() {
  runApp(const FitnessActivityApp());
}

class FitnessActivityApp extends StatefulWidget {
  const FitnessActivityApp({super.key});

  @override
  State<FitnessActivityApp> createState() => _FitnessActivityAppState();
}

class _FitnessActivityAppState extends State<FitnessActivityApp> {
  bool isDarkMode = false;

  void toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness Activity',

      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,

      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF7F8FA),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          brightness: Brightness.light,
        ),
      ),

      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          brightness: Brightness.dark,
        ),
      ),

      home: MainNavigationScreen(
        isDarkMode: isDarkMode,
        onDarkModeChanged: toggleDarkMode,
      ),
    );
  }
}