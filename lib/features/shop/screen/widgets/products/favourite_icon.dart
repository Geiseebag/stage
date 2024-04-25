import 'package:app_stage/features/shop/controllers/favourite_controller.dart';
import 'package:app_stage/features/shop/screen/widgets/products/product_card_vertical.dart';
import 'package:app_stage/utils/constants/colors.dart';
import 'package:app_stage/utils/helpers/helper_functions.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class TFavouriteIcon extends StatelessWidget {
  const TFavouriteIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(FavouritesController());
    return TCircularIcon(
      backgroundColor: dark
          ? TColors.black.withOpacity(0.7)
          : TColors.white.withOpacity(0.7),
      icon: Iconsax.heart_copy,
      color: dark ? TColors.white : Color.fromARGB(255, 252, 145, 154),
    );
  }
}
