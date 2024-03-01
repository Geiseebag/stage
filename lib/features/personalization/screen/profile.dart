import 'package:app_stage/common/widgets/appbar.dart';
import 'package:app_stage/features/personalization/screen/widgets/profile_menu.dart';
import 'package:app_stage/features/shop/screen/store.dart';
import 'package:app_stage/features/shop/screen/widgets/texts/section_heading.dart';
import 'package:app_stage/utils/constants/colors.dart';
import 'package:app_stage/utils/constants/image_strings.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  TCircularImage(
                      image: TImages.user,
                      leaveOriginalColors: true,
                      width: 80,
                      height: 80),
                  TextButton(
                    onPressed: () {},
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
              onPressed: () {},
              title: 'Name',
              value: 'Ali AG',
            ),
            TProfileMenu(
              onPressed: () {},
              title: 'Username',
              value: 'Geiseebag',
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
              value: '16032',
              icon: Iconsax.copy_copy,
            ),
            TProfileMenu(
              onPressed: () {},
              title: 'E-mail',
              value: 'dummydata@gmail.com',
            ),
            TProfileMenu(
              onPressed: () {},
              title: 'Phone Number',
              value: '+216 92993724',
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
              onPressed: () {},
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
