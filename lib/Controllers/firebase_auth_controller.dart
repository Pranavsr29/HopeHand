import 'package:charity_app/Views/AuthScreens/auth_check.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../Views/AuthScreens/login_screen.dart';

class FirebaseController extends GetxController {//This class extends GetxController from the GetX package, providing methods to handle user authentication and manage UI states.
  RxBool loader = false.obs;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      loader.value = true;
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      loader.value = false;
      Get.offAll(() => CheckAuth());
      print(user);
    } catch (e) {
      loader.value = false;
      Get.snackbar('Error', 'Something went wrong');
      print('Error: $e');
    }
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      loader.value = true;
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      await FirebaseFirestore.instance.collection('auth').doc(user!.uid).set({
        'email': email,
        'name': name,
        'role': 'user',
      }).then((value) {
        loader.value = false;
        Get.snackbar('Success', "User Created Successfully");
        Get.offAll(() => LoginScreen());
      });
    } catch (e) {
      print('Error: $e');
      loader(false);
    }
  }

  logOut() async {
    await FirebaseAuth.instance.signOut().then((value) {
      Get.snackbar('Success', 'User Logout Successfully');
      Get.offAll(() => LoginScreen());
    });
  }
}
