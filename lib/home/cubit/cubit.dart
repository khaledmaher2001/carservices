import 'package:carservices/components/constant.dart';
import 'package:carservices/home/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import '../../../shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitState());

  static AppCubit get(context) => BlocProvider.of(context);
  Location location = Location();

  bool? serviceEnabled;
  PermissionStatus? permissionGranted;
  LocationData? locationData;

  createOrder(BuildContext context,
      {required List<String> services,
      required double lat,
      required double long}) async {
    emit(CreateOrderLoadingState());
    await FirebaseFirestore.instance.collection("orders").doc().set({
      "name": CacheHelper.getData(key: "userName"),
      "userId": userId,
      "services": services,
      "lat": lat,
      "long": long,
      "status": "طلبك قيد التنفيذ",
      "createdAt": DateTime.now().toString(),
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("تم حجز الطلب"),
        backgroundColor: Colors.green,
      ));
      emit(CreateOrderSuccessState());
    }).catchError((error) {
      print(error);
      emit(CreateOrderErrorState());
    });
  }

  List orders = [];
  List allOrders = [];
  List ordersIds = [];
  List allOrdersIds = [];

  getNotifications() {
    emit(GetNotificationLoadingState());
    orders.clear();
    ordersIds.clear();
    FirebaseFirestore.instance
        .collection("orders")
        .where("userId", isEqualTo: userId)
        .get()
        .then((value) {
      for (var element in value.docs) {
        orders.add(element.data());
        ordersIds.add(element.id);
      }
      print(orders);
      emit(GetNotificationSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetNotificationErrorState());
    });
  }

  getAllOrders() {
    emit(GetAllOrdersLoadingState());
    FirebaseFirestore.instance
        .collection("orders")
        .orderBy("createdAt", descending: true)
        .get()
        .then((value) {
      allOrders.clear();
      allOrdersIds.clear();
      for (var element in value.docs) {
        allOrders.add(element.data());
        allOrdersIds.add(element.id);
      }
      print(allOrders);
      emit(GetAllOrdersSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetAllOrdersErrorState());
    });
  }

  updateOrder({required String docId, required String status}) {
    emit(UpdateOrderLoadingState());
    FirebaseFirestore.instance.collection("orders").doc(docId).update({
      "status": status,
    }).then((value) {
      getAllOrders();
      emit(UpdateOrderSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(UpdateOrderErrorState());
    });
  }

  getLocation() async {
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled!) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled!) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    locationData = await location.getLocation();
  }
}
