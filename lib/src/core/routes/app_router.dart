
import '../../src_export.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',

        builder: (BuildContext context, GoRouterState state) {
          return const SplashPage();
        },

      ), GoRoute(
        path: RoutesPath.onboardingPath,

        builder: (BuildContext context, GoRouterState state) {
          return const OnboardingPage();
        },

      ),
    ],
  );
}