import '../../src_export.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',

        builder: (BuildContext context, GoRouterState state) {
          return const SplashPage();
        },
        // routes: <RouteBase>[
        //   GoRoute(
        //     path: 'details',
        //     builder: (BuildContext context, GoRouterState state) {
        //       return const DetailsScreen();
        //     },
        //   ),
        // ],
      ),
    ],
  );
}