
import 'package:grabby_app/src/featurs/home/data/datasources/home_remote_data_source.dart';
import 'package:grabby_app/src/featurs/home/data/models/shop_dashboard_model.dart';

import '../../../../src_export.dart';


abstract class HomeRepository {
  Future<ApiResponse<ShopDashboardModel>> getShopDashboardStats();
}

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<ApiResponse<ShopDashboardModel>> getShopDashboardStats() => 
      remoteDataSource.getShopDashboardStats();
}
