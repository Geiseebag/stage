import 'package:app_stage/utils/constants/colors.dart';
import 'package:app_stage/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class Tloaders extends GetxController {
  static customToast({required message}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: THelperFunctions.isDarkMode(Get.context!)
                ? TColors.darkerGrey.withOpacity(0.9)
                : TColors.grey.withOpacity(
                    0.9), // Make sure TColors is the correct variable name
          ), // BoxDecoration
          child: Center(
            child: Text(
              message,
              style: Theme.of(Get.context!)
                  .textTheme
                  .labelLarge, // Make sure labelLarge is the correct text style name
            ),
          ), // Container
        ), // SnackBar
      ),
    );
  }

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
