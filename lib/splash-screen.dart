
import 'dart:async';
import 'package:carservices/login/login-page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';
class SplashScreen extends StatelessWidget {
   const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>FirebaseAuth.instance.currentUser==null? const LoginPage():MainHomeScreen()));
    });
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/car-services.png",width: MediaQuery.of(context).size.width/1.5,),
      ),
    );
  }
}
