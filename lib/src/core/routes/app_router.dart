import '../../src_export.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      /*GoRoute(
        path: '/',

        builder: (BuildContext context, GoRouterState state) {
          return const SplashPage();
        },

      ),
      GoRoute(
        path: RoutesPath.onboardingPath,

        builder: (BuildContext context, GoRouterState state) {
          return const OnboardingPage();
        },

      ),*/GoRoute(
        path: '/',
        // path: RoutesPath.loginPath,
        // name: RoutesPath.loginPath,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      ),GoRoute(
        path: RoutesPath.signUpPath,
        name: RoutesPath.signUpPath,
        builder: (BuildContext context, GoRouterState state) {
          return const SignUpPage();
        },
      ),GoRoute(
        path: RoutesPath.forgotPasswordPath,
        name: RoutesPath.forgotPasswordPath,
        builder: (BuildContext context, GoRouterState state) {
          return const ForgotPasswordPage();
        },
      ),
      GoRoute(
        path: RoutesPath.verificationPath,
        name: RoutesPath.verificationPath,
        builder: (BuildContext context, GoRouterState state) {
          return  VerificationPage(
            extra: state.extra as String?,
          );
        },
      ),
      GoRoute(
        path: RoutesPath.forgotEmailPath,
        name: RoutesPath.forgotEmailPath,
        builder: (BuildContext context, GoRouterState state) {
          return const ForgotEmailPage();
        },
      ),  GoRoute(
        path: RoutesPath.navigationPath,
        name: RoutesPath.navigationPath,
        builder: (BuildContext context, GoRouterState state) {
          return const NavigationPage();
        },
      ),
      GoRoute(
        path: RoutesPath.resetPasswordPath,
        name: RoutesPath.resetPasswordPath,
        builder: (BuildContext context, GoRouterState state) {
          return const ResetPasswordPage();
        },
      ),
      GoRoute(
        path: RoutesPath.locationPath,
        name: RoutesPath.locationPath,
        builder: (BuildContext context, GoRouterState state) {
          return const LocationPage();
        },
      ),
    ],
  );
}