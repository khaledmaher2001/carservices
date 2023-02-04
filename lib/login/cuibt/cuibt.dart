import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:carservices/components/constant.dart';
import 'package:carservices/components/constant.dart';
import 'package:carservices/login/cuibt/states.dart';
import 'package:carservices/models/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../login-page.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPasswordShow = true;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void toggle() {
    isPasswordShow = !isPasswordShow;
    emit(ChangeSuffixIconState());
  }

  signIn(context) async {
    try {
      emit(LoginLoadingState());
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((value) async {
        if (value.user!.emailVerified) {
          userId = FirebaseAuth.instance.currentUser!.uid;
          await LoginCubit.get(context).getUserData();
          emit(LoginSuccessState());
        } else {
          emit(LoginVerifyState());
        }
      });
    } on FirebaseAuthException catch (e) {
      emit(LoginErrorState(e));
      if (e.code == "user-not-found") {
        AwesomeDialog(
                context: context,
                dialogType: DialogType.ERROR,
                animType: AnimType.BOTTOMSLIDE,
                title: 'Error',
                desc: 'User Not Found !',
                btnOkColor: Colors.red,
                btnOkOnPress: () {})
            .show();
      } else if (e.code == "wrong-password") {
        AwesomeDialog(
                context: context,
                dialogType: DialogType.ERROR,
                animType: AnimType.BOTTOMSLIDE,
                title: 'Error',
                desc: 'Wrong Password!',
                btnOkOnPress: () {},
                btnOkColor: Colors.red)
            .show();
      }
    } catch (e) {
      emit(LoginErrorState(e));
      print(e);
    }
  }
  Future<void> signOut(context) async {
    CacheHelper.removeData(key: "userName");
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  getUserData() async {
    emit(GetUsersLoadingState());
    await FirebaseFirestore.instance
        .collection("users")
        .where("userId", isEqualTo: userId)
        .get()
        .then((value) {
      for (var element in value.docs) {
        userData = UserData.fromJson(element.data());
      }
      print("from data : ${userData!.name}");
      userName = userData!.name;
      CacheHelper.saveData(key: "userName", value: userData!.name);
      print("from Cache : ${CacheHelper.getData(key: 'userName')}");
      emit(GetUsersSuccessState());
    }).catchError((error) {
      emit(GetUsersErrorState());
    });
  }
}
