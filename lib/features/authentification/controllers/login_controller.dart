import 'package:app_stage/data/repositories/authentication/authentication_repository.dart';
import 'package:app_stage/features/authentification/screen/signup.dart';
import 'package:app_stage/utils/constants/image_strings.dart';
import 'package:app_stage/utils/helpers/network_manager.dart';
import 'package:app_stage/utils/popups/full_screen_loader.dart';
import 'package:app_stage/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LogInController extends GetxController {
  //variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  void GoToSignUp() {
    Get.to(SignUpScreen());
  }

  @override
  void onInit() {
    email.text = localStorage.read("REMEMBER_ME_EMAIL") ?? "";
    password.text = localStorage.read("REMEMBER_ME_PASSWORD") ?? "";
    super.onInit();
  }

  Future<void> emailAndPasswordLogin() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Logging you in...', TImages.animation1);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();

        return;
      }

      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //remember me
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      //register user in the firebase
      final userCredential = await AuthenticationRepository.instance
          .logInWithEmailAndPassword(email.text.trim(), password.text.trim());

      TFullScreenLoader.stopLoading();

      //success message
      Tloaders.successSnackBar(
          title: 'Welcome', message: "to the greatest 2nd hand shop");

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();

      Tloaders.errorSnackBar(title: 'Oh Shit!', message: e.toString());
    }
  }
}
