import 'package:flutter/material.dart';
import '../theme.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _dropController;
  late Animation<double> _dropAnimation;

  late AnimationController _textController;
  late Animation<Offset> _slideLeftAnimation;
  late Animation<Offset> _slideRightAnimation;

  @override
  void initState() {
    super.initState();
    // 1. Instant Drop (Speed over complexity)
    _dropController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _dropAnimation = Tween<double>(begin: -200, end: 0).animate(CurvedAnimation(parent: _dropController, curve: Curves.bounceOut));

    // 2. Fast Text Slide
    _textController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    
    _slideLeftAnimation = Tween<Offset>(begin: const Offset(-2, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic));
    _slideRightAnimation = Tween<Offset>(begin: const Offset(2, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic));

    _startCinematicSequence();
  }

  void _startCinematicSequence() async {
    // Ultra-fast booting sequence
    await Future.delayed(const Duration(milliseconds: 200));
    if (mounted) _dropController.forward();
    
    await Future.delayed(const Duration(milliseconds: 400));
    if (mounted) _textController.forward();

    // Route to login much faster
    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 400),
          pageBuilder: (_, __, ___) => const LoginScreen(),
          transitionsBuilder: (_, animation, __, child) => FadeTransition(opacity: animation, child: child),
        )
      );
    }
  }

  @override
  void dispose() {
    _dropController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.accentGreen, // Zepto full green boot
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Floating Drop Animation
            AnimatedBuilder(
              animation: _dropAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _dropAnimation.value),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 30,
                          offset: const Offset(0, 15),
                        )
                      ]
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 90,
                        width: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }
            ),
            
            const SizedBox(height: 32),

            // Staggered Text Reveal
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SlideTransition(
                  position: _slideLeftAnimation,
                  child: const Text(
                    'Pepsy',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -1.5,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                SlideTransition(
                  position: _slideRightAnimation,
                  child: const Text(
                    'Mart',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      color: Colors.white, // White text on green bg
                      letterSpacing: -1.5,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
