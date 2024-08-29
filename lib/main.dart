import 'package:charity_app/Views/AuthScreens/login_screen.dart';
import 'package:charity_app/Views/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';// imports all widgets 
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';


void main() async {//If we didn't use async and await, we wouldn't be able to properly initialize Firebase before running the app. This could lead to issues where parts of the app try to use Firebase before it's ready.
 WidgetsFlutterBinding.ensureInitialized();
   if(kIsWeb){
  await Firebase.initializeApp(options: FirebaseOptions( apiKey: "AIzaSyCQOi1WD_gT8sM1YapkqQPZiak94_oHHJQ",
    authDomain: "charityapp3-ea0a6.firebaseapp.com",
    projectId: "charityapp3-ea0a6",
    storageBucket: "charityapp3-ea0a6.appspot.com",
    messagingSenderId: "509627058092",
    appId: "1:509627058092:web:c3b149217232cecc7a9c09"));
   }
   else{
    await Firebase.initializeApp();
   }
  runApp(const MyApp());//
}

class MyApp extends StatelessWidget {// Stateless widgets are widgets that never change 
//MaterialApp is a widget that introduces the Navigator and Theme widgets required to create a material design app. 
//Scaffold Widget is a MaterialApp component that provides numerous fundamental features such as AppBar, BottomNavigationBar, Drawer, FloatingActionButton,etc
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(//Material ap is the widget that remains constant throughout the app 
      debugShowCheckedModeBanner: false,
      title: 'Charity App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
      },
    );
  }
}
