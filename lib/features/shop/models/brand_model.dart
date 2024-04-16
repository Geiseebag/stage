import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String name;
  String image;
  int productsCount;

  BrandModel({
    required this.id,
    required this.name,
    required this.image,
    required this.productsCount,
  });

  static BrandModel empty() =>
      BrandModel(id: '', name: '', image: '', productsCount: 0);

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'ProductsCount': productsCount,
    };
  }

  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    print("hello");
    if (data.isEmpty) {
      return BrandModel.empty();
    }
    return BrandModel(
      id: data['Id'] ?? '',
      name: data['Name'] ?? '',
      image: data['Image'] ?? '',
      productsCount: data['ProductsCount'] ?? 0,
    );
  }
}
