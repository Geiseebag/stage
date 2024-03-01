import 'package:app_stage/common/widgets/appbar.dart';
import 'package:app_stage/common/widgets/custom_shapes/primary_header_container.dart';
import 'package:app_stage/common/widgets/list_tiles/settings.menu_tiles.dart';
import 'package:app_stage/features/personalization/screen/address.dart';
import 'package:app_stage/features/personalization/screen/profile.dart';
import 'package:app_stage/features/shop/screen/store.dart';
import 'package:app_stage/features/shop/screen/widgets/texts/section_heading.dart';
import 'package:app_stage/utils/constants/colors.dart';
import 'package:app_stage/utils/constants/image_strings.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          ///header
          TPrimaryHeaderContainer(
              child: Column(
            children: [
              //apbar
              TAppBar(
                title: Text(
                  TTexts.ProfileTitle,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .apply(color: TColors.white),
                ),
              ),

              //user profile

              TUserProfileTile(
                onPressed: () => Get.to(() => ProfileScreen()),
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              )
            ],
          )),

          ///body

          Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                TSectionHeading(
                  title: 'Account Settings',
                  showActionButton: false,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                TSettingsMenuTile(
                    onTap: () => Get.to(() => UserAdressScreen()),
                    icon: Iconsax.safe_home,
                    title: "My Adresses",
                    subtitle: "Set shopping delivery adress"),
                TSettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: "My Cart",
                    subtitle: "Add, remove products and move to checkout"),
                TSettingsMenuTile(
                    icon: Iconsax.shopping_bag,
                    title: "My Orders",
                    subtitle: "In Prgress and Completed Orders"),
                TSettingsMenuTile(
                    icon: Iconsax.discount_shape,
                    title: "My Coupons",
                    subtitle: "List of all discounted coupons"),
                TSettingsMenuTile(
                    icon: Iconsax.notification,
                    title: "Notifications",
                    subtitle: "Manage your notifications"),
                TSettingsMenuTile(
                    icon: Iconsax.security_card,
                    title: "Account Privacy",
                    subtitle: "Manage data usage and connected accounts"),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                //app settings

                TSectionHeading(
                  title: 'App Settings',
                  showActionButton: false,
                ),
                SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                TSettingsMenuTile(
                  icon: Iconsax.image,
                  title: "HD Image Quality",
                  subtitle: "Set image quality to be seen",
                  trailing: Switch(
                    inactiveThumbColor:
                        const Color.fromARGB(255, 219, 175, 179),
                    activeColor: TColors.primary,
                    activeTrackColor: TColors.white,
                    value: false,
                    onChanged: (value) {},
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: TCircularImage(
        leaveOriginalColors: true,
        image: TImages.user,
        width: 50,
        height: 50,
        padding: 0,
      ),
      title: Text(
        "Ali AG",
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: TColors.white),
      ),
      subtitle: Text(
        "dummydata@gmail.com",
        style:
            Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white),
      ),
      trailing: IconButton(
        onPressed: onPressed,
        icon: const Icon(
          Icons.edit,
          color: TColors.white,
        ),
      ),
    );
  }
}
