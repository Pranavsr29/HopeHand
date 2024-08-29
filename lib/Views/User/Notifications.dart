import 'package:flutter/material.dart';
import 'package:charity_app/Views/Utils/Styles/app_colors.dart';
import 'package:charity_app/Views/Utils/Styles/text_styles.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  // Sample list of notifications
  List<Map<String, String>> notifications = [
    {"title": "New Donation Opportunity!", "detail": "Support our latest campaign to provide clean water to communities in need. Every drop counts!"},
    {"title": "Volunteer Event Coming Up!", "detail": "Join us this weekend for a community clean-up event. Your time and effort can make a big difference!"},
    {"title": "Thank You for Your Support!", "detail": "We’ve reached 75% of our fundraising goal thanks to generous donors like you. Let's keep going!"},
    {"title": "Monthly Impact Report", "detail": "See how your contributions have helped transform lives this month. Check out our latest impact report."},
    {"title": "Matching Gift Alert!", "detail": "For the next 48 hours, every donation will be matched by a generous donor. Double your impact today!"},
    // Add more notifications as needed
  ];

  void _addNotification(String title, String detail) {
    setState(() {
      notifications.add({"title": title, "detail": detail});
    });
  }

  void _removeNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themeColor,
        title: Text(
          "Notifications",
          style: CustomTextStyles.appBarWhiteSmallStyle,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Logic to add a new notification, e.g., show a dialog to enter details
              _addNotification("New Notification", "This is a new notification detail");
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          // Display the image first
          Image.network(
            'https://plus.unsplash.com/premium_photo-1682309526815-efe5d6225117?q=80&w=1212&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            fit: BoxFit.cover,
          ),
          // Display the list of notifications
          ...notifications.map((notification) {
            return ListTile(
              leading: Icon(
                Icons.notifications,
                color: AppColors.themeColor,
              ),
              title: Text(
                notification["title"]!,
                style: CustomTextStyles.mediumBlackColorStyle2,
              ),
              subtitle: Text(
                notification["detail"]!,
                style: CustomTextStyles.smallGreyColorStyle,
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  _removeNotification(notifications.indexOf(notification));
                },
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
