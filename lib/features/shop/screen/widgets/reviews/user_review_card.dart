import 'package:app_stage/features/shop/screen/home.dart';
import 'package:app_stage/features/shop/screen/product_reviews.dart';
import 'package:app_stage/utils/constants/colors.dart';
import 'package:app_stage/utils/constants/image_strings.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class TUserReviewCard extends StatelessWidget {
  const TUserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(TImages.userProfileImage1),
                ),
                SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                Text(
                  "Jane Doe",
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
          ],
        ),
        SizedBox(
          height: TSizes.spaceBtwItems,
        ),

        //review

        Row(
          children: [
            TRatingBarIndicator(rating: 4),
            SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Text(
              '01 Nov, 2023',
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
        SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        ReadMoreText(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce nulla arcu, viverra vel lorem ac, ornare consectetur ante. Quisque quis enim vel mi suscipit blandit in vel leo. Phasellus euismod ex eu justo ultrices laoreet. ",
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimExpandedText: ' Show Less',
          trimCollapsedText: ' Show More',
          moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: TSizes.spaceBtwItems,
        ),

        //Company Review

        TRoundedContainer(
          backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
          child: Padding(
            padding: const EdgeInsets.all(TSizes.md),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "2nd Main",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      "02 Nov, 2023",
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
                ReadMoreText(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce nulla arcu, viverra vel lorem ac, ornare consectetur ante. Quisque quis enim vel mi suscipit blandit in vel leo. Phasellus euismod ex eu justo ultrices laoreet. ",
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimExpandedText: ' Show Less',
                  trimCollapsedText: ' Show More',
                  moreStyle:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  lessStyle:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: TSizes.spaceBtwSections)
      ],
    );
  }
}
