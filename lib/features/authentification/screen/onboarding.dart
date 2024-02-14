import 'package:app_stage/features/authentification/controllers/onboarding_controller.dart';
import 'package:app_stage/utils/constants/colors.dart';
import 'package:app_stage/utils/constants/image_strings.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/constants/text_strings.dart';
import 'package:app_stage/utils/device/device_utility.dart';
import 'package:app_stage/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:get/get.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    final dark = THelperFunctions.isDarkMode(context);
    print(dark);
    return Scaffold(
      body: Stack(
        children: [
          /// Page View
          PageView(
            controller: controller.pageController,
            onPageChanged: (index) => controller.updatePageIndicator(index),
            children: [
              OnBoardingPage(
                image: TImages.onBoardingImage1,
                title: TTexts.onBoardingTitle1,
                subTitle: TTexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: TImages.onBoardingImage2,
                title: TTexts.onBoardingTitle3,
                subTitle: TTexts.onBoardingSubTitle3,
              )
            ],
          ),

          /// Smooth Page Indicator
          Positioned(
              bottom: TDeviceUtils.getBottomNavigationBarHeight(),
              left: TDeviceUtils.getScreenWidth(context) / 2 - 35,
              child: SmoothPageIndicator(
                  controller: controller.pageController,
                  count: 2,
                  effect: ExpandingDotsEffect(
                      activeDotColor: dark ? TColors.light : TColors.dark,
                      dotHeight: 6))),

          ///skip button
          Positioned(
              right: TSizes.defaultSpace,
              top: TDeviceUtils.getAppBarHeight(),
              child: TextButton(
                onPressed: () {
                  controller.skipPage();
                },
                child: Text(
                  "skip",
                  style: TextStyle(fontSize: 15),
                ),
              )),

          ///Next button
          Positioned(
            right: TSizes.defaultSpace,
            bottom: TDeviceUtils.getBottomNavigationBarHeight() - 18,
            child: ElevatedButton(
                onPressed: () => controller.nextPage(),
                style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    backgroundColor: dark ? TColors.primary : TColors.black),
                child: Icon(Icons.keyboard_arrow_right_sharp)),
          )
        ],
      ),
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle});

  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image(
              width: THelperFunctions.screenWidth() * 0.8,
              height: THelperFunctions.screenHeight() * 0.6,
              image: AssetImage(image)),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: TSizes.spaceBtwItems),
          Text(
            subTitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
