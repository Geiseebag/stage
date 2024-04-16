import 'dart:async';

import 'package:app_stage/data/repositories/authentication/authentication_repository.dart';
import 'package:app_stage/features/authentification/screen/widgets/success_screen.dart';
import 'package:app_stage/utils/constants/image_strings.dart';
import 'package:app_stage/utils/constants/text_strings.dart';
import 'package:app_stage/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

//send email when verify screen appears & set a timer
//to direct to the next screen
  @override
  void onInit() {
    setTimer();
    sendEmailVerification();
    super.onInit();
  }

  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      Tloaders.successSnackBar(
          title: 'Email Sent Successfuly', message: 'Check your mailbox!');
    } catch (e) {
      Tloaders.errorSnackBar(title: 'Oh Shit!', message: e.toString());
    }
  }

  ///timer
  setTimer() {
    Timer.periodic(const Duration(seconds: 3), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(() => SuccessScreen(
            image: TImages.successfullyRegisteredAnimation,
            title: TTexts.yourAccountCreatedTitle,
            subtitle: TTexts.yourAccountCreatedSubTitle,
            onPressed: () =>
                AuthenticationRepository.instance.screenRedirect()));
      }
    });
  }

//manually check if email verified
  chechEmailVerification() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(() => SuccessScreen(
          image: TImages.successfullyRegisteredAnimation,
          title: TTexts.yourAccountCreatedTitle,
          subtitle: TTexts.yourAccountCreatedSubTitle,
          onPressed: () => AuthenticationRepository.instance.screenRedirect()));
    } else {
      Tloaders.warningSnackBar(
          title: "Email not Verified yet!", message: "Please check your mail");
    }
  }
}
