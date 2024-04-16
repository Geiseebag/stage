import 'package:app_stage/data/repositories/categories/category_repository.dart';
import 'package:app_stage/features/shop/models/category_model.dart';
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
}
