import 'package:flutter/material.dart';

class StaggeredFade extends StatefulWidget {
  final Widget child;
  final int delay;
  final Duration duration;
  final double slideOffset;

  const StaggeredFade({
    super.key,
    required this.child,
    this.delay = 0,
    this.duration = const Duration(milliseconds: 600),
    this.slideOffset = 50.0,
  });

  @override
  State<StaggeredFade> createState() => _StaggeredFadeState();
}

class _StaggeredFadeState extends State<StaggeredFade> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, widget.slideOffset / 100),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}
