import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:carservices/register/cuibt/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user_data.dart';


class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);


  int currentStep = 0;
  bool isConfirmPasswordShow = true;
  bool isFirstPasswordShow = true;

  void toggleFirstPass() {
    isFirstPasswordShow = !isFirstPasswordShow;
    emit(ChangeSuffixIconState());
  }

  void toggleSecondPass() {
    isConfirmPasswordShow = !isConfirmPasswordShow;
    emit(ChangeSuffixIconState());
  }
  void onStepContinue() {
    currentStep++;
    emit(OnStepContinueState());
  }
  String dropValC = 'Select Item';
  void dropChangeC(value) {
    dropValC = value;
    emit(DropChangeState());
  }
  void dropChangeGender(value) {
    dropValC = value as String;
    emit(DropChangeState());
  }
  User? user;

  signUp(
      context,
      {
        required String email,
        required String name,
        required String phone,
        required String password,

      }) async {
    try {
      emit(RegisterLoadingState());
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email.trim(),
          password: password);
      print("*******************************************");
      print(userCredential.user!.email);
      print("*******************************************");
      if (userCredential.user!.emailVerified == false) {
        user = FirebaseAuth.instance.currentUser;
        await user?.sendEmailVerification();
      }
      createUser(
        email: email,
        userId: user!.uid,
        name: name,
        phone: phone,

      );
      emit(RegisterSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(RegisterErrorState(e));
      if (e.code == "weak-password") {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.BOTTOMSLIDE,
            title: 'Error',
            desc: 'Password Is Too Weak!!',
            btnOkColor: Colors.red,
            btnOkOnPress: () {})
            .show();
      } else if (e.code == "email-already-in-use") {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.BOTTOMSLIDE,
            title: 'Error',
            desc: 'Email Already In Use!!',
            btnOkOnPress: () {},
            btnOkColor: Colors.red)
            .show();
      }
    } catch (e) {
      emit(RegisterErrorState(e));
      print(e);
    }
  }

  void createUser({
    required String email,
    required String userId,
    required String name,
    required String phone,
  }) {
    UserData model = UserData(
      name: name,
      email: email,
      phone: phone,
      userId: userId,
    );
    FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set(model.toMap())
        .then((value) {
          print("User Created");
      emit(CreateUserSucceedState(userId.toString()));
    }).catchError((error) {
      print(error.toString());
      emit(CreateUserErrorState(error.toString()));
    });
  }


  onStepCancel() {
    currentStep--;
    emit(OnStepCancelState());
  }

  onStepTap(int step) {
    currentStep = step;
    emit(OnStepTapState());
  }

  final formKey = GlobalKey<FormState>();

  // signUp(context) async {
  //   try {
  //     emit(RegisterLoadingState());
  //     UserCredential userCredential = await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(
  //             email: emailController.text.trim(),
  //             password: passwordController.text.trim());
  //     print(userCredential.user!.emailVerified);
  //     if (userCredential.user!.emailVerified == false) {
  //       User? user = FirebaseAuth.instance.currentUser;
  //       await user?.sendEmailVerification();
  //     }
  //     emit(RegisterSuccessState());
  //   } on FirebaseAuthException catch (e) {
  //     emit(RegisterErrorState(e));
  //     if (e.code == "weak-password") {
  //       AwesomeDialog(
  //               context: context,
  //               dialogType: DialogType.ERROR,
  //               animType: AnimType.BOTTOMSLIDE,
  //               title: 'Error',
  //               desc: 'Password Is Too Weak!!',
  //               btnOkColor: Colors.red,
  //               btnOkOnPress: () {})
  //           .show();
  //     } else if (e.code == "email-already-in-use") {
  //       AwesomeDialog(
  //               context: context,
  //               dialogType: DialogType.ERROR,
  //               animType: AnimType.BOTTOMSLIDE,
  //               title: 'Error',
  //               desc: 'Email Already In Use!!',
  //               btnOkOnPress: () {},
  //               btnOkColor: Colors.red)
  //           .show();
  //     }
  //   } catch (e) {
  //     emit(RegisterErrorState(e));
  //     print(e);
  //   }
  // }
}
