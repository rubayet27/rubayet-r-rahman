part of 'routes_list.dart';

class RoutesPages {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.portfolio,
    routes: [
      GoRoute(
        name: Routes.portfolio,
        path: Routes.portfolio,
        builder: (_, _) => const PortfolioScreen(),
      ),
    ],
  );
}
