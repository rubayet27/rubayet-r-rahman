import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/hover_button.dart';
import '../../../core/widgets/section_title.dart';
import '../../../utils/layout_manager.dart';
import '../models/portfolio_data_model.dart';
import '../models/project_model.dart';

class ProjectsSection extends StatelessWidget {
  final PortfolioDataModel data;

  const ProjectsSection({super.key, required this.data});

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      debugPrint('Could not launch $url');
    }
  }

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
            title: "Featured Projects",
            subtitle: "Some things I've built.",
          ),
          const SizedBox(height: 40),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.projects.length,
            separatorBuilder: (context, index) => const SizedBox(height: 60),
            itemBuilder: (context, index) {
              return _buildProjectCard(context, data.projects[index], index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, ProjectModel project, int index) {
    final isDesktop = LayoutManager.isDesktop(context);
    final isTablet = LayoutManager.isTablet(context);
    final isReversed = index % 2 != 0;

    if (isDesktop || isTablet) {
      return SizedBox(
        height: 350,
        child: Stack(
          children: [
            Align(
              alignment: isReversed ? Alignment.centerRight : Alignment.centerLeft,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * (isDesktop ? 0.45 : 0.55),
                height: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    project.imageUrl,
                    fit: BoxFit.cover,
                    color: AppColors.background.withAlpha(77), // ~0.3 opacity
                    colorBlendMode: BlendMode.darken,
                  ),
                ),
              ),
            ),
            Align(
              alignment: isReversed ? Alignment.centerLeft : Alignment.centerRight,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * (isDesktop ? 0.4 : 0.5),
                child: GlassCard(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    crossAxisAlignment: isReversed ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Featured Project",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        project.title,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        project.description,
                        textAlign: isReversed ? TextAlign.left : TextAlign.right,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.textSecondary,
                              height: 1.5,
                            ),
                      ),
                      const SizedBox(height: 24),
                      Wrap(
                        spacing: 16,
                        runSpacing: 8,
                        alignment: isReversed ? WrapAlignment.start : WrapAlignment.end,
                        children: project.techStack.map((tech) {
                          return Text(
                            tech,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.secondary,
                                  fontWeight: FontWeight.w500,
                                ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),
                      HoverButton(
                        text: "View Project",
                        isPrimary: false,
                        onPressed: () => _launchUrl(project.link),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideY(begin: 0.1, end: 0);
    }

    // Mobile Layout
    return GlassCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                project.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                Text(
                  project.description,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: project.techStack.map((tech) {
                    return Text(
                      tech,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.secondary,
                            fontWeight: FontWeight.w500,
                          ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: HoverButton(
                    text: "View Project",
                    isPrimary: false,
                    onPressed: () => _launchUrl(project.link),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideY(begin: 0.1, end: 0);
  }
}
