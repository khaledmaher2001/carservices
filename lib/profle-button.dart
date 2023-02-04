import 'package:flutter/material.dart';

// Widget ProfileButton(context,{
//   required String text,
//   required IconData firstIcon,
//   required IconData secondtIcon,
// }){
//   var height = MediaQuery.of(context).size.height;
//   var width = MediaQuery.of(context).size.width;
//   return ;
// }

class ProfileButton extends StatelessWidget {

  String text;
  IconData firstIcon;
  IconData secondtIcon;
   ProfileButton(
      this.text,
      this.secondtIcon,
      this.firstIcon, {Key? key}
      ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(width * .12),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(.7),
              blurRadius: 4,
              offset: const Offset(1, 2),
            ),
          ],
        ),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          onPressed: () async {},
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: height * .015),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      firstIcon,
                      size: width * .06,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: width * .05,
                    ),
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: width * .04,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Icon(
                  secondtIcon,
                  size: width * .06,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
