
import '../../../../src_export.dart';
import '../models/shop_dashboard_model.dart';

abstract class HomeRemoteDataSource {
  Future<ApiResponse<ShopDashboardModel>> getShopDashboardStats();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiService apiService;
   HomeRemoteDataSourceImpl(this.apiService);

  @override
  Future<ApiResponse<ShopDashboardModel>> getShopDashboardStats() async {
    return await apiService.get<ShopDashboardModel>(
      ApiEndpoints.shopDashboard,
      fromJson: (json) => ShopDashboardModel.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}
