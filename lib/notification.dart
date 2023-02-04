import 'package:carservices/home/cubit/cubit.dart';
import 'package:carservices/home/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).getNotifications();
    Jiffy.locale("ar");
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: state is GetNotificationLoadingState
                  ? const Center(child: CircularProgressIndicator())
                  : AppCubit.get(context).orders.isEmpty
                      ? const Center(child: Text("لا يوجد اشعارات",style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),))
                      : ListView.separated(
                          itemBuilder: (context, index) => Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(
                                    "assets/images/car-services.png"),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.shade200,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${AppCubit.get(context).ordersIds[index]} #",
                                      style: TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      AppCubit.get(context).orders[index]
                                          ["status"],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      Jiffy(AppCubit.get(context)
                                              .orders[index]["createdAt"]
                                              .toString())
                                          .fromNow(),
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                          itemCount: AppCubit.get(context).orders.length,
                        ),
            ),
          );
        },
      ),
    );
  }
}
