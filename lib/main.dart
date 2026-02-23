import 'src/src_export.dart';
import 'src/core/di/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Grabby App',
      theme: AppTheme.getLightTheme(context),
      routerConfig: AppRouter.router,
      // builder: (context, child) {
      //   return NavigationListener(child: child ?? const SizedBox());
      // },
    );
  }
}
