import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../utils/layout_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/portfolio_cubit.dart';
import 'cubit/portfolio_state.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/skills_section.dart';
import 'sections/experience_section.dart';
import 'sections/projects_section.dart';
import 'sections/contact_section.dart';
import 'sections/stats_section.dart';
import '../../core/widgets/scroll_reveal.dart';
import '../../core/widgets/mesh_background.dart';
import '../../core/widgets/glass_card.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final ScrollController _scrollController = ScrollController();
  double _scrollProgress = 0;

  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _scrollProgress = (_scrollController.offset / _scrollController.position.maxScrollExtent).clamp(0, 1);
      });
    });
  }

  void _scrollTo(GlobalKey key) {
    if (LayoutManager.isMobile(context)) {
      Navigator.pop(context); // Close drawer
    }
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = LayoutManager.isMobile(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: isMobile ? _buildDrawer() : null,
      body: Stack(
        children: [
          const MeshBackground(),
          BlocBuilder<PortfolioCubit, PortfolioState>(
            builder: (context, state) {
              if (state is PortfolioLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              } else if (state is PortfolioError) {
                return Center(
                  child: Text(
                    'Error loading portfolio: ${state.message}',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              } else if (state is PortfolioLoaded) {
                final data = state.data;
                return CustomScrollView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: ScrollReveal(
                        child: HeroSection(
                          key: _heroKey,
                          projectsKey: _projectsKey,
                          contactKey: _contactKey,
                          data: data,
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: ScrollReveal(
                        child: StatsSection(),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: ScrollReveal(
                        child: AboutSection(key: _aboutKey, data: data),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: ScrollReveal(
                        child: SkillsSection(key: _skillsKey, data: data),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: ScrollReveal(
                        child: ExperienceSection(key: _experienceKey, data: data),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: ScrollReveal(
                        child: ProjectsSection(key: _projectsKey, data: data),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: ScrollReveal(
                        child: ContactSection(key: _contactKey, data: data),
                      ),
                    ),
                    // Footer space
                    const SliverToBoxAdapter(child: SizedBox(height: 60)),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
          // Scroll Progress Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 4,
              alignment: Alignment.centerLeft,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                width: MediaQuery.of(context).size.width * _scrollProgress,
                decoration: const BoxDecoration(
                  gradient: AppColors.primaryGradient,
                ),
              ),
            ),
          ),
          if (!isMobile)
            Positioned(
              top: 20,
              left: 40,
              right: 40,
              child: _buildNavBar(),
            ),
          if (isMobile)
            Positioned(
              top: MediaQuery.of(context).padding.top + 10,
              left: 20,
              child: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, color: AppColors.textPrimary, size: 28),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNavBar() {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
      borderRadius: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Rubayet.',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..shader = AppColors.primaryGradient.createShader(
                  const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                ),
            ),
          ),
          Row(
            children: [
              _buildNavItem('About', _aboutKey),
              _buildNavItem('Experience', _experienceKey),
              _buildNavItem('Work', _projectsKey),
              _buildNavItem('Contact', _contactKey),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String title, GlobalKey key) {
    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: InkWell(
        onTap: () => _scrollTo(key),
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(
            title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: AppColors.surface,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // const DrawerHeader(
          //   decoration: BoxDecoration(color: AppColors.background),
          //   child: Center(
          //     child: Text(
          //       '',
          //       style: TextStyle(
          //         fontSize: 32,
          //         fontWeight: FontWeight.bold,
          //         color: AppColors.primary,
          //       ),
          //     ),
          //   ),
          // ),
          _buildDrawerItem('About', _aboutKey),
          _buildDrawerItem('Experience', _experienceKey),
          _buildDrawerItem('Work', _projectsKey),
          _buildDrawerItem('Contact', _contactKey),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(String title, GlobalKey key) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: AppColors.textPrimary, fontSize: 18),
      ),
      onTap: () => _scrollTo(key),
    );
  }
}
