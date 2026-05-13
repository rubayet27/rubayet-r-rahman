import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          child: _GlowCircle(
            color: AppColors.primary.withOpacity(0.1),
            size: size.width * 0.5,
          ),
        ),
        // Center Left Glow
        Positioned(
          top: size.height * 0.3,
          left: -size.width * 0.2,
          child: _GlowCircle(
            color: AppColors.secondary.withOpacity(0.08),
            size: size.width * 0.6,
          ),
        ),
        // Bottom Right Glow
        Positioned(
          bottom: -size.height * 0.1,
          right: -size.width * 0.05,
          child: _GlowCircle(
            color: AppColors.accent.withOpacity(0.05),
            size: size.width * 0.4,
          ),
        ),
        // Floating Keywords
        ..._buildFloatingKeywords(size),
      ],
    );
  }

  List<Widget> _buildFloatingKeywords(Size size) {
    final keywordData = [
      {'label': 'Flutter', 'icon': FontAwesomeIcons.flutter},
      {'label': 'Dart', 'icon': FontAwesomeIcons.code},
      {'label': 'BLoC', 'icon': FontAwesomeIcons.cubes},
      {'label': 'UI/UX', 'icon': FontAwesomeIcons.palette},
      {'label': 'Mobile', 'icon': FontAwesomeIcons.mobileScreen},
      {'label': 'Web', 'icon': FontAwesomeIcons.globe},
      {'label': 'Clean Code', 'icon': FontAwesomeIcons.broom},
      {'label': 'Git', 'icon': FontAwesomeIcons.gitAlt},
    ];

    return keywordData.asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value;

      // Use index as seed for consistent random positions
      final random = math.Random(index + 42);
      final top = random.nextDouble() * (size.height - 200) + 100;
      final left = random.nextDouble() * (size.width - 200) + 100;

      return Positioned(
        top: top,
        left: left,
        child:
            Opacity(
                  opacity: 0.08,
                  child: _KeywordBubble(icon: data['icon'] as FaIconData),
                )
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .moveY(
                  begin: 0,
                  end: random.nextBool() ? 40 : -40,
                  duration: (5 + random.nextInt(5)).seconds,
                  curve: Curves.easeInOut,
                )
                .rotate(
                  begin: -0.1,
                  end: 0.1,
                  duration: (7 + random.nextInt(5)).seconds,
                  curve: Curves.easeInOut,
                ),
      );
    }).toList();
  }
}

class _KeywordBubble extends StatelessWidget {
  final FaIconData icon;

  const _KeywordBubble({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [AppColors.textPrimary.withOpacity(0.2), Colors.transparent],
        ),
        border: Border.all(
          color: AppColors.textPrimary.withOpacity(0.5),
          width: 1.5,
        ),
      ),
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Center(
            child: FaIcon(icon, size: 50, color: AppColors.textPrimary),
          ),
        ),
      ),
    );
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
