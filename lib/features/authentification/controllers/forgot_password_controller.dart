import 'package:app_stage/data/repositories/authentication/authentication_repository.dart';
import 'package:app_stage/features/authentification/screen/reset_password.dart';
import 'package:app_stage/utils/constants/image_strings.dart';
import 'package:app_stage/utils/helpers/network_manager.dart';
import 'package:app_stage/utils/popups/full_screen_loader.dart';
import 'package:app_stage/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  static ForgotPasswordController get instance => Get.find();

//variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  //send reset password email
  sendPasswordResetEmail() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Logging you in...', TImages.animation1);
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();

        return;
      }

      if (!forgetPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      TFullScreenLoader.stopLoading();
      Tloaders.successSnackBar(
          title: 'Email Sent',
          message: "Check your mail to reset your Password");

      Get.to(() => ResetPasswordScreen(
            email: email.text.trim(),
          ));
    } catch (e) {
      TFullScreenLoader.stopLoading();

      Tloaders.errorSnackBar(title: 'Oh Shit!', message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Logging you in...', TImages.animation1);
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();

        return;
      }

      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      TFullScreenLoader.stopLoading();
      Tloaders.successSnackBar(
          title: 'Email Sent',
          message: "Check your mail to reset your Password");
    } catch (e) {
      TFullScreenLoader.stopLoading();

      Tloaders.errorSnackBar(title: 'Oh Shit!', message: e.toString());
    }
  }
}
