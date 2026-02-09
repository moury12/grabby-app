import 'package:flutter/material.dart';
import 'package:grabby_app/src/featurs/onboarding-splash/presentation/pages/splash_page.dart';
import 'src/core/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grabby App',
      theme: AppTheme.getLightTheme(context),
      home: SplashPage(),
    );
  }
}
