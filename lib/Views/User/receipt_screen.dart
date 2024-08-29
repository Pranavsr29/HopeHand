import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:charity_app/Views/Utils/Styles/app_colors.dart';
import 'package:charity_app/Views/Utils/Styles/text_styles.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:charity_app/Views/User/history_screen.dart';

class ReceiptScreen extends StatelessWidget {
  final Map<String, dynamic> receiptData;
  final String backgroundImageUrl = 'https://images.unsplash.com/photo-1623123096729-26b481292919?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cmVjZWlwdHxlbnwwfHwwfHx8MA%3D%3D';

  ReceiptScreen({required this.receiptData});

  @override
  Widget build(BuildContext context) {
    Timestamp timestamp = receiptData['time'];
    DateTime dateTime = timestamp.toDate();
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    String formattedTime = DateFormat('kk:mm').format(dateTime);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themeColor,
        title: Text(
          'Receipt',
          style: CustomTextStyles.appBarWhiteSmallStyle,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(backgroundImageUrl),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.9),
              BlendMode.lighten,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Donation Receipt',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.themeColor,
                            ),
                          ),
                        ),
                        Divider(thickness: 2),
                        SizedBox(height: 10),
                        _buildReceiptItem(
                          icon: Icons.attach_money,
                          title: 'Amount',
                          value: '\$${receiptData['amount']}',
                        ),
                        _buildReceiptItem(
                          icon: Icons.date_range,
                          title: 'Date',
                          value: formattedDate,
                        ),
                        _buildReceiptItem(
                          icon: Icons.access_time,
                          title: 'Time',
                          value: formattedTime,
                        ),
                        _buildReceiptItem(
                          icon: Icons.location_city,
                          title: 'Charity',
                          value: receiptData['charity_post_id'],
                        ),
                        _buildReceiptItem(
                          icon: Icons.token,
                          title: 'Tokens',
                          value: receiptData['tokens'].toString(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _onDownloadPressed(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.themeColor,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.download, size: 24),
                      SizedBox(width: 10),
                      Text(
                        'Download Receipt',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Get.snackbar(
                      'Info',
                      'Invoices can help with tax deductions.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.blue,
                      colorText: Colors.white,
                      margin: EdgeInsets.all(10),
                      borderRadius: 10,
                      duration: Duration(seconds: 2),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.info_outline, color: AppColors.themeColor),
                      SizedBox(width: 5),
                      Text(
                        'Invoices can help with tax deductions',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.themeColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReceiptItem({required IconData icon, required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: AppColors.themeColor),
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void _onDownloadPressed(BuildContext context) {
    Get.snackbar('Success', 'Download completed',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      margin: EdgeInsets.all(10),
      borderRadius: 10,
      duration: Duration(seconds: 2),
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HistoryScreen()),
    );
  }
}
