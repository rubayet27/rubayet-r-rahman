import 'experience_model.dart';
import 'project_model.dart';

class PortfolioDataModel {
  final String name;
  final String headline;
  final String shortBio;
  final List<String> aboutParagraphs;
  final String profileImageUrl;
  final List<String> skills;
  final ExperienceModel experience;
  final List<ProjectModel> projects;
  final String contactEmail;
  final String linkedinUrl;
  final String githubUrl;
  final String facebookUrl;
  final String instagramUrl;
  final String whatsappNumber;

  const PortfolioDataModel({
    required this.name,
    required this.headline,
    required this.shortBio,
    required this.aboutParagraphs,
    required this.profileImageUrl,
    required this.skills,
    required this.experience,
    required this.projects,
    required this.contactEmail,
    required this.linkedinUrl,
    required this.githubUrl,
    required this.facebookUrl,
    required this.instagramUrl,
    required this.whatsappNumber,
  });
}
