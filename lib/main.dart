import 'package:app_stage/features/authentification/screen/onboarding.dart';
import 'package:app_stage/features/personalization/screen/address.dart';
import 'package:app_stage/features/personalization/screen/profile.dart';
import 'package:app_stage/features/shop/screen/home.dart';
import 'package:app_stage/features/shop/screen/product_details.dart';
import 'package:app_stage/features/shop/screen/product_reviews.dart';
import 'package:app_stage/features/shop/screen/widgets/navigation_menu.dart';
import 'package:app_stage/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: NavigationMenu(),
    );
  }
}
