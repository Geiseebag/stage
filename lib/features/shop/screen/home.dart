import 'package:app_stage/utils/constants/colors.dart';
import 'package:app_stage/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "assets/images/banners/istockphoto-1317931909-1024x1024 (1).jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  TColors.white.withOpacity(0.0), // Lighter color at the top
                  TColors.white,
                ],
                stops: [
                  0.0,
                  0.6
                ], // Stop at 0.5 to achieve white in half of the page
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
