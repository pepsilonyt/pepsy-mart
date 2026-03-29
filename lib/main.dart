import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(
    // ProviderScope is required for Riverpod state management
    const ProviderScope(
      child: GroceryApp(),
    ),
  );
}

class GroceryApp extends StatelessWidget {
  const GroceryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pepsy Mart',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
