import 'package:charity_app/Controllers/firestore_controller.dart';
import 'package:charity_app/Views/Utils/Styles/app_colors.dart';
import 'package:charity_app/Views/Utils/Styles/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:charity_app/Views/User/token_summary_screen.dart';
import 'receipt_screen.dart';


class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  FirestoreController firestoreController = Get.put(FirestoreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themeColor,
        title: Text(
          'History of Payments',
          style: CustomTextStyles.appBarWhiteSmallStyle,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: firestoreController.getData('Payments'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData) {
                  return Center(child: Text('No payment history available.'));
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data!.docs[index];
                    Timestamp timestamp = ds['time'];
                    DateTime dateTime = timestamp.toDate();
                    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
                    String formattedTime = DateFormat('kk:mm').format(dateTime);

                    return Card(
                      child: ListTile(
                        leading: Icon(FontAwesomeIcons.moneyCheckDollar,
                            color: AppColors.themeColor),
                        title: Text('Amount: ${ds['amount']}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Date: $formattedDate'),
                            Text('Time: $formattedTime'),
                            Text('Charity: ${ds['charity_post_id']}'),
                            Text('Tokens: ${ds['tokens']}'),
                          ],
                        ),
                        trailing: ElevatedButton.icon(
                          onPressed: () {
                            Get.to(() => ReceiptScreen(receiptData: ds.data() as Map<String, dynamic>));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.themeColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          ),
                          icon: Icon(FontAwesomeIcons.receipt, size: 18, color: AppColors.whiteColor),
                          label: Text(
                            'View Receipt',
                            style: CustomTextStyles.commonButtonStyle.copyWith(
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => TokenSummaryScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.themeColor,
                padding: EdgeInsets.symmetric(vertical: 15),
                textStyle: CustomTextStyles.commonButtonStyle,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(FontAwesomeIcons.coins, color: AppColors.whiteColor),
                  SizedBox(width: 10),
                  Text('View Token Summary'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
