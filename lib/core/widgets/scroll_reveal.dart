import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ScrollReveal extends StatelessWidget {
  final Widget child;
  const ScrollReveal({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child.animate()
        .fadeIn(duration: 1000.ms, curve: Curves.easeOutCubic)
        .slideY(begin: 0.1, end: 0, duration: 1000.ms, curve: Curves.easeOutCubic);
  }
}
