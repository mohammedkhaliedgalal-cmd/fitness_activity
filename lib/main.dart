
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'language_controller.dart';
import 'screens/main_navigation_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FitnessActivityApp());
}

class FitnessActivityApp extends StatefulWidget {
  const FitnessActivityApp({super.key});

  @override
  State<FitnessActivityApp> createState() =>
      _FitnessActivityAppState();
}

class _FitnessActivityAppState extends State<FitnessActivityApp> {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    LanguageController.locale.addListener(_onLanguageChanged);
  }

  @override
  void dispose() {
    LanguageController.locale.removeListener(_onLanguageChanged);
    super.dispose();
  }

  void _onLanguageChanged() {
    if (!mounted) return;
    setState(() {});
  }

  void _toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness Activity',

      locale: LanguageController.locale.value,

      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
        Locale('fr'),
        Locale('es'),
        Locale('de'),
        Locale('it'),
        Locale('tr'),
        Locale('ru'),
        Locale('zh'),
        Locale('ja'),
      ],

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

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
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          brightness: Brightness.dark,
        ),
      ),

      themeMode: isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,

      home: MainNavigationScreen(
        isDarkMode: isDarkMode,
        onDarkModeChanged: _toggleDarkMode,
      ),
    );
  }
}
