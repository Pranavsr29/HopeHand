import 'package:flutter/material.dart';
import 'package:charity_app/Views/Utils/Styles/app_colors.dart';
import 'package:charity_app/Views/Utils/Styles/text_styles.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample terms and conditions text
    final List<Map<String, String>> termsAndConditions = [
      {
        "title": "Introduction",
        "content": "These terms and conditions govern your use of this app..."
      },
      {
        "title": "User Responsibilities",
        "content":
        "As a user, you are responsible for your actions within the app..."
      },
      {
        "title": "Privacy Policy",
        "content":
        "We value your privacy and strive to protect your personal information..."
      },
      {
        "title": "Limitation of Liability",
        "content":
        "Our liability is limited to the maximum extent permitted by law..."
      },
      {
        "title": "Account Security",
        "content":
        "You are responsible for maintaining the confidentiality of your account information..."
      },
      {
        "title": "Intellectual Property",
        "content":
        "All content included in this app, such as text, graphics, and images, is our property..."
      },
      {
        "title": "Termination",
        "content":
        "We reserve the right to terminate or suspend your account for any violations of these terms..."
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themeColor,
        title: Text(
          "Terms & Conditions",
          style: CustomTextStyles.appBarWhiteSmallStyle,
        ),
      ),
      body: ListView(
        children: [
          // Display the image first
          Image.network(
            'https://plus.unsplash.com/premium_photo-1661782669172-2471ee4bf248?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            fit: BoxFit.cover,
          ),
          // Display the list of Terms and Conditions
          ...termsAndConditions.map((term) {
            return ExpansionTile(
              leading: Icon(
                Icons.description,
                color: AppColors.themeColor,
              ),
              title: Text(
                term['title']!,
                style: CustomTextStyles.mediumBlackColorStyle2,
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    term['content']!,
                    style: CustomTextStyles.smallGreyColorStyle,
                  ),
                ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
}
