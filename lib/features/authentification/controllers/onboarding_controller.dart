import 'package:app_stage/features/authentification/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  void updatePageIndicator(index) => currentPageIndex.value = index;
  void dotNavigationClick(index) {}

  void nextPage() {
    if (currentPageIndex.value < 1) {
      // Assuming you have only 2 pages
      currentPageIndex.value++;
      pageController.animateToPage(currentPageIndex.value,
          duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
    } else {
      final storage = GetStorage();
      storage.write('IsFirstTime', false);
      Get.offAll(LoginScreen());
    }
  }

  void skipPage() {
    final storage = GetStorage();
    storage.write('IsFirstTime', false);
    Get.offAll(LoginScreen());
  }
}
