import 'dart:convert';

import 'package:app_stage/data/repositories/product/product_repository.dart';
import 'package:app_stage/features/shop/models/product_model.dart';
import 'package:app_stage/utils/local_storage/storage_utility.dart';
import 'package:get/get.dart';
import '../../../data/repositories/brands/brand_repository.dart';
import '../../../utils/popups/loaders.dart';
import '../models/brand_model.dart';

class FavouritesController extends GetxController {
  static FavouritesController get instance => Get.find();

  final favourites = <String, bool>{}.obs;

  @override
  void onInit() {
    initFavourites();
    super.onInit();
  }

  /// -- Load Brands
  void initFavourites() {
    final json = TLocalStorage.instance().readData('favourites');
    if (json != null) {
      final storedFavourites = jsonDecode(json) as Map<String, dynamic>;
      favourites.assignAll(
          storedFavourites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isFavourite(String productId) {
    return favourites[productId] ?? false;
  }

  void toggleFavouriteProduct(String productId) {
    if (!favourites.containsKey(productId)) {
      favourites[productId] = true;
      // saveFavouriteStorage();
      Tloaders.customToast(message: 'Product has been added to the Wishlist.');
    } else {}
  }
}
