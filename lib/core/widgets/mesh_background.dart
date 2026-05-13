import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';

class MeshBackground extends StatelessWidget {
  const MeshBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Stack(
      children: [
        Container(color: AppColors.background),
        // Top Right Glow
        Positioned(
          top: -size.height * 0.2,
          right: -size.width * 0.1,
          child: _GlowCircle(color: AppColors.primary.withOpacity(0.1), size: size.width * 0.5),
        ),
        // Center Left Glow
        Positioned(
          top: size.height * 0.3,
          left: -size.width * 0.2,
          child: _GlowCircle(color: AppColors.secondary.withOpacity(0.08), size: size.width * 0.6),
        ),
        // Bottom Right Glow
        Positioned(
          bottom: -size.height * 0.1,
          right: -size.width * 0.05,
          child: _GlowCircle(color: AppColors.accent.withOpacity(0.05), size: size.width * 0.4),
        ),
        // Floating Keywords
        ..._buildFloatingKeywords(size),
      ],
    );
  }

  List<Widget> _buildFloatingKeywords(Size size) {
    final keywords = ['Flutter', 'Dart', 'BLoC', 'UI/UX', 'Mobile', 'Web', 'Clean Code', 'Git'];
    return keywords.asMap().entries.map((entry) {
      final index = entry.key;
      final text = entry.value;
      
      return Positioned(
        top: (size.height / 8) * index + 100,
        left: index % 2 == 0 ? 50 : null,
        right: index % 2 != 0 ? 50 : null,
        child: Opacity(
          opacity: 0.03,
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ).animate(onPlay: (c) => c.repeat(reverse: true))
         .moveY(begin: 0, end: 30, duration: (5 + index).seconds, curve: Curves.easeInOut),
      );
    }).toList();
  }
}

class _GlowCircle extends StatelessWidget {
  final Color color;
  final double size;
  const _GlowCircle({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: size * 0.8,
            spreadRadius: size * 0.2,
          ),
        ],
      ),
    );
  }
}
