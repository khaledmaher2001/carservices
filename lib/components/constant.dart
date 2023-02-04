import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import '../../models/section_data.dart';
import '../../models/user_data.dart';

int pageNum=0;
List data=[] ;
List data3=[] ;
List data4=[] ;
List data8=[] ;
List answers=[] ;
var emailController = TextEditingController();
var otherController = TextEditingController();
var phoneController = TextEditingController();
var phoneConstController = TextEditingController();
var socialController = TextEditingController();
var notesController = TextEditingController();
var selectedValue;
bool plan=false;
bool sucQuestioniar=false;
bool isSelected1 = false;
bool isSelected2 = false;
bool isSelected3 = false;

bool hasInternet=true;
String?imageUrl;
File? singleImage;
String? userName;
bool AdminLogin=false;
int reportIndex=0;
String? userId;
const appBgColor = Color(0xFF000000);
const primary = Colors.black;
const secondary =  Color(0xff1bbd9d);
const white =  Color(0xFFFFFFFF);
const black =  Color(0xFF000000);
const double defaultBorderRadius = 12.0;
UserData? userData;
bool active=false;
int fromPage=0;
bool upOrup=false;
bool alarmNow=false;
String? userPlan;

String? adminLocationDescription;
String? adminImageDescription;
String? adminFinalUrl;
String? userNameForAdmin;
String? finalUrl;
String? imageDescription;
String? imageName;
// double lat=0.0;
bool denied=false;
// double lon=0.0;
// String? location;
// double? temp;
int qIndex=0;
int sIndex=0;
Map<String, bool> multiCheckVal = {};
Map<String, Color> colorListMC = {};
List holder_1 = [];
List userQuestionAnswers=[];
List userQuestionAnswersMc=[];
List<String> taps1 = [
  "القسم الاول",
  "القسم الثاني",
  "القسم الثالث",
  "القسم الرابع"
];
int serviceIndex=0;
String title="";
Widget page=Container();
