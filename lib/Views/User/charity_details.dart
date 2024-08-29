import 'package:flutter/material.dart';
import 'package:charity_app/Views/Utils/Styles/app_colors.dart';
import 'package:charity_app/Views/Utils/Styles/text_styles.dart';

class CharityDetailsPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String time;
  final String description;

  const CharityDetailsPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.time,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themeColor,
        title: Text(
          'Event Details',
          style: CustomTextStyles.appBarWhiteSmallStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imagePath),
            SizedBox(height: 16),
            Text(
              title,
              style: CustomTextStyles.mediumBlackColorStyle2,
            ),
            SizedBox(height: 8),
            Text(
              time,
              style: CustomTextStyles.smallGreyColorStyle,
            ),
            SizedBox(height: 16),
            Text(
              description,
              style: CustomTextStyles.smallGreyColorStyle,
            ),
          ],
        ),
      ),
    );
  }
}
