import 'src/src_export.dart';
void main() {
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
    );
  }
}
