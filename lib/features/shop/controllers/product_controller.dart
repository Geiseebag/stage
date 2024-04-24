import 'package:app_stage/data/repositories/product/product_repository.dart';
import 'package:app_stage/features/shop/models/product_model.dart';
import 'package:app_stage/utils/constants/enums.dart';
import 'package:app_stage/utils/popups/loaders.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  //variables
  final productRepository = Get.put(ProductRepository());

  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    fetchFeaturedProducuts();
  }

  void fetchFeaturedProducuts() async {
    try {
      isLoading.value = true;

      //get products
      final products = await productRepository.getFeaturedProducts();
      //assign products

      featuredProducts.assignAll(products);
    } catch (e) {
      print(e.toString());
      Tloaders.errorSnackBar(title: 'Oh Shit!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  String getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0;

    if (product.productType == ProductType.single.toString()) {
      return (product.salePrice > 0 ? product.salePrice : product.price)
          .toString();
    } else {
      for (var variation in product.productVariations!) {
        double priceToConsider =
            variation.salePrice > 0.0 ? variation.salePrice : variation.price;
        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }
        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }
      if (smallestPrice.isEqual(largestPrice)) {
        return largestPrice.toString();
      } else {
        return '$smallestPrice - $largestPrice';
      }
    }
  }

  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;
    return (((originalPrice - salePrice) / originalPrice) * 100)
        .toStringAsFixed(0);
  }

  String getProductStockStatus(int stock) {
    {
      print(stock);
      return stock > 0 ? 'In Stock' : 'Out Of Stock';
    }
  }
}
