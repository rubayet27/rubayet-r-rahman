import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/hover_button.dart';
import '../../../utils/layout_manager.dart';
import '../models/portfolio_data_model.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatelessWidget {
  final GlobalKey projectsKey;
  final GlobalKey contactKey;
  final PortfolioDataModel data;

  const HeroSection({
    super.key,
    required this.projectsKey,
    required this.contactKey,
    required this.data,
  });

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      debugPrint('Could not launch $url');
    }
  }

  void _scrollTo(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = LayoutManager.isDesktop(context);
    final isTablet = LayoutManager.isTablet(context);

    final textContent = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: isDesktop || isTablet ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Text(
          "Hi, I'm",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.secondary,
              ),
        ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0),
        const SizedBox(height: 16),
        Text(
          data.name,
          textAlign: isDesktop || isTablet ? TextAlign.start : TextAlign.center,
          style: (isDesktop
                  ? Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 72, fontWeight: FontWeight.bold)
                  : Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold))
              ?.copyWith(height: 1.1),
        ).animate().fadeIn(duration: 500.ms, delay: 200.ms).slideY(begin: 0.2, end: 0),
        const SizedBox(height: 8),
        Text(
          data.headline,
          textAlign: isDesktop || isTablet ? TextAlign.start : TextAlign.center,
          style: (isDesktop
                  ? Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 72, fontWeight: FontWeight.bold)
                  : Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold))
              ?.copyWith(
            height: 1.1,
            foreground: Paint()
              ..shader = AppColors.primaryGradient.createShader(
                const Rect.fromLTWH(0.0, 0.0, 500.0, 100.0),
              ),
          ),
        ).animate().fadeIn(duration: 500.ms, delay: 400.ms).slideY(begin: 0.2, end: 0),
        const SizedBox(height: 32),
        SizedBox(
          width: isDesktop ? 600 : double.infinity,
          child: Text(
            data.shortBio,
            textAlign: isDesktop || isTablet ? TextAlign.start : TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  height: 1.6,
                  color: AppColors.textSecondary,
                  fontSize: 18,
                ),
          ).animate().fadeIn(duration: 500.ms, delay: 600.ms).slideY(begin: 0.2, end: 0),
        ),
        const SizedBox(height: 48),
        Wrap(
          spacing: 20,
          runSpacing: 16,
          alignment: isDesktop || isTablet ? WrapAlignment.start : WrapAlignment.center,
          children: [
            HoverButton(
              text: "View Projects",
              onPressed: () => _scrollTo(projectsKey),
            ),
            HoverButton(
              text: "Contact Me",
              isPrimary: false,
              onPressed: () => _scrollTo(contactKey),
            ),
            HoverButton(
              text: "Download CV",
              isPrimary: false,
              onPressed: () => _launchUrl('assets/cv/rubayetrrahman.pdf'),
            ),
          ],
        ).animate().fadeIn(duration: 500.ms, delay: 800.ms).slideY(begin: 0.2, end: 0),
        if (isDesktop) ...[
          const SizedBox(height: 100),
          _buildScrollIndicator(),
        ],
      ],
    );

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: isDesktop ? 900 : 800),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : (isTablet ? 40 : 20),
        vertical: isDesktop ? 140 : 100,
      ),
      child: isDesktop || isTablet
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: textContent),
                const SizedBox(width: 48),
                _buildProfileImage(context),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildProfileImage(context),
                const SizedBox(height: 60),
                textContent,
              ],
            ),
    );
  }

  Widget _buildScrollIndicator() {
    return Column(
      children: [
        Container(
          width: 30,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.textSecondary.withOpacity(0.3), width: 2),
          ),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Container(
                width: 6,
                height: 10,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ).animate(onPlay: (c) => c.repeat())
                .moveY(begin: 0, end: 15, duration: 1.5.seconds, curve: Curves.easeInOut)
                .fadeOut(duration: 1.5.seconds),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Scroll Down",
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
            letterSpacing: 1.2,
          ),
        ),
      ],
    ).animate().fadeIn(delay: 1200.ms);
  }

  Widget _buildProfileImage(BuildContext context) {
    final isDesktop = LayoutManager.isDesktop(context);
    final size = isDesktop ? 420.0 : 280.0;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primary.withOpacity(0.5),
          width: 4,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.2),
            blurRadius: 60,
            spreadRadius: 10,
          ),
          BoxShadow(
            color: AppColors.secondary.withOpacity(0.2),
            blurRadius: 40,
            spreadRadius: 5,
            offset: const Offset(10, 10),
          ),
        ],
        image: const DecorationImage(
          image: AssetImage('assets/rubayetdp.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
    ).animate().fadeIn(duration: 800.ms, delay: 400.ms).scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1.0, 1.0),
          curve: Curves.easeOutBack,
        );
  }
}
