
import 'package:carservices/home_screen.dart';
import 'package:carservices/shared/network/local/cache_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../components/components.dart';
import '../../components/constant.dart';
import '../register/register_screen.dart';
import '../verify.dart';
import 'cuibt/cuibt.dart';
import 'cuibt/states.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) async {
          if (state is LoginSuccessState) {
            CacheHelper.saveData(key: "userId", value: FirebaseAuth.instance.currentUser!.uid);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MainHomeScreen()),
                    (route) => false);
          } else if (state is LoginVerifyState) {
            pageNum = 1;
            userId = FirebaseAuth.instance.currentUser!.uid;
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const VerifyPage()),
                (route) => false);
          }
        },
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: WillPopScope(
              onWillPop: () async {
                singleImage = null;
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MainHomeScreen()),
                    (route) => false);
                return true;
              },
              child: Scaffold(
                  body: state is! LoginLoadingState
                      ? state is GetUsersLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Padding(
                              padding: EdgeInsets.all(width * .06),
                              child: Center(
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/car-services.png",
                                        width: width * .4,
                                      ),
                                      Text(
                                        "Car Services",
                                        style: TextStyle(
                                          color:  Colors.black,
                                          fontSize: width * 0.1,
                                          fontFamily: 'DancingScript',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * .03,
                                      ),
                                      Form(
                                        key: cubit.formKey,
                                        child: Column(
                                          children: [
                                            defaultFormField(
                                                context: context,
                                                controller:
                                                    cubit.emailController,
                                                type:
                                                    TextInputType.emailAddress,
                                                validate: (val) {
                                                  if (val == null ||
                                                      val.isEmpty) {
                                                    return "الحقل فارغ";
                                                  }
                                                  return null;
                                                },
                                                label: "البريد الالكتروني",
                                                prefix: Icons.person),
                                            SizedBox(
                                              height: height * .03,
                                            ),
                                            defaultFormField(
                                                context: context,
                                                controller:
                                                    cubit.passwordController,
                                                isPassword:
                                                    cubit.isPasswordShow,
                                                type: TextInputType
                                                    .visiblePassword,
                                                validate: (val) {
                                                  if (val == null ||
                                                      val.isEmpty) {
                                                    return "الحقل فارغ";
                                                  }
                                                  return null;
                                                },
                                                label: "كلمة المرور",
                                                prefix: Icons.lock_open,
                                                suffixPressed: cubit.toggle,
                                                suffix: cubit.isPasswordShow
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
                                                if (cubit.formKey.currentState!
                                                    .validate()) {
                                                  await cubit.signIn(context);
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
                                                'تسجيل الدخول',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: width * 0.045,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "ليس لديك حساب ؟",
                                            style: TextStyle(
                                              fontSize: width * 0.045,
                                            ),
                                          ),
                                          SizedBox(
                                            width: width * .02,
                                          ),
                                          InkWell(
                                            child: Text(
                                              'أنشاء حساب',
                                              style: TextStyle(
                                                color: const Color(0xff334758),
                                                fontSize: width * 0.045,
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          RegisterScreen()));
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                      : const Center(
                          child: CircularProgressIndicator(),
                        )),
            ),
          );
        },
      ),
    );
  }
}
