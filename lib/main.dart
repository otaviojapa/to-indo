import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const ToIndoApp());
}

class ToIndoApp extends StatelessWidget {
  const ToIndoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tô Indo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFF001F54),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF001F54),
          brightness: Brightness.light,
          primary: const Color(0xFF001F54),
          onPrimary: Colors.white,
          secondary: const Color(0xFF2F80ED),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF001F54),
          foregroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFFF5F7FA),
          border: OutlineInputBorder(),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF001F54),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF001F54),
            side: const BorderSide(color: Color(0xFF001F54)),
          ),
        ),
      ),
      home: const SplashScreen(), // Definindo a tela inicial
    );
  }
}
