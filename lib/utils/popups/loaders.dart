import 'package:app_stage/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class Tloaders extends GetxController {
  static successSnackBar(
      {required String title, String message = '', int duration = 2}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        backgroundColor: TColors.primary,
        colorText: TColors.white,
        duration: Duration(seconds: duration),
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(10),
        icon: Icon(Iconsax.check_copy, color: TColors.white));
  }

  static warningSnackBar(
      {required String title, String message = '', int duration = 2}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        backgroundColor: TColors.warning,
        colorText: TColors.white,
        duration: Duration(seconds: duration),
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(20),
        icon: Icon(Iconsax.warning_2_copy, color: TColors.white));
  }

  static errorSnackBar(
      {required String title, String message = '', int duration = 2}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        backgroundColor: TColors.error,
        colorText: TColors.white,
        duration: Duration(seconds: duration),
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(20),
        icon: Icon(Iconsax.warning_2_copy, color: TColors.white));
  }
}
