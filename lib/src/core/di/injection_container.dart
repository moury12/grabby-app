import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../src_export.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Onboarding & Splash
  // Data sources
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  sl.registerLazySingleton<OnboardingLocalDataSource>(
    () => OnboardingLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Bloc
  sl.registerLazySingleton(() => OnboardingSplashBloc(localDataSource: sl()));
}
