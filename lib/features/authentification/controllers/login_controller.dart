import 'package:app_stage/features/authentification/screen/signup.dart';
import 'package:get/get.dart';

class LogInController extends GetxController {
  static LogInController get instance => Get.find();

  void GoToSignUp() {
    Get.to(SignUpScreen());
  }
}
