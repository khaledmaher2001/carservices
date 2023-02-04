import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../components/constant.dart';
import '../login/cuibt/cuibt.dart';
import '../login/cuibt/states.dart';
import '../login/login-page.dart';
import 'home_screen.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({Key? key}) : super(key: key);

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

bool isEmailVerified = false;
Timer? timer;

class _VerifyPageState extends State<VerifyPage> {
  late StreamSubscription<InternetConnectionStatus> subscription;
  bool load = false;

  @override
  void initState() {
    super.initState();
    // isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      timer = Timer.periodic(
          const Duration(seconds: 3), (_) => checkEmailVerified());
    }
    subscription = InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            setState(() {
              load = false;
              hasInternet = true;
            });
            print(hasInternet);
            break;
          case InternetConnectionStatus.disconnected:
            // ignore: avoid_print
            setState(() {
              hasInternet = false;
            });
            print(hasInternet);
            break;
        }
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
    subscription.cancel();
  }

  Future checkEmailVerified() async {
    // await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      // isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) {
      timer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {
            if(state is GetUsersSuccessState){
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MainHomeScreen()));
            }
          },
          builder: (context, state) {
            LoginCubit cubit =LoginCubit();
            // return FirebaseAuth.instance.currentUser!.emailVerified?
                return WillPopScope(
                    onWillPop: () async {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                          (route) => false);
                      return true;
                    },
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Scaffold(
                        body: state is GetUsersLoadingState ? const Center(child: CircularProgressIndicator()):Padding(
                          padding: EdgeInsets.all(width * 0.03),
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/motivation.png",
                                  width: width * 0.4,
                                  color: const Color(0xff1bbd9d),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(width * 0.05),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "تم التحقق بنجاح",
                                        style: TextStyle(
                                          fontSize: width * 0.046,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xff1bbd9d),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "استمرار بــ",
                                            style: TextStyle(
                                              fontSize: width * 0.046,
                                              color: const Color(0xff1bbd9d),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            FirebaseAuth.instance.currentUser!.email!
                                           ,
                                            style: TextStyle(
                                              fontSize: width * 0.046,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xff1bbd9d),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(width * 0.03),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: MaterialButton(
                                      color: const Color(0xff1bbd9d),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(width * 0.03),
                                      ),
                                      onPressed: () async {
                                        if (hasInternet) {
                                          await LoginCubit.get(context)
                                              .getUserData();

                                        } else {
                                          Fluttertoast.showToast(
                                            msg: "لا يوجد اتصال بالانترنت",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            backgroundColor:
                                                const Color(0xff1bbd9d),
                                            textColor: Colors.white,
                                          );
                                        }
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(width * 0.03),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'استمرار',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: width * 0.046,
                                              ),),

                                            SizedBox(
                                              width: width * 0.05,
                                            ),
                                            const Icon(
                                              Icons.arrow_forward,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(width * 0.03),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: OutlinedButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginPage()));
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(width * 0.03),
                                        child: const Text('تسجيل الخروج'),
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                            width: 2.0,
                                            color: Color(0xff1bbd9d)),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                // : WillPopScope(
                //     onWillPop: () async {
                //       Navigator.pushAndRemoveUntil(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => const LoginPage()),
                //           (route) => false);
                //       return true;
                //     },
                //     child: Directionality(
                //       textDirection: TextDirection.rtl,
                //       child: Scaffold(
                //         body: Padding(
                //           padding: EdgeInsets.all(width * 0.03),
                //           child: SizedBox(
                //             width: double.infinity,
                //             child: Column(
                //               crossAxisAlignment: CrossAxisAlignment.center,
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: [
                //                 Image.asset(
                //                   "assets/images/sent.png",
                //                   width: width * 0.42,
                //                   color: const Color(0xff1bbd9d),
                //                 ),
                //                 Padding(
                //                   padding: EdgeInsets.all(width * 0.03),
                //                   child: pageNum == 0
                //                       ? Text(
                //                           "تم ارسال رسالة التحقق الى بريدك الالكتروني",
                //                           style: TextStyle(
                //                             fontSize: width * 0.03,
                //                             fontWeight: FontWeight.bold,
                //                             color: Color(0xff1bbd9d),
                //                           ),
                //                           textAlign: TextAlign.center,
                //                         )
                //                       : Text(
                //                           "اضغط ارسال لارسال رسالة التحقق الي بريدك الالكترونى",
                //                           style: TextStyle(
                //                             fontSize: width * 0.046,
                //                             fontWeight: FontWeight.bold,
                //                             color: Color(0xff1bbd9d),
                //                           ),
                //                           textAlign: TextAlign.center,
                //                         ),
                //                 ),
                //                 Padding(
                //                   padding: EdgeInsets.all(width * 0.03),
                //                   child: SizedBox(
                //                     width:
                //                         MediaQuery.of(context).size.width / 2,
                //                     child: MaterialButton(
                //                       color: const Color(0xff1bbd9d),
                //                       shape: RoundedRectangleBorder(
                //                         borderRadius:
                //                             BorderRadius.circular(width * 0.03),
                //                       ),
                //                       onPressed: () async {
                //                         if (hasInternet) {
                //                           // User? user =
                //                           //     FirebaseAuth.instance.currentUser;
                //                           // await user?.sendEmailVerification();
                //                           final snackBar = SnackBar(
                //                             padding: const EdgeInsets.all(10),
                //                             content: const Text(
                //                                 'تم ارسال رسالة التحقق'),
                //                             action: SnackBarAction(
                //                               label: 'اذهب',
                //                               onPressed: () async {
                //                                 await LaunchApp.openApp(
                //                                   androidPackageName:
                //                                       'com.google.android.gm',
                //                                   openStore: true,
                //                                 );
                //                               },
                //                             ),
                //                           );
                //
                //                           // Find the ScaffoldMessenger in the widget tree
                //                           // and use it to show a SnackBar.
                //                           ScaffoldMessenger.of(context)
                //                               .showSnackBar(snackBar);
                //                         } else {
                //                           Fluttertoast.showToast(
                //                               msg: "لا يوجد اتصال بالانترنت",
                //                               toastLength: Toast.LENGTH_SHORT,
                //                               gravity: ToastGravity.BOTTOM,
                //                               backgroundColor:
                //                                   const Color(0xff1bbd9d),
                //                               textColor: Colors.white);
                //                         }
                //                       },
                //                       child: Padding(
                //                         padding: EdgeInsets.all(width * 0.03),
                //                         child: Row(
                //                           mainAxisAlignment:
                //                               MainAxisAlignment.center,
                //                           children: [
                //                             const Icon(
                //                               Icons.email,
                //                               color: Colors.white,
                //                             ),
                //                             SizedBox(
                //                               width: width * 0.04,
                //                             ),
                //                             pageNum == 0
                //                                 ? Text(
                //                                     'اعادة ارسال',
                //                                     style: TextStyle(
                //                                       color: Colors.white,
                //                                       fontSize: width * 0.046,
                //                                     ),
                //                                   )
                //                                 : Text(
                //                                     'ارسال',
                //                                     style: TextStyle(
                //                                       color: Colors.white,
                //                                       fontSize: width * 0.046,
                //                                     ),
                //                                   ),
                //                           ],
                //                         ),
                //                       ),
                //                     ),
                //                   ),
                //                 ),
                //                 Padding(
                //                   padding: EdgeInsets.all(width * 0.03),
                //                   child: SizedBox(
                //                     width:
                //                         MediaQuery.of(context).size.width / 2,
                //                     child: OutlinedButton(
                //                       onPressed: () {
                //                         if (hasInternet) {
                //                           // cubit.signOut(context);
                //                           Navigator.pushAndRemoveUntil(
                //                               context,
                //                               MaterialPageRoute(
                //                                   builder: (context) =>
                //                                       LoginPage()),
                //                               (route) => false);
                //                         } else {
                //                           Fluttertoast.showToast(
                //                             msg: "لا يوجد اتصال بالانترنت",
                //                             toastLength: Toast.LENGTH_SHORT,
                //                             gravity: ToastGravity.BOTTOM,
                //                             backgroundColor:
                //                                 const Color(0xff1bbd9d),
                //                             textColor: Colors.white,
                //                           );
                //                         }
                //                       },
                //                       child:  Padding(
                //                         padding: EdgeInsets.all(width*.03),
                //                         child: const Text('الغاء'),
                //                       ),
                //                       style: OutlinedButton.styleFrom(
                //                         side: const BorderSide(
                //                             width: 2.0,
                //                             color: Color(0xff1bbd9d)),
                //                       ),
                //                     ),
                //                   ),
                //                 )
                //               ],
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   );
          }),
    );
  }
}
