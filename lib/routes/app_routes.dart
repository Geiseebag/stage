import 'package:app_stage/features/authentification/screen/forgot_password.dart';
import 'package:app_stage/features/authentification/screen/onboarding.dart';
import 'package:app_stage/features/authentification/screen/signup.dart';
import 'package:app_stage/features/authentification/screen/verify_email.dart';
import 'package:app_stage/features/personalization/screen/address.dart';
import 'package:app_stage/features/personalization/screen/cart.dart';
import 'package:app_stage/features/personalization/screen/profile.dart';
import 'package:app_stage/features/personalization/screen/settings.dart';
import 'package:app_stage/features/shop/screen/home.dart';
import 'package:app_stage/features/shop/screen/product_reviews.dart';
import 'package:app_stage/features/shop/screen/store.dart';
import 'package:app_stage/features/shop/screen/wishlist.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: '/', page: () => const HomeScreen()),
    GetPage(name: '/store', page: () => const StoreScreen()),
    GetPage(name: '/wishlist', page: () => const WishListScreen()),
    GetPage(name: '/settings', page: () => const SettingsScreen()),
    GetPage(name: '/productReviews', page: () => const ProductReviewsScreen()),
    GetPage(name: '/cart', page: () => const CartScreen()),
    GetPage(name: '/profile', page: () => const ProfileScreen()),
    GetPage(name: '/adress', page: () => const UserAdressScreen()),
    GetPage(name: '/signup', page: () => const SignUpScreen()),
    GetPage(name: '/verifyEmail', page: () => const VerifyEmailScreen()),
    GetPage(name: '/forgotPassword', page: () => const ForgotPasswordScreen()),
    GetPage(name: '/onboarding', page: () => const OnBoardingScreen()),
  ];
}
