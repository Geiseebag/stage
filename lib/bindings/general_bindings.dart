import 'package:app_stage/features/personalization/controllers/address_controller.dart';
import 'package:app_stage/features/shop/controllers/variation_controller.dart';
import 'package:app_stage/utils/helpers/network_manager.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(Get.put(NetworkManager()));
    Get.put(Get.put(VariationController()));
    Get.put(Get.put(AddressController()));
  }
}
