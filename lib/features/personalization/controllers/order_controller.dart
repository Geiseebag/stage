import 'package:app_stage/data/orders/order_repository.dart';
import 'package:app_stage/data/repositories/authentication/authentication_repository.dart';
import 'package:app_stage/features/authentification/screen/widgets/success_screen.dart';
import 'package:app_stage/features/personalization/controllers/address_controller.dart';
import 'package:app_stage/features/personalization/models/order_model.dart';
import 'package:app_stage/features/shop/controllers/cart_controller.dart';
import 'package:app_stage/features/shop/screen/widgets/navigation_menu.dart';
import 'package:app_stage/utils/constants/enums.dart';
import 'package:app_stage/utils/constants/image_strings.dart';
import 'package:app_stage/utils/popups/full_screen_loader.dart';
import 'package:app_stage/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  /// Variables
  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  // final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());

  /// Fetch user's order history
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      Tloaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  // Add methods for order processing
  void processOrder(double totalAmount) async {
    try {
      // Start Loader
      TFullScreenLoader.openLoadingDialog(
          'Processing your order', TImages.pencilAnimation);

      // Get user authentication Id
      final userid = AuthenticationRepository.instance.authUser!.uid;
      if (userid.isEmpty) return;

      final order = OrderModel(
        id: UniqueKey().toString(),
        userId: userid,
        status: OrderStatus.pending,
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        address: addressController.selectedAddress.value,
        deliveryDate: DateTime.now(),
        items: cartController.cartItems.toList(),
      );

      // Save the order to Firestore
      await orderRepository.saveOrder(order, userid);

      // Update the cart status
      cartController.clearCart();

      Get.off(() => SuccessScreen(
            image: TImages.successfullyRegisteredAnimation,
            title: 'Order Complete!',
            subtitle: 'Your item will be shipped soon!',
            onPressed: () => Get.offAll(NavigationMenu()),
          ));
    } catch (e) {
      Tloaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
      