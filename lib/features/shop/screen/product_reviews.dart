import 'package:app_stage/common/widgets/appbar.dart';
import 'package:app_stage/features/shop/screen/widgets/reviews/user_review_card.dart';
import 'package:app_stage/utils/constants/colors.dart';
import 'package:app_stage/utils/constants/sizes.dart';
import 'package:app_stage/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          "Reviews & Ratings",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            //overall product ratings
            OverAllProductRating(),
            TRatingBarIndicator(
              rating: 4.5,
            ),
            Text(
              "199",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            // reviews
            TUserReviewCard(),
            TUserReviewCard(),
            TUserReviewCard(),
            TUserReviewCard()
          ]),
        ),
      ),
    );
  }
}

class TRatingBarIndicator extends StatelessWidget {
  const TRatingBarIndicator({
    super.key,
    required this.rating,
  });
  final double rating;
  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
        unratedColor: TColors.grey,
        rating: rating,
        itemSize: 25,
        itemBuilder: (_, __) => Icon(
              Icons.star,
              color: TColors.primary,
            ));
  }
}

class OverAllProductRating extends StatelessWidget {
  const OverAllProductRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            '4.8',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Expanded(
          flex: 7,
          child: Column(
            children: [
              TRatingProgressIndicator(
                text: '5',
                value: 0.6,
              ),
              TRatingProgressIndicator(
                text: '4',
                value: 0.2,
              ),
              TRatingProgressIndicator(
                text: '3',
                value: 0.03,
              ),
              TRatingProgressIndicator(
                text: '2',
                value: 0.07,
              ),
              TRatingProgressIndicator(
                text: '1',
                value: 0.1,
              )
            ],
          ),
        )
      ],
    );
  }
}

class TRatingProgressIndicator extends StatelessWidget {
  const TRatingProgressIndicator({
    super.key,
    required this.text,
    required this.value,
  });
  final String text;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Expanded(
          flex: 11,
          child: SizedBox(
            width: TDeviceUtils.getScreenWidth(context) * 0.8,
            child: LinearProgressIndicator(
              borderRadius: BorderRadius.circular(7),
              value: value,
              minHeight: 15,
              backgroundColor: TColors.grey,
              valueColor: AlwaysStoppedAnimation(TColors.primary),
            ),
          ),
        )
      ],
    );
  }
}
