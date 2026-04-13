class MenuCategoryModel {
  final String id;
  final String name;
  final String shopOwnerId;
  final DateTime createdAt;
  final DateTime updatedAt;

  MenuCategoryModel({
    required this.id,
    required this.name,
    required this.shopOwnerId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MenuCategoryModel.fromJson(Map<String, dynamic> json) {
    return MenuCategoryModel(
      id: json['_id'],
      name: json['name'],
      shopOwnerId: json['shopOwnerId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'shopOwnerId': shopOwnerId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
