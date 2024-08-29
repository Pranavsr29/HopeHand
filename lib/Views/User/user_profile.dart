import 'package:charity_app/Controllers/firebase_auth_controller.dart';
import 'package:charity_app/Views/Utils/Styles/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Utils/Styles/text_styles.dart';
import 'notifications.dart';
import 'faqs.dart';
import 'contact_us.dart';
import 'terms_and_conditions.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  FirebaseController controller = Get.put(FirebaseController());

  User? currentUser;
  String? userName;

  checkUser() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      setState(() {
        currentUser = user;
        if (currentUser != null) {
          FirebaseFirestore.instance
              .collection('auth')
              .doc(currentUser!.uid)
              .get()
              .then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              setState(() {
                userName = documentSnapshot['name'];
              });
            }
          });
        }
      });
    });
  }

  @override
  void initState() {
    checkUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themeColor,
        title: Text(
          "My Account",
          style: CustomTextStyles.appBarWhiteSmallStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                color: AppColors.skyBlueThemeColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: AppColors.themeColor,
                      ),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName ?? 'Loading...',
                          style: CustomTextStyles.mediumBlackColorStyle2.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          currentUser != null
                              ? currentUser!.email!
                              : 'example@gmail.com',
                          style: CustomTextStyles.smallGreyColorStyle,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: icons.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (titles[index] == 'Notifications') {
                        Get.to(() => const NotificationsPage());
                      } else if (titles[index] == "FAQ's") {
                        Get.to(() => const FaqsPage());
                      } else if (titles[index] == "Contact Us") {
                        Get.to(() => const ContactUsPage());
                      } else if (titles[index] == "Terms & Conditions") {
                        Get.to(() => const TermsAndConditionsPage());
                      }
                    },
                    child: tile(
                      titles[index],
                      icons[index],
                    ),
                  );
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.logOut();
              },
              child: tile('Logout', Icons.logout),
            )
          ],
        ),
      ),
    );
  }

  Widget tile(String text, IconData icon) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.themeColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            color: AppColors.whiteColor,
          ),
        ),
      ),
      title: Text(
        text,
        style: CustomTextStyles.mediumBlackColorStyle2.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 20,
        color: Colors.grey,
      ),
    );
  }

  List icons = [
    Icons.notifications,
    Icons.question_answer,
    Icons.contact_phone,
    Icons.description,
  ];

  List titles = [
    'Notifications',
    'FAQ\'s',
    'Contact Us',
    'Terms & Conditions',
  ];
}
