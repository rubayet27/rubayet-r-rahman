import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/section_title.dart';
import '../../../utils/layout_manager.dart';
import '../models/portfolio_data_model.dart';

class ExperienceSection extends StatelessWidget {
  final PortfolioDataModel data;
  const ExperienceSection({super.key, required this.data});

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
            title: "Experience",
            subtitle: "Where I've worked.",
          ),
          const SizedBox(height: 40),
          _buildExperienceCard(context),
        ],
      ),
    );
  }

  Widget _buildExperienceCard(BuildContext context) {
    final isMobile = LayoutManager.isMobile(context);

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: isMobile ? CrossAxisAlignment.start : CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.experience.role,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: isMobile ? 20 : 24,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "@ ${data.experience.company}",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: isMobile ? 18 : 20,
                          ),
                    ),
                  ],
                ),
              ),
              if (!isMobile)
                Text(
                  data.experience.duration,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
            ],
          ),
          if (isMobile) ...[
            const SizedBox(height: 8),
            Text(
              data.experience.duration,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
          const SizedBox(height: 24),
          ...data.experience.responsibilities.map((resp) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: _buildBulletPoint(context, resp),
            );
          }),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildBulletPoint(BuildContext context, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 6.0),
          child: Icon(Icons.arrow_right, color: AppColors.secondary, size: 20),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
          ),
        ),
      ],
    );
  }
}
