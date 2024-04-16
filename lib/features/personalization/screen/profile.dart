import 'package:app_stage/common/widgets/appbar.dart';
import 'package:app_stage/features/personalization/controllers/user_controller.dart';
import 'package:app_stage/features/personalization/screen/change_name.dart';
import 'package:app_stage/features/personalization/screen/widgets/profile_menu.dart';
import 'package:app_stage/features/shop/screen/store.dart';
import 'package:app_stage/features/shop/screen/widgets/texts/section_heading.dart';
import 'package:app_stage/utils/constants/image_strings.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title:
            Text("Profile", style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                //profile picture

                children: [
                  Obx(
                    () {
                      final NetworkImage = controller.user.value.profilePicture;

                      return TCircularImage(
                        image: NetworkImage.isNotEmpty
                            ? NetworkImage
                            : TImages.user,
                        leaveOriginalColors: true,
                        width: 80,
                        height: 80,
                        isNetworkImage: NetworkImage.isNotEmpty,
                      );
                    },
                  ),
                  TextButton(
                    onPressed: () => controller.uploadUserProfilePicture(),
                    child: Text('Change Profile Picture'),
                  )
                ],
              ),
            ),

            //details

            SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),
            Divider(),
            SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            TSectionHeading(
              title: 'Profile Information',
              showActionButton: false,
            ),
            SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            TProfileMenu(
              onPressed: () => Get.to(() => ChangeNameScreen()),
              title: 'Name',
              value: controller.user.value.fullName,
            ),
            TProfileMenu(
              onPressed: () {},
              title: 'Username',
              value: controller.user.value.username,
            ),
            SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),
            Divider(),
            SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            TSectionHeading(
              title: 'Personal Information',
              showActionButton: false,
            ),
            SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            TProfileMenu(
              onPressed: () {},
              title: 'User ID',
              value: controller.user.value.id,
              icon: Iconsax.copy_copy,
            ),
            TProfileMenu(
              onPressed: () {},
              title: 'E-mail',
              value: controller.user.value.email,
            ),
            TProfileMenu(
              onPressed: () {},
              title: 'Phone Number',
              value: controller.user.value.phoneNumber,
            ),
            TProfileMenu(
              onPressed: () {},
              title: 'Gender',
              value: 'Mahboul',
            ),
            TProfileMenu(
              onPressed: () {},
              title: 'Date of Birth',
              value: '12 Dec, 2002',
            ),
            SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),
            Divider(),
            SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            Center(
                child: TextButton(
              onPressed: () => controller.deleteAccountWarningPopup(),
              child: Text(
                'Close Account',
                style: TextStyle(color: const Color.fromARGB(255, 240, 98, 88)),
              ),
            ))
          ]),
        ),
      ),
    );
  }
}
