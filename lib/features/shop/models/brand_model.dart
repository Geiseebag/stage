import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool? isFeatured;
  int productsCount;

  BrandModel(
      {required this.id,
      required this.name,
      required this.image,
      required this.productsCount,
      this.isFeatured});

  static BrandModel empty() =>
      BrandModel(id: '', name: '', image: '', productsCount: 0);

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'ProductsCount': productsCount,
      'IsFeatured': isFeatured,
    };
  }

  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) {
      return BrandModel.empty();
    }

    return BrandModel(
      id: data['Id'] ?? '',
      name: data['Name'] ?? '',
      image: data['Image'] ?? '',
      productsCount: data['ProductsCount'] ?? 0,
      isFeatured: data['IsFeatured'] ?? false,
    );
  }

  /// Map json oriented document snapshot from Firebase to BrandModel
  factory BrandModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      // Map JSON Record to the Model
      return BrandModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        productsCount: data['ProductsCount'] ?? 0,
        isFeatured: data['IsFeatured'] ?? false,
      );
    } else {
      return BrandModel.empty();
    }
  }
}
