import 'package:flutter/material.dart';
import 'package:charity_app/Views/Utils/Styles/app_colors.dart';
import 'package:charity_app/Views/Utils/Styles/text_styles.dart';

class FaqsPage extends StatelessWidget {
  const FaqsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample list of FAQs
    final List<Map<String, String>> faqs = [
      {
        "question": "What is this app about?",
        "answer": "This app helps you manage and track your charitable donations."
      },
      {
        "question": "How can I reset my password?",
        "answer": "Go to the Forget Password section and follow the instructions."
      },
      {
        "question": "How can I contact support?",
        "answer": "You can contact us through the Contact Us section."
      },
      {
        "question": "How do I make a donation?",
        "answer": "Navigate to the Donations section and follow the instructions to make a donation."
      },
      {
        "question": "Is my donation tax-deductible?",
        "answer": "Yes, all donations made through our app are tax-deductible. You will receive a receipt for your records."
      },
      {
        "question": "How do I view my donation history?",
        "answer": "You can view your donation history in the History section of the app."
      },
      {
        "question": "Can I donate anonymously?",
        "answer": "Yes, you have the option to donate anonymously by selecting the 'Donate Anonymously' option during the donation process."
      },
      {
        "question": "What payment methods are accepted?",
        "answer": "We accept various payment methods including credit/debit cards, PayPal, and bank transfers."
      },
      {
        "question": "How do I update my profile information?",
        "answer": "You can update your profile information in the Profile section of the app."
      },
      {
        "question": "What is the minimum donation amount?",
        "answer": "The minimum donation amount is \$5."
      },
      {
        "question": "How can I get a refund for my donation?",
        "answer": "To request a refund, please contact our support team through the Contact Us section."
      },
      {
        "question": "How can I stay updated with my favorite charities?",
        "answer": "You can follow your favorite charities in the app to receive updates and notifications about their activities."
      },
      {
        "question": "Can I set up recurring donations?",
        "answer": "Yes, you can set up recurring donations by selecting the 'Recurring Donation' option during the donation process."
      },
      {
        "question": "How do I delete my account?",
        "answer": "To delete your account, please contact our support team through the Contact Us section."
      },
      {
        "question": "Is my personal information secure?",
        "answer": "Yes, we take your privacy and security very seriously. Your personal information is encrypted and stored securely."
      },
      {
        "question": "How do I share my donation on social media?",
        "answer": "After making a donation, you will have the option to share it on social media directly from the app."
      },
      {
        "question": "How do I report a problem with the app?",
        "answer": "You can report a problem through the Feedback section in the app or by contacting our support team."
      },
      {
        "question": "Can I volunteer for a charity through the app?",
        "answer": "Yes, we provide information about volunteer opportunities in the Volunteer section of the app."
      },
      {
        "question": "How do I change the app's language settings?",
        "answer": "You can change the app's language settings in the Settings section."
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themeColor,
        title: Text(
          "FAQ's",
          style: CustomTextStyles.appBarWhiteSmallStyle,
        ),
      ),
      body: ListView(
        children: [
          // Display the image first
          Image.network(
            'https://plus.unsplash.com/premium_photo-1680302397750-ef86e280a172?q=80&w=1160&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            fit: BoxFit.cover,
          ),
          // Display the list of FAQs
          ...faqs.map((faq) {
            return ExpansionTile(
              leading: Icon(
                Icons.question_answer,
                color: AppColors.themeColor,
              ),
              title: Text(
                faq['question']!,
                style: CustomTextStyles.mediumBlackColorStyle2,
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    faq['answer']!,
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
