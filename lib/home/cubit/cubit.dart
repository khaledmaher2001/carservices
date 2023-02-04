import 'package:carservices/components/constant.dart';
import 'package:carservices/home/cubit/states.dart';
import 'package:carservices/login/cuibt/states.dart';
import 'package:carservices/models/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitState());

  static AppCubit get(context) => BlocProvider.of(context);

  createOrder(BuildContext context,{required List<String> services}) async {
    emit(CreateOrderLoadingState());
    await FirebaseFirestore.instance.collection("orders").doc().set({
      "name": CacheHelper.getData(key: "userName"),
      "services": services,
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Your Order Placed"),backgroundColor: Colors.green,));
      emit(CreateOrderSuccessState());
    }).catchError((error) {
      print(error);
      emit(CreateOrderErrorState());
    });
  }
}
