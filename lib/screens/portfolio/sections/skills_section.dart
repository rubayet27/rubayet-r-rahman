import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/section_title.dart';
import '../../../utils/layout_manager.dart';
import '../models/portfolio_data_model.dart';

class SkillsSection extends StatelessWidget {
  final PortfolioDataModel data;

  const SkillsSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final isDesktop = LayoutManager.isDesktop(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : 20,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: "Skills",
            subtitle: "Technologies I work with.",
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: data.skills.asMap().entries.map((entry) {
              int idx = entry.key;
              String skill = entry.value;
              return _buildSkillChip(context, skill, idx);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(BuildContext context, String skill, int index) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      borderRadius: 30,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.code, size: 16, color: AppColors.primary),
          const SizedBox(width: 8),
          Text(
            skill,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms, delay: Duration(milliseconds: 50 * index)).scale(begin: const Offset(0.8, 0.8));
  }
}
