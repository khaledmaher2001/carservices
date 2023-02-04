import 'package:carservices/home/cubit/cubit.dart';
import 'package:carservices/home/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  void initState() {
    super.initState();
    // AppCubit.get(context).allOrders.clear();
    // AppCubit.get(context).allOrdersIds.clear();
    AppCubit.get(context).getAllOrders();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.white,
              centerTitle: true,
              title: Text("الادمن"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: state is GetAllOrdersLoadingState
                  ? const Center(child: CircularProgressIndicator())
                  : cubit.allOrders.isEmpty?Center(
                    child: Text("لا يوجد طلبات",style: TextStyle(
                fontSize: 20,

              ),),
                  ):ListView.separated(
                      itemBuilder: (context, index) {
                        return  Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.shade200,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cubit.allOrders[index]["name"],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Column(
                                  children: List.generate(
                                    cubit.allOrders[index]["services"].length,
                                        (i) => Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 4,
                                          backgroundColor: Colors.black,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          cubit.allOrders[index]["services"][i]
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              cubit.allOrders[index]["status"]=="طلبك قيد التنفيذ"? Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        cubit.updateOrder(
                                            docId: cubit.allOrdersIds[index],
                                            status: "انتظر الفنى فى طريقة لك");
                                      },
                                      child: Text(
                                        "قبول",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        cubit.updateOrder(
                                            docId: cubit.allOrdersIds[index],
                                            status: "تم رفض الطلب");

                                      },
                                      child: Text(
                                        "رفض",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                          )),
                                    ),
                                  )
                                ],
                              ):Center(
                                child: Text(cubit.allOrders[index]["status"]=="تم رفض الطلب"?"تم رفض هذا الطلب":"تم قبول هذا الطلب",style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),),
                              ),
                            ],
                          ),
                        );
                      },


                      separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                      itemCount: cubit.allOrders.length,
                    ),
            ),
          );
        },
      ),
    );
  }
}
