import 'package:app_stage/common/styles/spacing_styles.dart';

import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/constants/text_strings.dart';
import 'package:app_stage/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle,
      required this.onPressed});

  final image, title, subtitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: TSpacingStyle.paddingWithAppBarHeight * 2,
        child: Column(children: [
          //image
          Image(
            image: AssetImage(image),
            width: THelperFunctions.screenWidth() * 0.6,
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          //text
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),

          Text(
            subtitle,
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          ///buttons
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: onPressed, child: Text(TTexts.tContinue))),
        ]),
      )),
    );
  }
}
