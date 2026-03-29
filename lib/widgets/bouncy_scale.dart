import 'package:flutter/material.dart';

class BouncyScale extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const BouncyScale({super.key, required this.child, required this.onTap});

  @override
  State<BouncyScale> createState() => _BouncyScaleState();
}

class _BouncyScaleState extends State<BouncyScale> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.94).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) => _controller.forward();
  
  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onTap();
  }
  
  void _onTapCancel() => _controller.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
}
