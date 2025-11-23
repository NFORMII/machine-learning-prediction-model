// ...existing code...
import 'package:flutter/material.dart';
import 'screens/input_screen.dart';

void main() {
  runApp(const EntrepreneurialSuccessGaugeApp());
}

class EntrepreneurialSuccessGaugeApp extends StatelessWidget {
  const EntrepreneurialSuccessGaugeApp({super.key});

  @override
  Widget build(BuildContext context) {
    // deep, bright purple palette for the app background and accents
    const Color deepPurple = Color(0xFF6A0DAD);   // deep bright purple (vibrant)
    const Color midPurple = Color(0xFF9F7AEA);    // lighter accent purple

    final baseTextStyle = const TextStyle(color: Colors.white);

    return MaterialApp(
      title: 'Entrepreneurial Success Gauge',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: deepPurple,
          onPrimary: Colors.white,
          secondary: midPurple,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          background: deepPurple,     // ensure background uses deep bright purple
          onBackground: Colors.white,
          surface: deepPurple,        // keep surfaces deep purple as requested
          onSurface: Colors.white,
        ),
        scaffoldBackgroundColor: deepPurple, // main background = deep bright purple
        appBarTheme: const AppBarTheme(
          backgroundColor: deepPurple,
          foregroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        textTheme: TextTheme(
          displayLarge: baseTextStyle,
          displayMedium: baseTextStyle,
          displaySmall: baseTextStyle,
          headlineLarge: baseTextStyle,
          headlineMedium: baseTextStyle,
          headlineSmall: baseTextStyle,
          titleLarge: baseTextStyle,
          titleMedium: baseTextStyle,
          titleSmall: baseTextStyle,
          bodyLarge: baseTextStyle,
          bodyMedium: baseTextStyle,
          bodySmall: baseTextStyle,
          labelLarge: baseTextStyle,
          labelMedium: baseTextStyle,
          labelSmall: baseTextStyle,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: midPurple, // slightly lighter purple for input fields
          labelStyle: const TextStyle(color: Colors.white70),
          hintStyle: const TextStyle(color: Colors.white54),
          prefixIconColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: midPurple,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.all(Colors.white),
          trackColor: MaterialStateProperty.all(midPurple.withOpacity(0.6)),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        cardColor: deepPurple,
        dividerColor: Colors.white24,
      ),
      home: const InputScreen(), // starting page for evaluating entrepreneurial potential
    );
  }
}
// ...existing code...