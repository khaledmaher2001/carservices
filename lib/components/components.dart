import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'constant.dart';

class UploadIcon extends StatelessWidget {
  const UploadIcon() : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 35,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            child: Container(
              width: 40,
              height: 35,
              decoration: BoxDecoration(
                  color: secondary,
                  borderRadius: BorderRadius.circular(8)
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: Container(
              width: 40,
              height: 35,
              decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(8)
              ),
            ),
          ),
          Positioned(
            right: 5,
            child: Container(
              width: 40,
              height: 35,
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(8)
              ),
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
    );
  }
}
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword = false,
  required String? Function(String? val)? validate,
  required String label,
  required BuildContext context,
  final void Function()? ontap,
  required IconData prefix,
  IconData? suffix,
  String? suffixText,
  final void Function()? suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      validator: validate,
      obscureText: isPassword,
      onTap: ontap,
      decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(prefix),
          suffixText: suffixText,
          suffixStyle: const TextStyle(color: Colors.grey),
          suffixIcon: IconButton(
            onPressed: suffixPressed,
            icon: Icon(suffix),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width*.025),
          )),
    );
Future showExitPopup({
  context,
  required String title,
  required String content,
  required String buttonText1,
  required String buttonText2,
  final void Function()? onPress,
  // required Function onButton1,
})  async{
  return await showDialog(
    context: context,
    builder: (context) => Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        title:  Text(title),
        content:  Text(content,style: const TextStyle(
          fontSize: 15,
        ),),
        actions:[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: onPress,
                child: Text(buttonText1),
              ),
              const SizedBox(width: 12,),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(buttonText2),
              ),
            ],
          )
        ],
      ),
    ),
  )??false; //if showDialouge had returned null, then return false
}
Widget noConnection({
  required Function onPress,
  required bool load,
  required context,
}) =>
    Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/noconnection.png',
              color: Colors.grey,
              width: MediaQuery.of(context).size.width * 0.5,
            ),
            const Text(
              "No Internet Connection",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            load
                ? const CircularProgressIndicator(
              color: Colors.grey,
            )
                : Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.wifi_protected_setup_outlined,
                      color: Color(0xff1bbd9d),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Reload',
                      style: TextStyle(
                        color: Color(0xff1bbd9d),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                onPressed: () async {
                  var connectivityResult =
                  await (Connectivity().checkConnectivity());
                  if (connectivityResult != ConnectivityResult.none) {
                    onPress();
                  }else{
                    Fluttertoast.showToast(
                      msg: "No Internet Connection",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.transparent,
                      textColor: const Color(0xff1bbd9d),
                    );
                  }
                },
              ),
            ),
          ],
        ));
Widget buildItem({
  required String title,
  required String planTitle,
  required String description,
  required  function,
  required bool x,
  required Color color,
})=>GestureDetector(
  onTap:(){
    function;
  },
  child: Container(
    padding: const EdgeInsets.all(20),
    margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
    width: double.infinity,
    decoration: BoxDecoration(
      color:color,
      borderRadius: BorderRadius.circular(20),
    ),
    child:Stack (
      children: [
        x ? const Icon(Icons.check_circle_outline,color: Colors.green,):const SizedBox(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold

            ),),
            const SizedBox(height: 20,),
            Text(planTitle,style: const TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold


            ),),
            const SizedBox(height: 20,),

            Align(
              alignment: Alignment.topRight,
              child: Column(
                children: [
                  Text(description,style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold


                  ),),

                ],
              ),
            )


          ],
        ),
      ],
    ),
  ),
);