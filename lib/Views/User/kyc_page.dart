import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:charity_app/Views/Utils/Styles/app_colors.dart';
import 'package:charity_app/Views/Utils/Styles/text_styles.dart';

class KycPage extends StatefulWidget {
  const KycPage({super.key});

  @override
  _KycPageState createState() => _KycPageState();
}

class _KycPageState extends State<KycPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _aadhaarController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _bankAccountController = TextEditingController();
  final TextEditingController _ifscController = TextEditingController();
  final TextEditingController _charityDetailsController = TextEditingController();

  Future<void> _submitKyc() async {
    if (_formKey.currentState!.validate()) {
      // Save the data to Firestore
      try {
        await FirebaseFirestore.instance.collection('kyc').add({
          'name': _nameController.text,
          'aadhaar': _aadhaarController.text,
          'pan': _panController.text,
          'bankName': _bankNameController.text,
          'bankAccount': _bankAccountController.text,
          'ifsc': _ifscController.text,
          'charityDetails': _charityDetailsController.text,
          'timestamp': FieldValue.serverTimestamp(),
        });
        Get.snackbar('Success', 'The KYC process has been initiated and will be confirmed shortly.');
        Navigator.pop(context, true); // Returning true to indicate KYC completion
      } catch (e) {
        Get.snackbar('Error', 'Failed to submit KYC: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themeColor,
        title: Text(
          'KYC Verification',
          style: CustomTextStyles.appBarWhiteSmallStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Complete Your KYC',
                  style: CustomTextStyles.mediumBlackColorStyle2.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _aadhaarController,
                  decoration: InputDecoration(
                    labelText: 'Aadhaar ID',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Aadhaar ID';
                    } else if (value.length != 12) {
                      return 'Aadhaar ID must be exactly 12 digits';
                    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Aadhaar ID must contain only numbers';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _panController,
                  decoration: InputDecoration(
                    labelText: 'PAN Card Number',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your PAN card number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _bankNameController,
                  decoration: InputDecoration(
                    labelText: 'Bank Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your bank name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _bankAccountController,
                  decoration: InputDecoration(
                    labelText: 'Bank Account Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your bank account number';
                    } else if (value.length > 14) {
                      return 'Bank account number must be 14 digits or less';
                    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Bank account number must contain only numbers';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _ifscController,
                  decoration: InputDecoration(
                    labelText: 'IFSC Code',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your bank\'s IFSC code';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _charityDetailsController,
                  decoration: InputDecoration(
                    labelText: 'Charity Details(brief explination)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter charity details';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitKyc,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.themeColor,
                  ),
                  child: Text('Submit KYC'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
