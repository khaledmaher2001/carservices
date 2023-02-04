import 'dart:convert';

import 'package:carservices/home/cubit/cubit.dart';
import 'package:carservices/home_screen.dart';
import 'package:carservices/login/cuibt/cuibt.dart';
import 'package:carservices/shared/network/local/cache_helper.dart';
import 'package:carservices/shared/network/remote/dio_helper.dart';
import 'package:carservices/splash-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/components.dart';
import 'components/constant.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  CacheHelper.init();
  await DioHelper.init();
  await Firebase.initializeApp();
    userId=FirebaseAuth.instance.currentUser!.uid??"";
  runApp(  MultiBlocProvider(

    providers: [
      BlocProvider(create: (BuildContext context)=>AppCubit()),
      BlocProvider(create: (BuildContext context)=>LoginCubit()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      //
      // home: active ? AdminLogin ?const AdminHome(): Services():const SplashScreen(),
      home: AdminLogin ?const MainHomeScreen(): const SplashScreen(),
      theme: ThemeData(
          primarySwatch: Colors.grey
      ),
      title: "Car Services",
    ),
  ));
}

