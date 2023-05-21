import 'package:appbirthdaycake/custumer/HomeScreen/accountwidget.dart';
import 'package:appbirthdaycake/custumer/HomeScreen/app_icon.dart';
import 'package:appbirthdaycake/custumer/HomeScreen/big_text.dart';
import 'package:appbirthdaycake/custumer/HomeScreen/logout.dart';
import 'package:appbirthdaycake/custumer/model/user_model.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  List<CUsertable> cUsertable = [];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: 10),
        child: Column(
          // profile Icons
          children: [
            SizedBox(height: 80,),
            AppIcon(
              icon: Icons.person,
              backgroundColor: Colors.pinkAccent[100],
              iconColor: Colors.white,
              iconSize: 80,
              size: 150,
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //name
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.person,
                          backgroundColor: Colors.blueAccent,
                          iconColor: Colors.white,
                          iconSize: 25,
                          size: 50,
                        ),
                        bigText: BigText(
                          text: "Three",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //phone
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.phone,
                          backgroundColor: Colors.amber,
                          iconColor: Colors.white,
                          iconSize: 25,
                          size: 50,
                        ),
                        bigText: BigText(
                          text: "+66 987258674",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    //email
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.email,
                          backgroundColor: Colors.amber,
                          iconColor: Colors.white,
                          iconSize: 25,
                          size: 50,
                        ),
                        bigText: BigText(
                          text: "warin@gamil.com",
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    //address
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.location_on,
                          backgroundColor: Colors.amber,
                          iconColor: Colors.white,
                          iconSize: 25,
                          size: 50,
                        ),
                        bigText: BigText(
                          text: "Fill in your address",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    //message
                    GestureDetector(
                      onTap: (){
                        signOutProcess(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: AccountWidget(
                          appIcon: AppIcon(
                            icon: Icons.logout,
                            backgroundColor: Colors.redAccent,
                            iconColor: Colors.white,
                            iconSize: 25,
                            size: 50,
                          ),
                          bigText: BigText(
                            text: "Log out",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}