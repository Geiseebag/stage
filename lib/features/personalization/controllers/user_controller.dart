import 'package:app_stage/data/repositories/authentication/authentication_repository.dart';
import 'package:app_stage/data/repositories/user/user_repository.dart';
import 'package:app_stage/features/authentification/screen/login.dart';
import 'package:app_stage/features/personalization/models/user_model.dart';
import 'package:app_stage/features/personalization/screen/reauth_user_login.dart';
import 'package:app_stage/utils/constants/colors.dart';
import 'package:app_stage/utils/constants/image_strings.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/helpers/network_manager.dart';
import 'package:app_stage/utils/popups/full_screen_loader.dart';
import 'package:app_stage/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final userRepository = Get.put(UserRepository());
  Rx<UserModel> user = UserModel.empty().obs;
  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final profileLoading = false.obs;
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();
  @override
  void onInit() {
    super.onInit();
    getUserRecord();
  }

  Future<void> getUserRecord() async {
    try {
      final user = await userRepository.getUser();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
      Tloaders.errorSnackBar(title: 'Oh Shit!', message: e.toString());
    }
  }

  void deleteAccountWarningPopup() {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.all(TSizes.md),
        title: 'Delete Account',
        middleText: 'Are you sure? This action is not reversible',
        confirm: ElevatedButton(
            onPressed: () async => deleteteUserAccount(),
            style: ElevatedButton.styleFrom(
              backgroundColor: TColors.error,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
              child: Text('Delete'),
            )),
        cancel: OutlinedButton(
            onPressed: () => Navigator.of(Get.overlayContext!).pop(),
            child: const Text('Cancel')));
  }

  Future<void> deleteteUserAccount() async {
    try {
      TFullScreenLoader.openLoadingDialog('Processing', TImages.animation1);
      //reauth user
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        if (provider == 'google.com') {
        } else if (provider == 'password') {
          TFullScreenLoader.stopLoading();
          Get.to(() => ReAuthLoginScreen());
        }
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      Tloaders.warningSnackBar(title: 'Oh Shit', message: e.toString());
    }
  }

  Future<void> reAuthenticateEmailAndPassword() async {
    try {
      TFullScreenLoader.openLoadingDialog('Processing..', TImages.animation1);
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();

        return;
      }

      if (!reAuthFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(
              verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      TFullScreenLoader.stopLoading();
      Get.offAll(() => LoginScreen());
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

  ///--------------------------------Images---------------------------------//
  //upload image
  uploadUserProfilePicture() async {
    try {
      XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      print('${image?.path}');

      if (image != null) {
        //upload image
        final imageUrl =
            await userRepository.uploadImage('Users/Images/Profile/', image);

        //update image

        final updatedUser = UserModel(
            id: user.value.id,
            username: user.value.username,
            email: user.value.email,
            firstName: user.value.firstName,
            lastName: user.value.lastName,
            phoneNumber: user.value.phoneNumber,
            profilePicture: imageUrl);

        await userRepository.updateUser(updatedUser);

        user.value.profilePicture = imageUrl;
        Tloaders.successSnackBar(
            title: 'Congratulations', message: 'Your shit has been updated');
      }
    } catch (e) {
      Tloaders.errorSnackBar(title: 'Oh Shit', message: e.toString());
    }
  }
}
