import 'package:app_stage/data/repositories/product/product_repository.dart';
import 'package:app_stage/features/shop/models/product_model.dart';
import 'package:get/get.dart';
import '../../../data/repositories/brands/brand_repository.dart';
import '../../../utils/popups/loaders.dart';
import '../models/brand_model.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();
  RxBool isLoading = true.obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  final BrandRepository brandRepository = Get.put(BrandRepository());

  @override
  void onInit() {
    getFeaturedBrands();
    super.onInit();
  }

  /// -- Load Brands
  Future<void> getFeaturedBrands() async {
    try {
      // Show loader while loading brands
      isLoading.value = true;
      final brands = await brandRepository.getAllBrands();
      allBrands.assignAll(brands);
      featuredBrands.assignAll(allBrands
          .where((brand) => brand.isFeatured ?? false)
          .toList()
          .take(4));
    } catch (e) {
      Tloaders.errorSnackBar(title: 'Oh Shit!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Get Brand for Category
// Get Brands For Category
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      final brands = await brandRepository.getBrandsForCategory(categoryId);
      return brands;
    } catch (e) {
      Tloaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  /// Get Brand Specific Products from your data source
  Future<List<ProductModel>> getBrandProducts(String brandId) async {
    try {
      final products = await ProductRepository.instance
          .getProductsForBrand(brandId: brandId);
      return products;
    } catch (e) {
      Tloaders.errorSnackBar(title: 'Oh Shit!', message: e.toString());
      return [];
    }
  }
}
