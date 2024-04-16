import 'package:app_stage/features/shop/models/brand_model.dart';
import 'package:app_stage/features/shop/models/product_attributes_model.dart';
import 'package:app_stage/features/shop/models/product_variation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String id;
  int stock;
  String? sku;
  double price;
  String title;
  bool? isFeatured;
  double salePrice;
  String thumbnail;
  BrandModel? brand;
  String? description;
  String? categoryId;
  List<String>? images;
  String productType;
  List<ProductAttributesModel>? productAttributes;
  List<ProductVariationModel>? productVariations;

  ProductModel({
    required this.id,
    required this.stock,
    required this.price,
    required this.title,
    this.isFeatured,
    this.salePrice = 0.0,
    required this.thumbnail,
    required this.productType,
    this.sku,
    this.brand,
    this.description,
    this.categoryId,
    this.images,
    // this.productAttributes,
    // this.productVariations,
  });

  static ProductModel empty() => ProductModel(
        id: '',
        stock: 0,
        price: 0.0,
        title: '',
        thumbnail: '',
        productType: '',
      );

  toJson() {
    return {
      'Id': id,
      'Stock': stock,
      'SKU': sku,
      'Price': price,
      'Title': title,
      'SalePrice': salePrice,
      'Thumbnail': thumbnail,
      'IsFeatured': isFeatured,
      'Brand': brand!.toJson(),
      'Description': description,
      'CategoryId': categoryId,
      'Images': images ?? [],
      'ProductType': productType,
      //   'ProductAttributes': productAttributes != null
      //       ? productAttributes?.map((e) => e.toJson()).toList()
      //       : [],
      //   'ProductVariations': productVariations != null
      //       ? productVariations?.map((e) => e.toJson()).toList()
      //       : [],
    };
  }

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return ProductModel(
        id: document.id,
        stock: data['Stock'] ?? 0,
        sku: data['SKU'] ?? "",
        title: data['Title'] ?? "",
        description: data['Description'] ?? '',
        categoryId: data['CategoryId'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
        thumbnail: data['Thumbnail'] ?? "",
        productType: data['ProductType'] ?? "ProductType.single",
        price: double.parse((data['Price'] ?? 0.0).toString()),
        salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
        brand: BrandModel.fromJson(data['Brand']) ?? null,
        images:
            data['Images'] != null ? List<String>.from(data['Images']) : []);
    // productAttributes: data['ProductAttributes'] != null
    //     ? (data['ProductAttributes'] as List<dynamic>)
    //         .map((e) => ProductAttributesModel.fromJson(e))
    //         .toList()
    //     : [],
    // productVariations: data['ProductVariations'] != null
    //     ? (data['ProductVariations'] as List<dynamic>)
    //         .map((e) => ProductVariationModel.fromJson(e))
    //         .toList()
    //     : []);
  }
  // factory ProductModel.fromQuerySnapshot(
  //     QueryDocumentSnapshot<Object?> document) {
  //   final data = document.data() as Map<String, dynamic>;
  //   return ProductModel(
  //       id: document.id,
  //       stock: data['Stock'] ?? 0,
  //       sku: data['SKU'],
  //       price: double.parse((data['Price'] ?? 0.0).toString()),
  //       title: data['Title'],
  //       salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
  //       thumbnail: data['Thumbnail'] ?? '',
  //       brand: BrandModel.fromJson(data['Brand']),
  //       description: data['Description'] ?? '',
  //       categoryId: data['CategoryId'] ?? '',
  //       images: data['Images'] != null ? List<String>.from(data['Images']) : [],
  //       productType: data['ProductType'] ?? '',
  //       productAttributes: (data['ProductAttributes'] as List<dynamic>)
  //           .map((e) => ProductAttributesModel.fromJson(e))
  //           .toList(),
  //       productVariations: (data['ProductVariations'] as List<dynamic>)
  //           .map((e) => ProductVariationModel.fromJson(e))
  //           .toList());
  // }
}
