import 'package:app_stage/features/authentification/controllers/forgot_password_controller.dart';
import 'package:app_stage/features/authentification/screen/login.dart';
import 'package:app_stage/utils/constants/image_strings.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/constants/text_strings.dart';
import 'package:app_stage/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () => Get.back(), icon: Icon(CupertinoIcons.clear))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(children: [
            //image
            Image(
              image: AssetImage(TImages.deliveredEmailIllustration),
              width: THelperFunctions.screenWidth() * 0.6,
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            //text
            Text(
              email,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Text(
              TTexts.changeYourPasswordTitle,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),

            Text(
              TTexts.changeYourPasswordSubTitle,
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
                    onPressed: () => Get.to(() => const LoginScreen()),
                    child: Text(TTexts.done))),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            SizedBox(
                width: double.infinity,
                child: TextButton(
                    onPressed: () => ForgotPasswordController.instance
                        .resendPasswordResetEmail(email),
                    child: Text(TTexts.resendEmail)))
          ]),
        ));
  }
}
