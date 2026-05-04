import 'dart:convert';

class MenuShopResponseModel {
  final List<MenuItemModel> data;
  final PaginationMeta? meta;

  MenuShopResponseModel({required this.data, this.meta});

  factory MenuShopResponseModel.fromJson(Map<String, dynamic> json) {
    return MenuShopResponseModel(
      data:
          (json['data'] as List?)
              ?.map((e) => MenuItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      meta: json['meta'] != null ? PaginationMeta.fromJson(json['meta']) : null,
    );
  }
}

class PaginationMeta {
  final int page;
  final int limit;
  final int total;
  final int totalPage;
  final int totalAvailable;
  final int totalUnavailable;

  PaginationMeta({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPage,
    required this.totalAvailable,
    required this.totalUnavailable,
  });

  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    return PaginationMeta(
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
      total: json['total'] ?? 0,
      totalPage: json['totalPage'] ?? 1,
      totalAvailable: json['totalAvailable'] ?? 0,
      totalUnavailable: json['totalUnavailable'] ?? 0,
    );
  }
}

class MenuItemModel {
  final String? id;
  final String itemName;
  final dynamic category; // Can be String (ID) or CategoryInfo (Object)
  final double price;
  final String description;
  final bool stampActive;
  final bool isAvailable;
  final List<CustomizationGroupModel> additionalItems;
  final String? image;
  final dynamic shopOwnerId; // Can be String (ID) or ShopOwnerInfo (Object)

  MenuItemModel({
    this.id,
    required this.itemName,
    required this.category,
    required this.price,
    required this.description,
    required this.stampActive,
    required this.isAvailable,
    required this.additionalItems,
    this.image,
    this.shopOwnerId,
  });

  String get categoryId =>
      category is CategoryInfo ? category.id : (category?.toString() ?? '');
  String get categoryName => category is CategoryInfo ? category.name : '';

  factory MenuItemModel.fromJson(Map<String, dynamic> json) {
    return MenuItemModel(
      id: json['_id'],
      itemName: json['itemName'] ?? '',
      category: json['category'] is Map<String, dynamic>
          ? CategoryInfo.fromJson(json['category'])
          : json['category'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      stampActive: json['stampActive'] ?? json['stamp'] ?? false,
      isAvailable: json['isAvailable'] ?? true,
      additionalItems: () {
        final rawAdditionalItems =
            json['additionalItems'] ?? json['additionalitems'];
        if (rawAdditionalItems is String) {
          try {
            final decoded = jsonDecode(rawAdditionalItems) as List;
            return decoded
                .map(
                  (e) => CustomizationGroupModel.fromJson(
                    e as Map<String, dynamic>,
                  ),
                )
                .toList();
          } catch (_) {
            return <CustomizationGroupModel>[];
          }
        }
        if (rawAdditionalItems is List) {
          return rawAdditionalItems
              .map(
                (e) =>
                    CustomizationGroupModel.fromJson(e as Map<String, dynamic>),
              )
              .toList();
        }
        return <CustomizationGroupModel>[];
      }(),
      image: json['image'],
      shopOwnerId: json['shopOwnerId'] is Map<String, dynamic>
          ? ShopOwnerInfo.fromJson(json['shopOwnerId'])
          : json['shopOwnerId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemName': itemName,
      'category': category is CategoryInfo
          ? (category as CategoryInfo).id
          : category,
      'price': price,
      'description': description,
      'stampActive': stampActive,
      "isAvailable": isAvailable,
      "additionalItems": additionalItems.map((e) => e.toJson()).toList(),
    };
  }
}

class CategoryInfo {
  final String id;
  final String name;

  CategoryInfo({required this.id, required this.name});

  factory CategoryInfo.fromJson(Map<String, dynamic> json) {
    return CategoryInfo(id: json['_id'] ?? '', name: json['name'] ?? '');
  }
}

class ShopOwnerInfo {
  final String id;
  final String name;
  final String shopName;

  ShopOwnerInfo({required this.id, required this.name, required this.shopName});

  factory ShopOwnerInfo.fromJson(Map<String, dynamic> json) {
    return ShopOwnerInfo(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      shopName: json['shop_name'] ?? '',
    );
  }
}

class CustomizationGroupModel {
  final String? id;
  final String groupName;
  final String type; // 'regular' or 'optional'
  final List<CustomizationItemModel> items;

  CustomizationGroupModel({
    this.id,
    required this.groupName,
    required this.type,
    required this.items,
  });

  factory CustomizationGroupModel.fromJson(Map<String, dynamic> json) {
    return CustomizationGroupModel(
      id: json['_id'],
      groupName: json['groupName'] ?? '',
      type: json['type'] ?? 'regular',
      // FIX: Cast 'e' to Map<String, dynamic>
      items:
          (json['items'] as List?)
              ?.map(
                (e) =>
                    CustomizationItemModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'groupName': groupName,
      'type': type,
      'items': items.map((e) => e.toJson()).toList(),
    };
  }
}

class CustomizationItemModel {
  final String? id;
  final String name;
  final double price;
  final String? image;

  CustomizationItemModel({
    this.id,
    required this.name,
    required this.price,
    this.image,
  });

  factory CustomizationItemModel.fromJson(Map<String, dynamic> json) {
    return CustomizationItemModel(
      id: json['_id'],
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'price': price, if (image != null) 'image': image};
  }
}
