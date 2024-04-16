import 'package:app_stage/features/authentification/controllers/forgot_password_controller.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/constants/text_strings.dart';
import 'package:app_stage/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgotPasswordController());
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //heading
                Text(
                  TTexts.forgetPasswordTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),

                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                Text(
                  TTexts.forgetPasswordSubTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections * 2,
                ),
                //textfield

                Form(
                  key: controller.forgetPasswordFormKey,
                  child: TextFormField(
                      controller: controller.email,
                      validator: (value) => TValidator.validateEmail(value),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.keyboard_double_arrow_right),
                          labelText: TTexts.email)),
                ),

                //button

                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () => controller.sendPasswordResetEmail(),
                        child: Text(TTexts.submit)))
              ],
            )));
  }
}
