import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../utils/layout_manager.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = LayoutManager.isDesktop(context);
    
    final stats = [
      {'value': '3+', 'label': 'Years Exp.'},
      {'value': '20+', 'label': 'Projects'},
      {'value': '15+', 'label': 'Clients'},
      {'value': '100%', 'label': 'Commitment'},
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : 20,
        vertical: 40,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: isDesktop ? 4 : 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: isDesktop ? 1.5 : 1.2,
            children: stats.asMap().entries.map((entry) {
              return _buildStatItem(entry.value['value']!, entry.value['label']!, entry.key);
            }).toList(),
          );
        },
      ),
    );
  }

  Widget _buildStatItem(String value, String label, int index) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ).animate().fadeIn(delay: (200 * index).ms).scale(begin: const Offset(0.5, 0.5)),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
