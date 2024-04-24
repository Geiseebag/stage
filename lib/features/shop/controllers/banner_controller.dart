import 'package:app_stage/data/repositories/banners/banner_repository.dart';
import 'package:app_stage/features/shop/models/banner_model.dart';
import 'package:app_stage/utils/popups/loaders.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();
  //--------Variables---------//
  final carousalCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;

  //oninit
  @override
  void onInit() {
    super.onInit();
    getBanners();
  }

  //--------Functions---------//
  void updatePageIndicator(index) {
    carousalCurrentIndex.value = index;
  }

  Future<void> getBanners() async {
    try {
      isLoading.value = true;

      //get banners
      final bannerRepo = Get.put(BannerRepository());

      final banners = await bannerRepo.getAllBanners();

      this.banners.assignAll(banners);
    } catch (e) {
      Tloaders.errorSnackBar(title: 'Oh Shit!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
