import 'dart:async';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:email_validator/email_validator.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../components/components.dart';
import '../../components/constant.dart';
import '../home_screen.dart';
import '../login/login-page.dart';
import '../verify.dart';
import 'cuibt/cuibt.dart';
import 'cuibt/states.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool load = false;
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  var passwordController = TextEditingController();

  var confirmPasswordController = TextEditingController();

  late StreamSubscription<InternetConnectionStatus> subscription;

  @override
  initState() {
    super.initState();

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

// Be sure to cancel subscription after you are done
  @override
  dispose() {
    super.dispose();

    subscription.cancel();
  }

  var nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            pageNum = 0;
            final snackBar = SnackBar(
              padding: EdgeInsets.all(width * .03),
              content: const Text('تم ارسال رسالة التحقق'),
              action: SnackBarAction(
                label: 'أذهب',
                onPressed: () async {
                  await LaunchApp.openApp(
                    androidPackageName: 'com.google.android.gm',
                    openStore: true,
                  );
                },
              ),
            );

            // Find the ScaffoldMessenger in the widget tree
            // and use it to show a SnackBar.
            // userId=FirebaseAuth.instance.currentUser!.uid;

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const VerifyPage()));
          }
        },
        builder: (context, state) {
          RegisterCubit cubit = RegisterCubit.get(context);

          return Directionality(
            textDirection: TextDirection.rtl,
            child: WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: Scaffold(
                body: SafeArea(
                  child: state is RegisterLoadingState
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        "assets/images/car-services.png",
                                        width: width * .4,
                                      ),
                                      SizedBox(
                                        height: height * .03,
                                      ),
                                      Form(
                                        key: formKey,
                                        child: Column(
                                          children: [
                                            defaultFormField(
                                                context: context,
                                                controller: nameController,
                                                type: TextInputType.text,
                                                validate: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "الحقل فارغ";
                                                  }
                                                  return null;
                                                },
                                                label: "أسمك بالكامل",
                                                prefix: Icons.person_outlined),
                                            SizedBox(
                                              height: height * .03,
                                            ),
                                            defaultFormField(
                                                context: context,
                                                controller: phoneController,
                                                type: TextInputType.phone,
                                                validate: (val) {
                                                  if (val == null ||
                                                      val.isEmpty) {
                                                    return "الحقل فارغ";
                                                  } else if (val.length < 11) {
                                                    return "الرقم اللذي ادخلته غير صحيح";
                                                  }

                                                  return null;
                                                },
                                                label: "رقم الهاتف",
                                                prefix: Icons.phone),
                                            SizedBox(
                                              height: height * .03,
                                            ),
                                            defaultFormField(
                                                context: context,
                                                controller: emailController,
                                                type:
                                                    TextInputType.emailAddress,
                                                validate: (val) => EmailValidator
                                                        .validate(val!)
                                                    ? null
                                                    : "أدخل الايميل بطريقه صحيحة",
                                                label: "البريد الالكتروني",
                                                prefix: Icons.email_outlined),
                                            SizedBox(
                                              height: height * .03,
                                            ),
                                            defaultFormField(
                                                context: context,
                                                controller: passwordController,
                                                isPassword:
                                                    cubit.isFirstPasswordShow,
                                                type: TextInputType
                                                    .visiblePassword,
                                                validate: (val) {
                                                  if (val == null ||
                                                      val.isEmpty) {
                                                    return "الحقل فارغ";
                                                  } else if (val.length < 8) {
                                                    return "8 حروف أو أكثر";
                                                  }
                                                  return null;
                                                },
                                                label: "الرقم السرى",
                                                prefix: Icons.lock_open,
                                                suffixPressed:
                                                    cubit.toggleFirstPass,
                                                suffix: cubit
                                                        .isFirstPasswordShow
                                                    ? Icons.visibility_outlined
                                                    : Icons
                                                        .visibility_off_outlined),
                                            SizedBox(
                                              height: height * .03,
                                            ),
                                            defaultFormField(
                                                context: context,
                                                controller:
                                                    confirmPasswordController,
                                                isPassword:
                                                    cubit.isConfirmPasswordShow,
                                                type: TextInputType
                                                    .visiblePassword,
                                                validate: (val) {
                                                  if (val == null ||
                                                      val.isEmpty) {
                                                    return "الحقل فارغ";
                                                  }
                                                  if (val !=
                                                      passwordController.text) {
                                                    return "الرقم السرى غير متطابق";
                                                  }
                                                  return null;
                                                },
                                                label:
                                                    "أعاده كتابة الرقم السرى",
                                                prefix: Icons.lock_open,
                                                suffixPressed:
                                                    cubit.toggleSecondPass,
                                                suffix: cubit
                                                        .isConfirmPasswordShow
                                                    ? Icons.visibility_outlined
                                                    : Icons
                                                        .visibility_off_outlined),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * .03,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(width * .02),
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: MaterialButton(
                                            color: const Color(0xff334758),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      width * .03),
                                            ),
                                            onPressed: () async {
                                              if (hasInternet) {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  cubit.signUp(context,
                                                      email:
                                                          emailController.text,
                                                      name: nameController.text,
                                                      phone:
                                                          phoneController.text,
                                                      password:
                                                          passwordController
                                                              .text);
                                                  // Navigator.pushReplacement(
                                                  //     context,
                                                  //     MaterialPageRoute(
                                                  //         builder: (context) =>
                                                  //             MainHomeScreen()));
                                                  // await cubit.signIn(context);
                                                }
                                              } else {
                                                Fluttertoast.showToast(
                                                  msg: "No Internet Connection",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  textColor:
                                                      const Color(0xff334758),
                                                );
                                              }
                                            },
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.all(width * .03),
                                              child: Text(
                                                'انشاء حساب',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: width * 0.045,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
