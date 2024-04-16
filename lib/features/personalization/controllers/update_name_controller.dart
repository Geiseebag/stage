import 'package:app_stage/data/repositories/user/user_repository.dart';
import 'package:app_stage/features/personalization/controllers/user_controller.dart';
import 'package:app_stage/features/personalization/models/user_model.dart';
import 'package:app_stage/features/shop/screen/widgets/navigation_menu.dart';
import 'package:app_stage/utils/constants/image_strings.dart';
import 'package:app_stage/utils/helpers/network_manager.dart';
import 'package:app_stage/utils/popups/full_screen_loader.dart';
import 'package:app_stage/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();
  //variables
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();
  @override
  void onInit() {
    getNames();

    super.onInit();
  }

//get user record
  Future<void> getNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateName() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          "We are updating your shit...", TImages.animation1);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();

        return;
      }

      if (!updateUserNameFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      //get new name in json

      final newName = UserModel(
          id: userController.user.value.id,
          username: userController.user.value.username,
          email: userController.user.value.email,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          phoneNumber: userController.user.value.phoneNumber,
          profilePicture: userController.user.value.profilePicture);

      //update to new name
      await userRepository.updateUser(newName);
      //update the rx user value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      TFullScreenLoader.stopLoading();

      //success message
      Tloaders.successSnackBar(
          title: 'Congratulations', message: "Your shit has been updated.");
      Get.to(() => NavigationMenu());
    } catch (e) {
      Tloaders.errorSnackBar(title: 'Oh Shit!', message: e.toString());
    }
  }
}
