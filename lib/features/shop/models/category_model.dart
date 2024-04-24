import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String parentId;
  String image;

//constructor
  CategoryModel(
      {required this.id,
      required this.name,
      this.parentId = '',
      this.image = ''});

  //create an empty category
  static CategoryModel empty() =>
      CategoryModel(id: '', name: '', parentId: '', image: '');

  Map<String, dynamic> toJson() {
    return {'Name': name, 'ParentId': parentId, 'Image': image};
  }

  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return CategoryModel(
        id: document.id,
        name: data['Name'] ?? "",
        parentId: data['ParentId'] ?? "",
        image: data['Image'] ?? "",
      );
    } else {
      return CategoryModel.empty();
    }
  }
}
