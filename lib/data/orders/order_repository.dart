import 'package:app_stage/data/repositories/authentication/authentication_repository.dart';
import 'package:app_stage/features/personalization/models/order_model.dart';
import 'package:app_stage/utils/exceptions/exceptions.dart';
import 'package:app_stage/utils/exceptions/firebase_exceptions.dart';
import 'package:app_stage/utils/exceptions/format_exceptions.dart';
import 'package:app_stage/utils/exceptions/platform_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;

  /// FUNCTIONS

  /// Get all orders related to the current User
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty)
        throw 'Unable to find user information. Try again in a few minutes.';
      final result =
          await _db.collection('Users').doc(userId).collection('Orders').get();
      return result.docs
          .map((documentSnapshot) => OrderModel.fromSnapshot(documentSnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } on Exception catch (_) {
      throw TExceptions();
    } catch (e) {
      throw 'Something went wrong while fetching Order Information. Try again later.';
    }
  }

  /// Store new user order
  Future<void> saveOrder(OrderModel order, String userId) async {
    try {
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Orders')
          .add(order.toJson());
    } catch (e) {
      throw 'Something went wrong while saving Order Information. Try again later.';
    }
  }
}
