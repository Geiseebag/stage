import 'package:app_stage/features/shop/models/banner_model.dart';
import 'package:app_stage/utils/exceptions/firebase_exceptions.dart';
import 'package:app_stage/utils/exceptions/format_exceptions.dart';
import 'package:app_stage/utils/exceptions/platform_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  //variables
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //get all categories
  Future<List<BannerModel>> getAllBanners() async {
    try {
      final snapshot = await _db
          .collection('Banners')
          .where('Active', isEqualTo: true)
          .get();
      return snapshot.docs
          .map((DocumentSnapshot) => BannerModel.fromSnapshot(DocumentSnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
