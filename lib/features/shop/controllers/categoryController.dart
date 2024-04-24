import 'package:app_stage/data/repositories/categories/category_repository.dart';
import 'package:app_stage/data/repositories/product/product_repository.dart';
import 'package:app_stage/features/shop/models/category_model.dart';
import 'package:app_stage/features/shop/models/product_model.dart';
import 'package:app_stage/utils/popups/loaders.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();
//variables
  final isLoading = false.obs;

  final _categoryRepository = Get.put(CategoryRepository());
  final RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  final RxList<CategoryModel> parentCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  //load data

  Future<void> getCategories() async {
    try {
      isLoading.value = true;
      final categories = await _categoryRepository.getAllCategories();
      allCategories.assignAll(categories);
      parentCategories.assignAll(allCategories
          .where((category) => category.parentId.isEmpty)
          .toList());
    } catch (e) {
      Tloaders.errorSnackBar(title: 'Oh Shit!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> getCategoryProducts(String categoryId) async {
    // Fetch limited (4) products against each subCategory;
    final products = await ProductRepository.instance
        .getProductsForCategory(categoryId: categoryId, limit: 4);
    return products;
  }

  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final subCategories =
          await _categoryRepository.getSubCategories(categoryId);
      return subCategories;
    } catch (e) {
      Tloaders.errorSnackBar(title: 'Oh Shit!', message: e.toString());
      return [];
    }
  }
}
