import 'package:flutter/material.dart';
import 'package:charity_app/Views/Utils/Styles/app_colors.dart';
import 'package:charity_app/Views/Utils/Styles/text_styles.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themeColor,
        title: Text(
          'Contact Us',
          style: CustomTextStyles.appBarWhiteSmallStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1528747045269-390fe33c19f2?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Get in Touch',
                    style: CustomTextStyles.mediumBlackColorStyle2.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Email: support@HopeHands.com',
                    style: CustomTextStyles.mediumBlackColorStyle2,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Phone: +91 7259946976',
                    style: CustomTextStyles.mediumBlackColorStyle2,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Address:  Bull Temple Rd, Basavanagudi, Bengaluru, Karnataka 560019',
                    style: CustomTextStyles.mediumBlackColorStyle2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
