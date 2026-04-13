import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import '../../../../src_export.dart';

abstract class MenuRemoteDataSource {
  Future<ApiResponse<List<MenuCategoryModel>>> getMenuCategories();
  Future<ApiResponse<MenuCategoryModel>> createMenuCategory(String name);
  Future<ApiResponse<void>> deleteMenuCategory(String id);
  Future<ApiResponse<MenuShopResponseModel>> getMenuItems({
    int page = 1,
    int limit = 10,
    String? searchTerm,
    String? categoryId,
  });
  Future<ApiResponse<void>> createMenu({
    required String itemName,
    required String categoryId,
    required double price,
    required String description,
    required int stamp,
    required bool isAvailable,
    required List<CustomizationGroupModel> additionalItems,
    File? image,
  });
}

class MenuRemoteDataSourceImpl implements MenuRemoteDataSource {
  final ApiService apiService;

  MenuRemoteDataSourceImpl(this.apiService);

  @override
  Future<ApiResponse<List<MenuCategoryModel>>> getMenuCategories() async {
    return await apiService.get<List<MenuCategoryModel>>(
      ApiEndpoints.getMenuCategories,
      fromJson: (json) => (json['data'] as List)
          .map((e) => MenuCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  Future<ApiResponse<MenuCategoryModel>> createMenuCategory(String name) async {
    return await apiService.post<MenuCategoryModel>(
      ApiEndpoints.createMenuCategory,
      data: {"name": name},
      fromJson: (data) =>
          MenuCategoryModel.fromJson(data as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<void>> deleteMenuCategory(String id) async {
    return await apiService.delete<void>(ApiEndpoints.deleteMenuCategory(id));
  }

  @override
  Future<ApiResponse<MenuShopResponseModel>> getMenuItems({
    int page = 1,
    int limit = 10,
    String? searchTerm,
    String? categoryId,
  }) async {
    final Map<String, dynamic> queryParameters = {"page": page, "limit": limit};

    if (searchTerm != null && searchTerm.isNotEmpty) {
      queryParameters["searchTerm"] = searchTerm;
    }

    if (categoryId != null && categoryId.isNotEmpty) {
      queryParameters["category"] = categoryId;
    }

    return await apiService.get<MenuShopResponseModel>(
      ApiEndpoints.getShopMenuItems,
      queryParameters: queryParameters,
      fromJson: (json) =>
          MenuShopResponseModel.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<void>> createMenu({
    required String itemName,
    required String categoryId,
    required double price,
    required String description,
    required int stamp,
    required bool isAvailable,
    required List<CustomizationGroupModel> additionalItems,
    File? image,
  }) async {
    final Map<String, dynamic> data = {
      "itemName": itemName,
      "category": categoryId,
      "price": price,
      "description": description,
      "stamp": stamp,
      "isAvailable": isAvailable,
      "additionalitems": jsonEncode(
        additionalItems.map((e) => e.toJson()).toList(),
      ),
    };

    if (image != null) {
      data["image"] = await dio.MultipartFile.fromFile(
        image.path,
        filename: image.path.split('/').last,
      );
    }

    final formData = dio.FormData.fromMap(data);

    return await apiService.post<void>(ApiEndpoints.createMenu, data: formData);
  }
}
