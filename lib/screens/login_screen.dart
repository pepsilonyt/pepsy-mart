import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/staggered_fade.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();

  void _login() {
    // Navigate straight to Home for mock purposes
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (_, __, ___) => const HomeScreen(),
        transitionsBuilder: (_, animation, __, child) => FadeTransition(opacity: animation, child: child),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              // App Icon / Logo
              StaggeredFade(
                delay: 100,
                slideOffset: 60,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                    color: AppTheme.accentGreen,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.shopping_basket_rounded,
                    size: 50,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 48),
              StaggeredFade(
                delay: 250,
                slideOffset: 40,
                child: Text(
                  'India\'s last minute app',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textDark,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8),
              StaggeredFade(
                delay: 400,
                slideOffset: 30,
                child: Text(
                  'Log in or sign up',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 48),
              StaggeredFade(
                delay: 550,
                slideOffset: 20,
                child: TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    hintText: 'Mobile Number',
                    prefixIcon: const Icon(Icons.phone_android, color: AppTheme.textDark),
                    prefixText: '+1 ',
                    prefixStyle: const TextStyle(color: AppTheme.textDark, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              StaggeredFade(
                delay: 700,
                slideOffset: 10,
                child: ElevatedButton(
                  onPressed: _login,
                  child: const Text('Continue', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
