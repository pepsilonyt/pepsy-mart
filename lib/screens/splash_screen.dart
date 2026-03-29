import 'package:flutter/material.dart';
import '../theme.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;

  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoRotationAnimation;
  late Animation<Offset> _logoSlideAnimation;

  late Animation<Offset> _titleSlideAnimation;
  late Animation<double> _titleFadeAnimation;
  late Animation<Offset> _subtitleSlideAnimation;
  late Animation<double> _subtitleFadeAnimation;

  @override
  void initState() {
    super.initState();

    // Slower, dramatic engine for heavy debug modes that compile shaders late
    _logoController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));
    
    _logoSlideAnimation = Tween<Offset>(begin: const Offset(0, -3.0), end: Offset.zero).animate(
      CurvedAnimation(parent: _logoController, curve: const Interval(0.0, 0.7, curve: Curves.bounceOut)),
    );
    _logoScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: const Interval(0.0, 0.7, curve: Curves.elasticOut)),
    );
    _logoRotationAnimation = Tween<double>(begin: -0.5, end: 0.0).animate(
      CurvedAnimation(parent: _logoController, curve: const Interval(0.0, 0.7, curve: Curves.elasticOut)),
    );

    // Text slides in slowly from sides
    _textController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));

    _titleSlideAnimation = Tween<Offset>(begin: const Offset(-1.5, 0.0), end: Offset.zero).animate(
      CurvedAnimation(parent: _textController, curve: const Interval(0.0, 0.8, curve: Curves.easeOutCubic)),
    );
    _titleFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: const Interval(0.0, 0.5, curve: Curves.easeIn)),
    );

    _subtitleSlideAnimation = Tween<Offset>(begin: const Offset(1.5, 0.0), end: Offset.zero).animate(
      CurvedAnimation(parent: _textController, curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic)),
    );
    _subtitleFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: const Interval(0.2, 0.7, curve: Curves.easeIn)),
    );

    // Sequence Execution
    _playAnimationsSequence();
  }

  void _playAnimationsSequence() async {
    // Crucial: Wait 1.5 seconds FIRST. This gives the Flutter Desktop/Emulator engine time to finish its 'jank' compilation
    // so the user actually SEES the beginning of the animation unfold perfectly.
    await Future.delayed(const Duration(milliseconds: 1500));
    
    if (mounted) _logoController.forward();
    
    // Wait for the logo to hit the ground
    await Future.delayed(const Duration(milliseconds: 1400));
    
    // Slide titles in
    if (mounted) _textController.forward();

    // Hold the complete composition for 3 full seconds for the client to read
    await Future.delayed(const Duration(milliseconds: 3000));
    
    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1000), // Very slow smooth fade to login
          pageBuilder: (_, __, ___) => const LoginScreen(),
          transitionsBuilder: (_, animation, __, child) => FadeTransition(opacity: animation, child: child),
        )
      );
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SlideTransition(
              position: _logoSlideAnimation,
              child: ScaleTransition(
                scale: _logoScaleAnimation,
                child: RotationTransition(
                  turns: _logoRotationAnimation,
                  child: Container(
                    height: 160,
                    width: 160,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 40, offset: Offset(0, 20)),
                        BoxShadow(color: Colors.black12, blurRadius: 15, offset: Offset(0, 5)),
                      ],
                    ),
                    child: Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: const [
                          Icon(Icons.shopping_basket_rounded, size: 90, color: AppTheme.accentGreen),
                          Positioned(
                            top: 35,
                            right: 25,
                            child: Icon(Icons.flash_on, size: 35, color: AppTheme.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 48),
            SlideTransition(
              position: _titleSlideAnimation,
              child: FadeTransition(
                opacity: _titleFadeAnimation,
                child: const Text(
                  'Pepsy Mart',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    color: Colors.black87,
                    letterSpacing: -1.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SlideTransition(
              position: _subtitleSlideAnimation,
              child: FadeTransition(
                opacity: _subtitleFadeAnimation,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppTheme.accentGreen,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Text(
                    'India\'s last minute app',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
