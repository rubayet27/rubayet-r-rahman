import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/section_title.dart';
import '../../../utils/layout_manager.dart';
import '../models/portfolio_data_model.dart';

class AboutSection extends StatelessWidget {
  final PortfolioDataModel data;
  const AboutSection({super.key, required this.data});

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
            title: "About Me",
            subtitle: "My background and interests.",
          ),
          const SizedBox(height: 40),
          LayoutBuilder(builder: (context, constraints) {
            if (isDesktop) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: _buildTextContent(context)),
                  const SizedBox(width: 60),
                  Expanded(flex: 2, child: _buildImageCard()),
                ],
              );
            }
            return Column(
              children: [
                _buildImageCard(),
                const SizedBox(height: 40),
                _buildTextContent(context),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTextContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: data.aboutParagraphs.map((paragraph) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            paragraph,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  height: 1.6,
                  color: AppColors.textSecondary,
                ),
          ),
        );
      }).toList(),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildImageCard() {
    return GlassCard(
      padding: EdgeInsets.zero,
      child: AspectRatio(
        aspectRatio: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            data.profileImageUrl,
            fit: BoxFit.cover,
            color: AppColors.primary.withAlpha(51), // ~0.2 opacity
            colorBlendMode: BlendMode.dstATop,
          ),
        ),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 200.ms).scale(begin: const Offset(0.9, 0.9));
  }
}
