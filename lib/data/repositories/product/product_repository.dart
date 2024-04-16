import 'package:app_stage/features/shop/models/product_model.dart';
import 'package:app_stage/utils/exceptions/exceptions.dart';
import 'package:app_stage/utils/exceptions/firebase_exceptions.dart';
import 'package:app_stage/utils/exceptions/format_exceptions.dart';
import 'package:app_stage/utils/exceptions/platform_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  //variables
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //get featured products
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _db.collection('Products').get();
      print("e2");
      final list = snapshot.docs
          .map((document) => ProductModel.fromSnapshot(document))
          .toList();
      print("e3");
      return list;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } on Exception catch (_) {
      throw TExceptions();
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
