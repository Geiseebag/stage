import 'package:app_stage/features/authentification/screen/verify_email.dart';
import 'package:app_stage/features/authentification/screen/widgets/divider.dart';
import 'package:app_stage/features/authentification/screen/widgets/socials.dart';
import 'package:app_stage/utils/constants/colors.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/constants/text_strings.dart';
import 'package:app_stage/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
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
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: TTexts.username,
                        prefixIcon: Icon(Icons.person_2))),
                SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),
                TextFormField(
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: TTexts.email,
                        prefixIcon: Icon(Icons.email))),
                SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),
                TextFormField(
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: TTexts.phoneNo,
                        prefixIcon: Icon(Icons.phone))),
                SizedBox(
                  height: TSizes.spaceBtwInputFields,
                ),
                TextFormField(
                    obscureText: true,
                    expands: false,
                    decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.remove_red_eye_outlined),
                        labelText: TTexts.password,
                        prefixIcon: Icon(Icons.password))),

                ///accept terms

                SizedBox(height: TSizes.spaceBtwSections),

                Row(
                  children: [
                    SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: true,
                          onChanged: (value) {},
                        )),
                    SizedBox(height: TSizes.spaceBtwItems),
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: '${TTexts.iAgreeTo} ',
                          style: Theme.of(context).textTheme.bodySmall),
                      TextSpan(
                          text: '${TTexts.privacyPolicy}',
                          style: Theme.of(context).textTheme.bodyMedium!.apply(
                              color: dark ? TColors.white : TColors.primary,
                              decoration: TextDecoration.underline,
                              decorationColor:
                                  dark ? TColors.white : TColors.primary)),
                      TextSpan(
                          text: ' ${TTexts.and} ',
                          style: Theme.of(context).textTheme.bodySmall),
                      TextSpan(
                          text: '${TTexts.termsOfUse}',
                          style: Theme.of(context).textTheme.bodyMedium!.apply(
                              color: dark ? TColors.white : TColors.primary,
                              decoration: TextDecoration.underline,
                              decorationColor:
                                  dark ? TColors.white : TColors.primary)),
                    ]))
                  ],
                ),

                ///button

                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () => Get.to(VerifyEmailScreen()),
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
