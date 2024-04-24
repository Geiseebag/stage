import 'package:app_stage/common/styles/spacing_styles.dart';
import 'package:app_stage/features/authentification/controllers/login_controller.dart';
import 'package:app_stage/features/authentification/screen/forgot_password.dart';
import 'package:app_stage/features/authentification/screen/widgets/divider.dart';
import 'package:app_stage/features/authentification/screen/widgets/socials.dart';
import 'package:app_stage/utils/constants/image_strings.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/constants/text_strings.dart';
import 'package:app_stage/utils/helpers/helper_functions.dart';
import 'package:app_stage/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(LogInController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //logo
                  Image(
                      height: 150,
                      image: AssetImage(
                          dark ? TImages.lightAppLogo : TImages.darkAppLogo)),
                  SizedBox(height: TSizes.md),
                  Text(TTexts.loginTitle,
                      style: Theme.of(context).textTheme.headlineMedium),
                  SizedBox(height: TSizes.sm),
                  Text(TTexts.loginSubTitle,
                      style: Theme.of(context).textTheme.bodyMedium)
                ],
              ),
              Form(
                  key: controller.loginFormKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: TSizes.spaceBtwSections),
                    child: Column(
                      children: [
                        TextFormField(
                            controller: controller.email,
                            validator: (value) =>
                                TValidator.validateEmail(value),
                            decoration: const InputDecoration(
                                prefixIcon:
                                    Icon(Icons.keyboard_double_arrow_right),
                                labelText: TTexts.email)),
                        const SizedBox(
                          height: TSizes.spaceBtwInputFields,
                        ),
                        Obx(
                          () => TextFormField(
                              controller: controller.password,
                              validator: (value) =>
                                  TValidator.validateEmptyText(
                                      value, 'Password'),
                              obscureText: controller.hidePassword.value,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    (Icons.password_rounded),
                                  ),
                                  labelText: TTexts.password,
                                  suffixIcon: IconButton(
                                    icon: Icon(controller.hidePassword.value
                                        ? Iconsax.eye_slash_copy
                                        : Iconsax.eye_copy),
                                    onPressed: () => controller.hidePassword
                                        .value = !controller.hidePassword.value,
                                  ))),
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwInputFields / 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // remeber me
                            Row(
                              children: [
                                Obx(() => Checkbox(
                                    value: controller.rememberMe.value,
                                    onChanged: (value) {
                                      controller.rememberMe.value =
                                          !controller.rememberMe.value;
                                    })),
                                const Text(TTexts.rememberMe)
                              ],
                            ),
                            //forgot password
                            TextButton(
                                onPressed: () =>
                                    Get.to(() => const ForgotPasswordScreen()),
                                child: Text(TTexts.forgetPassword)),
                          ],
                        ),

                        const SizedBox(
                          height: TSizes.spaceBtwSections,
                        ),

                        //log in button

                        SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () =>
                                    controller.emailAndPasswordLogin(),
                                child: Text(TTexts.logIn))),

                        const SizedBox(
                          height: TSizes.spaceBtwItems / 2,
                        ),
                        //create account button

                        SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                                onPressed: () {
                                  controller.GoToSignUp();
                                },
                                child: Text(TTexts.createAccount))),
                      ],
                    ),
                  )),
              // Divider
              TDivider(dividerText: TTexts.orSignUpWith.capitalize!),
              const SizedBox(height: TSizes.spaceBtwSections),

              //footer

              TSocials()
            ],
          ),
        ),
      ),
    );
  }
}
