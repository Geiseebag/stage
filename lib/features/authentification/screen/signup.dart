import 'package:app_stage/features/authentification/controllers/signup_controller.dart';
import 'package:app_stage/features/authentification/screen/widgets/divider.dart';
import 'package:app_stage/features/authentification/screen/widgets/socials.dart';
import 'package:app_stage/utils/constants/colors.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/constants/text_strings.dart';
import 'package:app_stage/utils/helpers/helper_functions.dart';
import 'package:app_stage/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            ///title

            Text(
              TTexts.signupTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            ///form

            Form(
                key: controller.signupFormKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                              validator: (value) =>
                                  TValidator.validateEmptyText(
                                      value, 'First Name'),
                              controller: controller.firstName,
                              expands: false,
                              decoration: const InputDecoration(
                                  labelText: TTexts.firstName,
                                  prefixIcon: Icon(Icons.person))),
                        ),
                        const SizedBox(
                          width: TSizes.spaceBtwInputFields,
                        ),
                        Expanded(
                          child: TextFormField(
                              validator: (value) =>
                                  TValidator.validateEmptyText(
                                      value, 'Last Name'),
                              controller: controller.lastName,
                              expands: false,
                              decoration: const InputDecoration(
                                  labelText: TTexts.lastName,
                                  prefixIcon: Icon(Icons.person))),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: TSizes.spaceBtwInputFields,
                    ),
                    TextFormField(
                        validator: (value) =>
                            TValidator.validateEmptyText(value, 'Username'),
                        controller: controller.username,
                        expands: false,
                        decoration: const InputDecoration(
                            labelText: TTexts.username,
                            prefixIcon: Icon(Icons.person_2))),
                    SizedBox(
                      height: TSizes.spaceBtwInputFields,
                    ),
                    TextFormField(
                        validator: (value) => TValidator.validateEmail(value),
                        controller: controller.email,
                        expands: false,
                        decoration: const InputDecoration(
                            labelText: TTexts.email,
                            prefixIcon: Icon(Icons.email))),
                    SizedBox(
                      height: TSizes.spaceBtwInputFields,
                    ),
                    TextFormField(
                        validator: (value) =>
                            TValidator.validatePhoneNumber(value),
                        controller: controller.phoneNumber,
                        expands: false,
                        decoration: const InputDecoration(
                            labelText: TTexts.phoneNo,
                            prefixIcon: Icon(Icons.phone))),
                    SizedBox(
                      height: TSizes.spaceBtwInputFields,
                    ),

                    Obx(
                      () => TextFormField(
                          controller: controller.password,
                          validator: (value) =>
                              TValidator.validatePassword(value),
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
                                onPressed: () => controller.hidePassword.value =
                                    !controller.hidePassword.value,
                              ))),
                    ),

                    ///accept terms

                    SizedBox(height: TSizes.spaceBtwSections),

                    Row(
                      children: [
                        SizedBox(
                            width: 24,
                            height: 24,
                            child: Obx(
                              () => Checkbox(
                                  value: controller.privacyPolicy.value,
                                  onChanged: (value) => controller.privacyPolicy
                                      .value = !controller.privacyPolicy.value),
                            )),
                        SizedBox(height: TSizes.spaceBtwItems),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                              text: '${TTexts.iAgreeTo} ',
                              style: Theme.of(context).textTheme.bodySmall),
                          TextSpan(
                              text: '${TTexts.privacyPolicy}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .apply(
                                      color: dark
                                          ? TColors.white
                                          : TColors.primary,
                                      decoration: TextDecoration.underline,
                                      decorationColor: dark
                                          ? TColors.white
                                          : TColors.primary)),
                          TextSpan(
                              text: ' ${TTexts.and} ',
                              style: Theme.of(context).textTheme.bodySmall),
                          TextSpan(
                              text: '${TTexts.termsOfUse}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .apply(
                                      color: dark
                                          ? TColors.white
                                          : TColors.primary,
                                      decoration: TextDecoration.underline,
                                      decorationColor: dark
                                          ? TColors.white
                                          : TColors.primary)),
                        ]))
                      ],
                    ),

                    ///signup button

                    SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () => controller.signup(),
                            child: Text(TTexts.createAccount))),
                    SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                    TDivider(dividerText: TTexts.orSignUpWith.capitalize!),
                    SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                    TSocials()
                  ],
                ))
          ],
        ),
      )),
    );
  }
}
