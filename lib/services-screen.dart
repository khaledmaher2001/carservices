import 'package:carservices/home/cubit/cubit.dart';
import 'package:carservices/home/cubit/states.dart';
import 'package:carservices/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServicesScreen extends StatefulWidget {
  ServicesScreen({Key? key}) : super(key: key);

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  List<bool> colorsRange = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<String> choicesServices = [];
  List<Choice> choices = const <Choice>[
    Choice(title: 'Battery', icon: "assets/images/battery.png"),
    Choice(title: 'Diagnosis', icon: "assets/images/diagnosis.png"),
    Choice(title: 'Engine', icon: "assets/images/engine.png"),
    Choice(title: 'Key', icon: "assets/images/key.png"),
    Choice(title: 'Mechanic', icon: "assets/images/mechanic.png"),
    Choice(title: 'Oil', icon: "assets/images/oil.png"),
    Choice(title: 'Pressure', icon: "assets/images/pressure.png"),
    Choice(title: 'Tire', icon: "assets/images/tire.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
            child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Car Services",
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/banner.png",
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(
                    height: 2,
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 8.0,
                    children: List.generate(choices.length, (index) {
                      return Center(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              colorsRange[index] = !colorsRange[index];
                              if (colorsRange[index] == true) {
                                choicesServices.add(choices[index].title);
                              } else {
                                choicesServices.remove(choices[index].title);
                              }
                              print(choicesServices);
                            });
                          },
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: colorsRange[index]
                                  ? const Color(0xff334758)
                                  : Colors.grey[300],
                              child: Center(
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Image.asset(
                                              choices[index].icon,
                                              width: 32,
                                              color: Colors.grey),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                choices[index].title,
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                height: 30,
                                                width: 1,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ]),
                              )),
                        ),
                      );
                    }),
                  ),
                ),
                state is CreateOrderLoadingState
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () async {
                          if (choicesServices.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("لم يتم اختيار خدمة"),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else {
                            await AppCubit.get(context).getLocation();
                            await AppCubit.get(context).createOrder(context,
                                services: choicesServices,
                                lat: AppCubit.get(context)
                                    .locationData!
                                    .latitude!,
                                long: AppCubit.get(context)
                                    .locationData!
                                    .longitude!);
                            choicesServices.clear();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainHomeScreen()));
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          child: Text(
                            "حجــز",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        )),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ));
      },
    );
  }
}

class Choice {
  const Choice({required this.title, required this.icon});

  final String title;
  final String icon;
}
