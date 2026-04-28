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
      id: json['_id'].toString() == 'null' ? "" : json['_id'].toString(),
      name: json['name'].toString() == 'null' ? "" : json['name'].toString(),
      shopOwnerId: json['shopOwnerId'].toString() == 'null'
          ? ""
          : json['shopOwnerId'].toString(),
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
