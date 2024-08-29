import 'package:charity_app/Controllers/firestore_controller.dart';
import 'package:charity_app/Views/Utils/Styles/app_colors.dart';
import 'package:charity_app/Views/Utils/Styles/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class TokenSummaryScreen extends StatefulWidget {
  const TokenSummaryScreen({super.key});

  @override
  State<TokenSummaryScreen> createState() => _TokenSummaryScreenState();
}

class _TokenSummaryScreenState extends State<TokenSummaryScreen> {
  FirestoreController firestoreController = Get.put(FirestoreController());
  num totalTokens = 0;

  @override
  void initState() {
    super.initState();
    calculateTotalTokens();
  }

  void calculateTotalTokens() async {
    QuerySnapshot snapshot = await firestoreController.getDataOnce('Payments');
    num total = 0;
    for (var doc in snapshot.docs) {
      total += doc['tokens'];
    }
    setState(() {
      totalTokens = total;
    });
  }

  void _redeemTokens(int tokens) async {
    // Check if there are enough tokens to redeem
    if (totalTokens >= tokens) {
      setState(() {
        totalTokens -= tokens;
      });

      // Assuming we need to update the Firestore with the new totalTokens value
      // await firestoreController.updateTokens('userId', totalTokens);
    } else {
      // Show an alert if there are not enough tokens
      _showInsufficientTokensDialog();
    }
  }

  void _showInsufficientTokensDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Center(
            child: Text(
              'Insufficient Tokens',
              style: CustomTextStyles.largeBlackColorStyle,
            ),
          ),
          content: Text(
            'You do not have enough tokens to redeem this voucher.',
            style: CustomTextStyles.mediumBlackColorStyle2,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                child: Text(
                  'Close',
                  style: CustomTextStyles.mediumBlackColorStyle2.copyWith(
                    color: AppColors.themeColor,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themeColor,
        title: Text(
          'Token Summary',
          style: CustomTextStyles.appBarWhiteSmallStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Icon(FontAwesomeIcons.coins, size: 80, color: AppColors.themeColor),
                    SizedBox(height: 10),
                    Text(
                      'Total Tokens: $totalTokens',
                      style: CustomTextStyles.largeBlackColorStyle,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'What You Can Do with Tokens:',
                      style: CustomTextStyles.mediumBlackColorStyle2,
                    ),
                    SizedBox(height: 10),
                    Text(
                      '1. Redeem for Rewards',
                      style: CustomTextStyles.smallGreyColorStyle,
                    ),
                    Text(
                      '2. Get Exclusive Access',
                      style: CustomTextStyles.smallGreyColorStyle,
                    ),
                    Text(
                      '3. Donate to Special Causes',
                      style: CustomTextStyles.smallGreyColorStyle,
                    ),
                    SizedBox(height: 20),
                    VoucherCard(
                      icon: FontAwesomeIcons.amazon,
                      title: 'Amazon Voucher',
                      tokens: 50,
                      couponCode: 'AMZ1234',
                      onRedeem: _redeemTokens,
                    ),
                    SizedBox(height: 20),
                    VoucherCard(
                      icon: FontAwesomeIcons.shoppingCart,
                      title: 'Flipkart Voucher',
                      tokens: 50,
                      couponCode: 'FLIP1234',
                      onRedeem: _redeemTokens,
                    ),
                    SizedBox(height: 20),
                    VoucherCard(
                      icon: FontAwesomeIcons.basketShopping,
                      title: 'Big Basket Voucher',
                      tokens: 50,
                      couponCode: 'BIGB1234',
                      onRedeem: _redeemTokens,
                    ),
                    SizedBox(height: 20),
                    VoucherCard(
                      icon: FontAwesomeIcons.chair,
                      title: 'IKEA Furniture Voucher',
                      tokens: 100,
                      couponCode: 'IKEA1234',
                      onRedeem: _redeemTokens,
                    ),
                    SizedBox(height: 20),
                    VoucherCard(
                      icon: FontAwesomeIcons.utensils,
                      title: 'Swiggy Voucher',
                      tokens: 50,
                      couponCode: 'SWIG1234',
                      onRedeem: _redeemTokens,
                    ),
                    SizedBox(height: 20),
                    VoucherCard(
                      icon: FontAwesomeIcons.hamburger,
                      title: 'Zomato Voucher',
                      tokens: 50,
                      couponCode: 'ZOMA1234',
                      onRedeem: _redeemTokens,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VoucherCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final int tokens;
  final String couponCode;
  final Function(int tokens) onRedeem;

  const VoucherCard({
    super.key,
    required this.icon,
    required this.title,
    required this.tokens,
    required this.couponCode,
    required this.onRedeem,
  });

  void _showCouponCode(BuildContext context, String couponCode) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Center(
            child: Text(
              'Coupon Code',
              style: CustomTextStyles.largeBlackColorStyle,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                FontAwesomeIcons.ticketAlt,
                size: 40,
                color: AppColors.themeColor,
              ),
              SizedBox(height: 20),
              Text(
                couponCode,
                style: CustomTextStyles.largeBlackColorStyle,
              ),
            ],
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                child: Text(
                  'Close',
                  style: CustomTextStyles.mediumBlackColorStyle2.copyWith(
                    color: AppColors.themeColor,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Center(
              child: TextButton(
                child: Text(
                  'Redeem Now',
                  style: CustomTextStyles.mediumBlackColorStyle2.copyWith(
                    color: AppColors.themeColor,
                  ),
                ),
                onPressed: () {
                  onRedeem(tokens);
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),  // Adjusted padding
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.themeColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 30, color: AppColors.themeColor),
            ),
            SizedBox(width: 10),  // Adjusted spacing
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: CustomTextStyles.largeBlackColorStyle,
                  ),
                  SizedBox(height: 5),
                  Text(
                    '$tokens Tokens',
                    style: CustomTextStyles.mediumBlackColorStyle2,
                  ),
                ],
              ),
            ),
            TextButton.icon(
              onPressed: () {
                _showCouponCode(context, couponCode);
              },
              icon: Icon(
                FontAwesomeIcons.eye,
                color: AppColors.themeColor,
                size: 16,
              ),
              label: Text(
                'View Coupon',
                style: CustomTextStyles.smallGreyColorStyle.copyWith(color: AppColors.themeColor),
              ),
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                backgroundColor: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
