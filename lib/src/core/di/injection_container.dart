import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../src_export.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Onboarding & Splash
  // Data sources
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  
  // LocalStorageService
  sl.registerLazySingleton<LocalStorageService>(
    () => LocalStorageService(sl()),
  );
  
  // ApiService
  sl.registerLazySingleton<ApiService>(
    () => ApiService(
      baseUrl: ApiEndpoints.baseUrl,
      localStorageService: sl(),
    ),
  );

  sl.registerLazySingleton<OnboardingLocalDataSource>(
    () => OnboardingLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Bloc
  sl.registerLazySingleton(
    () => OnboardingSplashBloc(
      localDataSource: sl(),
      localStorageService: sl(),
    ),
  );

  // ─── Feature: Auth ─────────────────────────────────────────────────────────

  // Data source
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );

  // BLoC — factory so each page gets a fresh instance
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(authRepository: sl()),
  );

  // ─── Feature: Profile ──────────────────────────────────────────────────────
  // Data source
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(sl()),
  );

  // Repository
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl()),
  );

  // Bloc
  sl.registerFactory<ProfileBloc>(
    () => ProfileBloc(profileRepository: sl()),
  );
}
