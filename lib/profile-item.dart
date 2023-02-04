import 'package:carservices/profle-button.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const SizedBox(height: 50,),
                  CircleAvatar(
                    radius: 64,
                    backgroundColor: Colors.grey.withOpacity(.6),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/person.png',
                        width: 350,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("الاسم",style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("وصف عنك او السيرة الذاتية",style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ProfileButton('الخصوصية',Icons.arrow_forward_ios,Icons.privacy_tip_outlined, ),
                    const SizedBox(height:20),
                    ProfileButton('التاريخ',Icons.arrow_forward_ios,Icons.history,),
                    const SizedBox(height:20),
                    ProfileButton('المساعدة والدعم',Icons.arrow_forward_ios,Icons.help_outline,),
                    const SizedBox(height:20),
                    ProfileButton("الاعدادات",Icons.arrow_forward_ios,Icons.settings_sharp),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
