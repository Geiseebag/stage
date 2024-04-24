import 'package:app_stage/common/widgets/appbar.dart';
import 'package:app_stage/features/personalization/screen/add_adress.dart';
import 'package:app_stage/features/shop/screen/home.dart';
import 'package:app_stage/utils/constants/colors.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class UserAdressScreen extends StatelessWidget {
  const UserAdressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddUserAdressScreen()),
        child: Icon(
          size: 25,
          Iconsax.add_copy,
          color: TColors.white,
        ),
        backgroundColor: TColors.primary,
      ),
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          "Adresses",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  TAdress(
                    selectedAdress: false,
                  ),
                  TAdress(
                    selectedAdress: true,
                  )
                ],
              ))),
    );
  }
}

class TAdress extends StatelessWidget {
  const TAdress({
    super.key,
    required this.selectedAdress,
  });
  final bool selectedAdress;
  @override
  Widget build(BuildContext context) {
    final bool dark = THelperFunctions.isDarkMode(context);
    return TRoundedContainer(
      padding: EdgeInsets.all(TSizes.sm),
      width: double.infinity,
      showBorder: true,
      backgroundColor: selectedAdress
          ? TColors.primary.withOpacity(0.5)
          : Colors.transparent,
      borderColor: selectedAdress
          ? Colors.transparent
          : dark
              ? TColors.darkerGrey
              : TColors.grey,
      margin: EdgeInsets.only(bottom: TSizes.spaceBtwItems),
      child: Stack(children: [
        Positioned(
          top: 0,
          right: 5,
          child: Icon(selectedAdress ? Iconsax.tick_circle : null,
              color: selectedAdress
                  ? dark
                      ? TColors.light
                      : TColors.dark.withOpacity(0.8)
                  : null),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'John Doe',
              style: Theme.of(context).textTheme.titleLarge,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: TSizes.sm / 2,
            ),
            Text(
              '(+216) 92 846 249',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: TSizes.sm / 2,
            ),
            Text(
              '1603 Razzebi, South Corilina, 5 Shneider, Kram Ouest East, USA',
              style: Theme.of(context).textTheme.titleLarge,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
          ],
        )
      ]),
    );
  }
}
