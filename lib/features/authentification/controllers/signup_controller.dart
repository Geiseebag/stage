import 'package:app_stage/data/repositories/authentication/authentication_repository.dart';
import 'package:app_stage/data/repositories/user/user_repository.dart';
import 'package:app_stage/features/authentification/screen/verify_email.dart';
import 'package:app_stage/features/personalization/models/user_model.dart';
import 'package:app_stage/utils/constants/image_strings.dart';
import 'package:app_stage/utils/helpers/network_manager.dart';
import 'package:app_stage/utils/popups/full_screen_loader.dart';
import 'package:app_stage/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final hidePassword = true.obs;
  final privacyPolicy = false.obs;
  final email = TextEditingController();
  final firstName = TextEditingController();

  final lastName = TextEditingController();

  final username = TextEditingController();

  final phoneNumber = TextEditingController();

  final password = TextEditingController();

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  Future<void> signup() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'We are processing your information...', TImages.animation1);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();

        return;
      }

      if (!signupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //privicy policy
      if (!privacyPolicy.value) {
        Tloaders.warningSnackBar(
            title: 'Accept Privacy Policy', message: 'Accepti alah yehdik!!!');
        TFullScreenLoader.stopLoading();

        return;
      }
      //register user in the firebase
      final userCredential = await AuthenticationRepository.instance
          .RegisterWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      //save authenticated user data in firebase firestore
      final newUser = UserModel(
          id: userCredential.user!.uid,
          username: username.text.trim(),
          email: email.text.trim(),
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          profilePicture: '');

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);
      TFullScreenLoader.stopLoading();

      //success message
      Tloaders.successSnackBar(
          title: 'Congratulations', message: 'Your account has been created!');

      Get.to(() => VerifyEmailScreen(
            email: email.text.trim(),
          ));
    } catch (e) {
      TFullScreenLoader.stopLoading();

      Tloaders.errorSnackBar(title: 'Oh Shit!', message: e.toString());
    }
  }
}
