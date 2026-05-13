import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/hover_button.dart';
import '../../../utils/layout_manager.dart';
import '../models/portfolio_data_model.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactSection extends StatelessWidget {
  final PortfolioDataModel data;
  const ContactSection({super.key, required this.data});

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
        vertical: 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "What's Next?",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
          ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0),
          const SizedBox(height: 16),
          Text(
            "Get In Touch",
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ).animate().fadeIn(duration: 500.ms, delay: 200.ms).slideY(begin: 0.2, end: 0),
          const SizedBox(height: 24),
          SizedBox(
            width: isDesktop ? 600 : double.infinity,
            child: Text(
              "I'm currently looking for new opportunities. Whether you have a question, a project proposal, or just want to say hi, I'll try my best to get back to you!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.6,
                  ),
            ),
          ).animate().fadeIn(duration: 500.ms, delay: 400.ms).slideY(begin: 0.2, end: 0),
          const SizedBox(height: 48),
          HoverButton(
            text: "Say Hello",
            onPressed: () => _launchUrl('https://mail.google.com/mail/?view=cm&fs=1&to=${data.contactEmail}'), 
          ).animate().fadeIn(duration: 500.ms, delay: 600.ms).scale(begin: const Offset(0.8, 0.8)),
          const SizedBox(height: 80),
          Wrap(
            spacing: 32,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: [
              _buildSocialIcon(FontAwesomeIcons.linkedinIn, data.linkedinUrl, 'LinkedIn'),
              _buildSocialIcon(FontAwesomeIcons.github, data.githubUrl, 'GitHub'),
              _buildSocialIcon(FontAwesomeIcons.facebookF, data.facebookUrl, 'Facebook'),
              _buildSocialIcon(FontAwesomeIcons.instagram, data.instagramUrl, 'Instagram'),
              _buildSocialIcon(FontAwesomeIcons.whatsapp, 'https://wa.me/${data.whatsappNumber.replaceAll('+', '').replaceAll(' ', '')}', 'WhatsApp'),
              _buildSocialIcon(FontAwesomeIcons.envelope, 'https://mail.google.com/mail/?view=cm&fs=1&to=${data.contactEmail}', 'Email'),
            ],
          ).animate().fadeIn(duration: 500.ms, delay: 800.ms),
          const SizedBox(height: 80),
          Text(
            "Designed & Built by ${data.name}",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(FaIconData icon, String url, String tooltip) {
    return IconButton(
      onPressed: () => _launchUrl(url),
      icon: FaIcon(icon),
      iconSize: 28,
      color: AppColors.textSecondary,
      tooltip: tooltip,
      splashRadius: 24,
      hoverColor: AppColors.primary.withOpacity(0.1),
    );
  }
}
