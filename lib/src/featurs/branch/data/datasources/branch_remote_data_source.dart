import '../../../../src_export.dart';

abstract class BranchRemoteDataSource {
  Future<ApiResponse<List<CustomerBranchModel>>> getBranches();
  Future<ApiResponse<CustomerBranchModel>> getBranchDetail(String id);
}

class BranchRemoteDataSourceImpl implements BranchRemoteDataSource {
  final ApiService apiService;

  BranchRemoteDataSourceImpl(this.apiService);

  @override
  Future<ApiResponse<List<CustomerBranchModel>>> getBranches() async {
    return await apiService.get<List<CustomerBranchModel>>(
      ApiEndpoints.customerBranches,
      fromJson: (json) {
        final List<dynamic> data = json['data'] ?? [];
        return data.map((e) => CustomerBranchModel.fromJson(e)).toList();
      },
    );
  }

  @override
  Future<ApiResponse<CustomerBranchModel>> getBranchDetail(String id) async {
    return await apiService.get<CustomerBranchModel>(
      ApiEndpoints.customerBranchDetail(id),
      fromJson: (json) => CustomerBranchModel.fromJson(json['data']),
    );
  }
}
