import 'package:get_it/get_it.dart';
import 'package:grabby_app/src/featurs/profile-settings/data/services/branch_service.dart';
import 'package:grabby_app/src/featurs/profile-settings/presentation/bloc/branch/branch_bloc.dart';

import 'package:grabby_app/src/featurs/branch/data/datasources/branch_remote_data_source.dart';
import 'package:grabby_app/src/featurs/branch/data/repositories/branch_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:grabby_app/src/featurs/cart-checkout/data/datasources/car_plate_remote_data_source.dart';
import 'package:grabby_app/src/featurs/cart-checkout/data/repositories/car_plate_repository_impl.dart';
import 'package:grabby_app/src/featurs/cart-checkout/domain/repositories/car_plate_repository.dart';
import 'package:grabby_app/src/featurs/cart-checkout/presentation/bloc/car_plate_bloc.dart';
import 'package:grabby_app/src/featurs/cart-checkout/data/datasources/cart_remote_data_source.dart';
import 'package:grabby_app/src/featurs/cart-checkout/data/repositories/cart_repository_impl.dart';
import 'package:grabby_app/src/featurs/cart-checkout/domain/repositories/cart_repository.dart';
import 'package:grabby_app/src/featurs/cart-checkout/presentation/bloc/cart_bloc.dart';
import '../../src_export.dart' ;

final sl = GetIt.instance;

Future<void> init() async {
  //! Shared
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  sl.registerLazySingleton<LocalStorageService>(
    () => LocalStorageService(sl()),
  );

  sl.registerLazySingleton<LocationService>(() => LocationService());

  sl.registerLazySingleton<ApiService>(
    () => ApiService(baseUrl: ApiEndpoints.baseUrl, localStorageService: sl()),
  );

  //! Features - Onboarding & Splash
  sl.registerLazySingleton<OnboardingLocalDataSource>(
    () => OnboardingLocalDataSourceImpl(sharedPreferences: sl()),
  );

  sl.registerLazySingleton(
    () => OnboardingSplashBloc(
      localDataSource: sl(),
      localStorageService: sl(),
      profileRepository: sl(),
      locationService: sl(),
    ),
  );

  // ─── Feature: Auth ─────────────────────────────────────────────────────────
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerFactory<AuthBloc>(() => AuthBloc(authRepository: sl()));

  // ─── Feature: Profile ──────────────────────────────────────────────────────
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(sl(), sl()),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl()),
  );
  sl.registerFactory<ProfileBloc>(
    () => ProfileBloc(profileRepository: sl(), locationService: sl()),
  );

  // ─── Feature: Branch ───────────────────────────────────────────────────────
  sl.registerLazySingleton<BranchService>(() => BranchService(sl()));
  sl.registerFactory<BranchBloc>(() => BranchBloc(branchService: sl()));

  // ─── Feature: Menu ─────────────────────────────────────────────────────────
  sl.registerLazySingleton<MenuRemoteDataSource>(
    () => MenuRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<MenuRepository>(() => MenuRepositoryImpl(sl()));
  sl.registerFactory<MenuBloc>(() => MenuBloc(sl()));

  // ─── Feature: Promotion ────────────────────────────────────────────────────
  sl.registerLazySingleton<PromotionRemoteDataSource>(
    () => PromotionRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<PromotionRepository>(
    () => PromotionRepositoryImpl(sl()),
  );
  sl.registerFactory<PromotionBloc>(() => PromotionBloc(sl()));

  // ─── Feature: Customer Branch ─────────────────────────────────────────────
  sl.registerLazySingleton<BranchRemoteDataSource>(
    () => BranchRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<BranchRepository>(
    () => BranchRepositoryImpl(sl()),
  );
  sl.registerFactory<CustomerBranchBloc>(
    () => CustomerBranchBloc(branchRepository: sl()),
  );

  // ─── Feature: Car Plate ────────────────────────────────────────────────────
  sl.registerLazySingleton<CarPlateRemoteDataSource>(
    () => CarPlateRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<CarPlateRepository>(
    () => CarPlateRepositoryImpl(sl()),
  );
  sl.registerFactory<CarPlateBloc>(() => CarPlateBloc(sl()));

  // ─── Feature: Cart ─────────────────────────────────────────────────────────
  sl.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(sl()),
  );
  sl.registerFactory<CartBloc>(() => CartBloc(sl()));
}

