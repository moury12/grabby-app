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

  PaginationMeta({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPage,
  });

  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    return PaginationMeta(
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
      total: json['total'] ?? 0,
      totalPage: json['totalPage'] ?? 1,
    );
  }
}

class MenuItemModel {
  final String? id;
  final String itemName;
  final dynamic category; // Can be String (ID) or CategoryInfo (Object)
  final double price;
  final String description;
  final int stamp;
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
    required this.stamp,
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
      stamp: json['stamp'] ?? 0,
      isAvailable: json['isAvailable'] ?? true,
      additionalItems:
          ((json['additionalItems'] ?? json['additionalitems']) as List?)
              ?.map(
                (e) =>
                    CustomizationGroupModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
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
      'stamp': stamp,
      'isAvailable': isAvailable,
      'additionalitems': additionalItems.map((e) => e.toJson()).toList(),
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

  ShopOwnerInfo({required this.id, required this.name});

  factory ShopOwnerInfo.fromJson(Map<String, dynamic> json) {
    return ShopOwnerInfo(id: json['_id'] ?? '', name: json['name'] ?? '');
  }
}

class CustomizationGroupModel {
  final String groupName;
  final String type; // 'regular' or 'optional'
  final List<CustomizationItemModel> items;

  CustomizationGroupModel({
    required this.groupName,
    required this.type,
    required this.items,
  });

  factory CustomizationGroupModel.fromJson(Map<String, dynamic> json) {
    return CustomizationGroupModel(
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
  final String name;
  final double price;
  final String? image;

  CustomizationItemModel({required this.name, required this.price, this.image});

  factory CustomizationItemModel.fromJson(Map<String, dynamic> json) {
    return CustomizationItemModel(
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'price': price, if (image != null) 'image': image};
  }
}
