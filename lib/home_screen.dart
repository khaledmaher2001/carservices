import 'dart:io';
import 'package:carservices/components/constant.dart';
import 'package:carservices/constants.dart';
import 'package:carservices/login/cuibt/cuibt.dart';
import 'package:carservices/login/cuibt/states.dart';
import 'package:carservices/login/login-page.dart';
import 'package:carservices/shared/network/local/cache_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'body-content.dart';


class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  State<MainHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MainHomeScreen> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();

    LoginCubit.get(context).getUserData();
    userId=FirebaseAuth.instance.currentUser!.uid;


}
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;

    var scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocConsumer<LoginCubit,LoginStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: Builder(
              builder: (context) => // Ensure Scaffold is in context
              IconButton(
                  icon: const Icon(Icons.menu, color: Colors.black,),
                  onPressed: () => Scaffold.of(context).openDrawer()
              ),
            ),
            title: InkWell(
              onTap: () {
                // Navigator.pushReplacement(
                //     context, MaterialPageRoute(
                //     builder: (context) => const MainWebsite()));
              },
              child: Image.asset(
                "assets/images/car-services.png",
                width: 50,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            actions: [
              Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: CircleAvatar(radius: (20),
                      backgroundColor: Colors.grey.withOpacity(.6),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          "assets/images/person.png", fit: BoxFit.cover,),
                      )
                  )
              ),
            ],
          ),
          body: BodyContent(),
          bottomNavigationBar: Directionality(

            textDirection: TextDirection.rtl,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              elevation: 15,
              backgroundColor: Colors.white,
              currentIndex: selectedIndexBodyContent,
              selectedItemColor: const Color(0xff334758),
              unselectedItemColor: Colors.grey,
              onTap: (int index) {
                setState(() {
                  selectedIndexBodyContent = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: "الصفحة الرئيسية"),

                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "الملف الشخصي"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.mail), label: "الاشعارات"),
              ],
            ),
          ),
          drawer: Directionality(
            textDirection: TextDirection.rtl,
            child: Drawer(
              child:state is GetUsersLoadingState?CircularProgressIndicator(): ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: [
                  UserAccountsDrawerHeader( // <-- SEE HERE
                    decoration:  BoxDecoration(color: Colors.red.withOpacity(.8)),
                    currentAccountPicture: CircleAvatar(radius: 50,
                        backgroundColor: Colors.grey.withOpacity(.6),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.asset(
                            "assets/images/person.png", fit: BoxFit.cover,
                            width: 60,),
                        )
                    ),
                    accountName:  Text(
                      userData!.name??"",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    accountEmail: Text(
                      userData!.email??"",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      CupertinoIcons.square_arrow_left,
                    ),
                    title: const Text('تسجيل الخروج'),
                    onTap: () async {
                      CacheHelper.removeData(key: "userName");
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => const LoginPage()));                      },
                  ),
                ],
              ),
            ),
          ),);
      },
    );

  }}
