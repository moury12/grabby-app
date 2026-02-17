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

      ),*/
      GoRoute(
        path: '/',
        // path: RoutesPath.loginPath,
        // name: RoutesPath.loginPath,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: RoutesPath.signUpPath,
        name: RoutesPath.signUpPath,
        builder: (BuildContext context, GoRouterState state) {
          return const SignUpPage();
        },
      ),
      GoRoute(
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
          return VerificationPage(extra: state.extra as String?);
        },
      ),
      GoRoute(
        path: RoutesPath.forgotEmailPath,
        name: RoutesPath.forgotEmailPath,
        builder: (BuildContext context, GoRouterState state) {
          return const ForgotEmailPage();
        },
      ),
      GoRoute(
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
      GoRoute(
        path: RoutesPath.restruantDetailsPath,
        name: RoutesPath.restruantDetailsPath,
        builder: (BuildContext context, GoRouterState state) {
          return const RestruantDetailsPage();
        },
      ),
      GoRoute(
        path: RoutesPath.menuPath,
        name: RoutesPath.menuPath,
        builder: (BuildContext context, GoRouterState state) {
          return const MenuPage();
        },
      ),
      GoRoute(
        path: RoutesPath.itemDetailsPath,
        name: RoutesPath.itemDetailsPath,
        builder: (BuildContext context, GoRouterState state) {
          return const ItemDetailsPage();
        },
      ),
      GoRoute(
        path: RoutesPath.cartPath,
        name: RoutesPath.cartPath,
        builder: (BuildContext context, GoRouterState state) {
          return const CartPage();
        },
      ),
      GoRoute(
        path: RoutesPath.carPlatesPath,
        name: RoutesPath.carPlatesPath,
        builder: (BuildContext context, GoRouterState state) {
          return const CarPlatesPage();
        },
      ),
      GoRoute(
        path: RoutesPath.addCarPlatePath,
        name: RoutesPath.addCarPlatePath,
        builder: (BuildContext context, GoRouterState state) {
          return const AddCarPlatePage();
        },
      ),
      GoRoute(
        path: RoutesPath.checkoutPath,
        name: RoutesPath.checkoutPath,
        builder: (BuildContext context, GoRouterState state) {
          return const PaymentPage();
        },
      ),
      GoRoute(
        path: RoutesPath.paymentSuccessPath,
        name: RoutesPath.paymentSuccessPath,
        builder: (BuildContext context, GoRouterState state) {
          return const PaymentSuccessPage();
        },
      ),
      GoRoute(
        path: RoutesPath.orderTrackingPath,
        name: RoutesPath.orderTrackingPath,
        builder: (BuildContext context, GoRouterState state) {
          return const OrderTrackingPage();
        },
      ),
      GoRoute(
        path: RoutesPath.orderHistoryPath,
        name: RoutesPath.orderHistoryPath,
        builder: (BuildContext context, GoRouterState state) {
          return const OrderHistoryPage();
        },
      ),
      GoRoute(
        path: RoutesPath.orderDetailsPath,
        name: RoutesPath.orderDetailsPath,
        builder: (BuildContext context, GoRouterState state) {
          return const OrderDetailsPage();
        },
      ),
      GoRoute(
        path: RoutesPath.orderCanceledPath,
        name: RoutesPath.orderCanceledPath,
        builder: (BuildContext context, GoRouterState state) {
          return const OrderCanceledPage();
        },
      ),
    ],
  );
}
