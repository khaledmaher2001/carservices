import 'package:carservices/notification.dart';
import 'package:carservices/profile-item.dart';
import 'package:carservices/services-screen.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

import 'constants.dart';
import 'home/cubit/cubit.dart';

class BodyContent extends StatelessWidget {
  BodyContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    switch (selectedIndexBodyContent) {
      case 0:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ServicesScreen()));
                },
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: CircleAvatar(
                            radius: (MediaQuery.of(context).size.width * .2),
                            backgroundColor: Colors.grey.withOpacity(.6),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Image.asset(
                                "assets/images/car-services.png",
                                fit: BoxFit.contain,
                                width: MediaQuery.of(context).size.width * .35,
                              ),
                            ))),
                    const Text(
                      "خدمات الصيانة",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () async {
                  await AppCubit.get(context).getLocation();
                  await AppCubit.get(context).createOrder(context,
                      services: ["ونش انقاذ"],
                      lat: AppCubit.get(context).locationData!.latitude!,
                      long: AppCubit.get(context).locationData!.longitude!);
                },
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: CircleAvatar(
                            radius: (MediaQuery.of(context).size.width * .2),
                            backgroundColor: Colors.grey.withOpacity(.6),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Image.asset(
                                "assets/images/winch.png",
                                fit: BoxFit.contain,
                                width: MediaQuery.of(context).size.width * .35,
                              ),
                            ))),
                    const Text(
                      "ونش انقاذ",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
              // GestureDetector(
              //   onTap: (){
              //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ServicesScreen()));
              //   },
              //   child: Center(
              //     child: Container(
              //       width: MediaQuery.of(context).size.width*.9,
              //       decoration:  BoxDecoration(
              //         color: Colors.black.withOpacity(.6),
              //         borderRadius: BorderRadius.circular(30),
              //
              //       ),
              //       child: Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Column(
              //           children: [
              //             Image.asset("assets/images/logo.png",width: MediaQuery.of(context).size.width/2,height: MediaQuery.of(context).size.height/5,),
              //             const SizedBox(
              //               height: 10,
              //             ),
              //             const Text("خدمات صيانة السيارة",style: TextStyle(
              //                 fontSize: 20,
              //                 fontWeight: FontWeight.bold,
              //                 color: Colors.white
              //             ),),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 30,
              // ),
              // GestureDetector(
              //   onTap: (){
              //   },
              //   child: Center(
              //     child: Container(
              //       width: MediaQuery.of(context).size.width*.9,
              //       decoration:  BoxDecoration(
              //         color: Colors.red.withOpacity(.7),
              //         borderRadius: BorderRadius.circular(30),
              //
              //       ),
              //       child: Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Column(
              //           children: [
              //             Image.asset("assets/images/wnsh.png",width: MediaQuery.of(context).size.width/2,height: MediaQuery.of(context).size.height/5,),
              //             const SizedBox(
              //               height: 10,
              //             ),
              //             const Text("طلب ونش انقاذ",style: TextStyle(
              //                 fontSize: 20,
              //                 fontWeight: FontWeight.bold,
              //                 color: Colors.white
              //             ),),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        );
      case 1:
        return const Profile();
      case 2:
        return const NotificationScreen();
      default:
        return const SizedBox();
    }
  }
}
