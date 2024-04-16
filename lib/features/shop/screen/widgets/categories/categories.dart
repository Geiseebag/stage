import 'package:app_stage/common/widgets/shimmers/category_shimmer.dart';
import 'package:app_stage/features/shop/controllers/categoryController.dart';
import 'package:app_stage/features/shop/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());

    return Obx(() {
      if (categoryController.isLoading == true)
        return TCategoryShimmer(
          itemCount: 3,
        );
      if (categoryController.parentCategories.isEmpty)
        return Center(
          child: Text(
            'No Data Found',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(color: Colors.white),
          ),
        );
      return SizedBox(
        height: 70,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: categoryController.parentCategories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              final category = categoryController.parentCategories[index];
              return CategoryIcons(
                name: category.name,
                backgroundOpacity: 0.8,
              );
            }),
      );
    });
  }
}
