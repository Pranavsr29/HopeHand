import 'package:charity_app/Views/Utils/Styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'main_screen.dart'; // Import the MainScreen

class CharitySuccess extends StatelessWidget {
  const CharitySuccess({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate to the MainScreen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAll(() => MainScreen()); // Use Get.offAll to clear all routes and navigate to the MainScreen
    });

    return Scaffold(
      body: Center(
        child: Text(
          "You've Donated Successfully",
          style: CustomTextStyles.mediumBlackColorStyle,
        ),
      ),
    );
  }
}
