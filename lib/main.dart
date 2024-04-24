import 'package:app_stage/bindings/general_bindings.dart';
import 'package:app_stage/data/repositories/authentication/authentication_repository.dart';
import 'package:app_stage/firebase_options.dart';
import 'package:app_stage/routes/app_routes.dart';
import 'package:app_stage/utils/constants/colors.dart';
import 'package:app_stage/utils/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  //widgets binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  //getx local storage
  await GetStorage.init();

  //await splash screen until other items load
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

//initialize fire base & authentification
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      getPages: AppRoutes.pages,
      home: Scaffold(
        backgroundColor: TColors.primary,
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
