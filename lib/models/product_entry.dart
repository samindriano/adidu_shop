// To parse this JSON data, do
//
//     final products = productEntryFromJson(jsonString);

import 'dart:convert';

List<ProductEntry> productEntryFromJson(String str) =>
    List<ProductEntry>.from(json.decode(str).map((x) => ProductEntry.fromJson(x)));

String productEntryToJson(List<ProductEntry> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductEntry {
  String id;
  String name;
  int price;
  String description;
  String thumbnail;
  String category;
  String categoryDisplay;
  bool isFeatured;
  String brand;
  int stock;
  int? userId;

  ProductEntry({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.thumbnail,
    required this.category,
    required this.categoryDisplay,
    required this.isFeatured,
    required this.brand,
    required this.stock,
    required this.userId,
  });

  factory ProductEntry.fromJson(Map<String, dynamic> json) => ProductEntry(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        category: json["category"],
        categoryDisplay: json["category_display"],
        isFeatured: json["is_featured"],
        brand: json["brand"],
        stock: json["stock"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "description": description,
        "thumbnail": thumbnail,
        "category": category,
        "category_display": categoryDisplay,
        "is_featured": isFeatured,
        "brand": brand,
        "stock": stock,
        "user_id": userId,
      };
}
