import 'package:app_stage/features/shop/screen/home.dart';
import 'package:app_stage/features/shop/screen/store.dart';
import 'package:app_stage/utils/constants/colors.dart';
import 'package:app_stage/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
            height: 80,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            backgroundColor: dark ? TColors.black : TColors.white,
            indicatorColor: dark
                ? TColors.white.withOpacity(0.1)
                : TColors.black.withOpacity(0.1),
            onDestinationSelected: (index) {
              controller.selectedIndex.value = index;
            },
            destinations: const [
              NavigationDestination(
                  icon: Icon(CupertinoIcons.home), label: 'Home'),
              NavigationDestination(
                  icon: Icon(CupertinoIcons.shopping_cart), label: 'Store'),
              NavigationDestination(
                  icon: Icon(CupertinoIcons.heart), label: 'Wishlist'),
              NavigationDestination(
                  icon: Icon(CupertinoIcons.profile_circled), label: 'Profile'),
            ]),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  Rx<int> selectedIndex = 1.obs;

  final screens = [
    HomeScreen(),
    StoreScreen(),
    Container(
      color: Colors.orange,
    ),
    Container(
      color: Colors.blue,
    )
  ];
}
