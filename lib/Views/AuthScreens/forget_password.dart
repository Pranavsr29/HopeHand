import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';

import '../Utils/Components/common_field.dart';
import '../Utils/Components/login_button.dart';
import '../Utils/Styles/text_styles.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController reEnterPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _showPasswordResetNotification() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Password has been reset successfully'),
      ),
    );
  }

  void _resetPassword() {
    if (_formKey.currentState!.validate()) {
      // Handle the submit action
      _showPasswordResetNotification();
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      resizeToAvoidBottomInset: true, // This will adjust the body when keyboard appears
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Forgot password',
                style: CustomTextStyles.appBarStyle,
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Enter your email to reset password',
                style: CustomTextStyles.smallGreyColorStyle,
              ),
              const SizedBox(
                height: 20,
              ),
              CommonTextField(
                controller: emailController,
                validate: (val) {
                  if (val!.isEmpty) {
                    return "Email must be given";
                  } else if (!EmailValidator.validate(val)) {
                    return "Incorrect Email Format";
                  } else {
                    return null;
                  }
                },
                obsecureText: false,
                hintText: 'johndoe@example.com',
                maxLines: 1, // Ensure it's a single-line text field
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Enter New Password',
                style: CustomTextStyles.smallGreyColorStyle,
              ),
              const SizedBox(
                height: 5,
              ),
              CommonTextField(
                controller: newPasswordController,
                validate: (val) {
                  if (val!.isEmpty) {
                    return "Password must be given";
                  } else if (val.length < 6) {
                    return "Password must be at least 6 characters";
                  } else {
                    return null;
                  }
                },
                obsecureText: true,
                hintText: 'Enter new password',
                maxLines: 1, // Ensure it's a single-line text field
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Re-enter New Password',
                style: CustomTextStyles.smallGreyColorStyle,
              ),
              const SizedBox(
                height: 5,
              ),
              CommonTextField(
                controller: reEnterPasswordController,
                validate: (val) {
                  if (val!.isEmpty) {
                    return "Re-enter password";
                  } else if (val != newPasswordController.text) {
                    return "Passwords do not match";
                  } else {
                    return null;
                  }
                },
                obsecureText: true,
                hintText: 'Re-enter new password',
                maxLines: 1, // Ensure it's a single-line text field
              ),
              const SizedBox(
                height: 25,
              ),
              CommonButton(
                onPressed: _resetPassword,
                child: Text(
                  'Submit',
                  style: CustomTextStyles.commonButtonStyle,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Row(
                children: [
                  Icon(
                    Icons.info,
                    color: Colors.grey,
                    size: 30,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "You will receive an email that will contain a token to recover the forgotten password!",
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: CustomTextStyles.smallGreyColorStyle,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
