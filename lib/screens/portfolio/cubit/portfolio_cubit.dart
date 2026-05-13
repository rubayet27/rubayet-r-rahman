import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/experience_model.dart';
import '../models/portfolio_data_model.dart';
import '../models/project_model.dart';
import 'portfolio_state.dart';

class PortfolioCubit extends Cubit<PortfolioState> {
  PortfolioCubit() : super(PortfolioInitial());

  void loadPortfolioData() async {
    emit(PortfolioLoading());

    try {
      // Simulate network delay to show loading state
      await Future.delayed(const Duration(milliseconds: 800));

      final data = PortfolioDataModel(
        name: "Rubayet R Rahman",
        headline: "Flutter Developer.",
        shortBio:
            "I build modern, scalable, and fully responsive applications. Passionate about clean architecture, realtime integrations, and crafting premium user experiences.",
        aboutParagraphs: [
          "Hello! I'm Rubayet, a passionate Flutter Developer based in Bangladesh. I enjoy creating things that live on the internet, whether that be websites, applications, or anything in between.",
          "With 1.8 years of professional experience at AppDevs, I've had the privilege of working on scalable production-level applications. My main focus these days is building accessible, inclusive products and digital experiences.",
          "I also have a strong interest in Backend engineering, AI, and modern app architecture. When I'm not coding, I'm usually exploring new technologies or sharing my knowledge with the developer community.",
        ],
        profileImageUrl:
            'https://images.unsplash.com/photo-1542831371-29b0f74f9713?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        skills: [
          'Dart',
          'Flutter',
          'Python',
          'API Integration',
          'WebSocket',
          'Firebase',
          'Git & GitHub',
          'Responsive Design',
          'Dio',
          'Http',
          'Clean Architecture',
          'Bloc',
          'Provider',
          'Getx',
          'Firebase',
          'Django',
          'Fast Api',
          'MySql',
        ],
        experience: const ExperienceModel(
          role: "Flutter Developer",
          company: "AppDevs",
          duration: "1.8 Years",
          responsibilities: [
            "Developed and maintained production-grade Flutter applications",
            "Worked on scalable UI systems",
            "Integrated APIs, realtime systems, and complex app features",
            "Collaborated with teams on commercial marketplace and service platforms",
          ],
        ),
        projects: const [
          ProjectModel(
            title: 'SalonHub',
            description:
                'A comprehensive platform for salon booking and management. Built with clean architecture and scalable state management.',
            techStack: ['Flutter', 'Dart', 'REST API'],
            link: 'https://codecanyon.net/',
            imageUrl:
                'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
          ),
          ProjectModel(
            title: 'AdMart',
            description:
                'A commercial marketplace platform with real-time features and complex UI systems.',
            techStack: ['Flutter', 'Firebase', 'Clean Architecture'],
            link: 'https://codecanyon.net/',
            imageUrl:
                'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
          ),
          ProjectModel(
            title: 'CarBid',
            description:
                'An interactive car bidding application utilizing WebSockets for live data and seamless user experience.',
            techStack: ['Flutter', 'WebSocket', 'GoRouter'],
            link: 'https://codecanyon.net/',
            imageUrl:
                'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
          ),
        ],
        contactEmail: "rubayetrr27@gmail.com",
        linkedinUrl: "https://www.linkedin.com/in/rubayet-r-rahman-64885329b/",
        githubUrl: "https://github.com/rubayet27",
        facebookUrl: "https://www.facebook.com/share/1E1WyrrvWt/",
        instagramUrl:
            "https://www.instagram.com/rubayet_r_rahman?igsh=MWgwaGVuMTd6b29hMg==",
        whatsappNumber: "+8801315300224",
      );

      emit(PortfolioLoaded(data));
    } catch (e) {
      emit(PortfolioError(e.toString()));
    }
  }
}
