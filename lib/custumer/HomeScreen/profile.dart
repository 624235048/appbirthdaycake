import 'dart:convert';

import 'package:appbirthdaycake/config/api.dart';
import 'package:appbirthdaycake/custumer/HomeScreen/accountwidget.dart';
import 'package:appbirthdaycake/custumer/HomeScreen/app_icon.dart';
import 'package:appbirthdaycake/custumer/HomeScreen/big_text.dart';
import 'package:appbirthdaycake/custumer/HomeScreen/logout.dart';

import 'package:appbirthdaycake/style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/usermodel.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  CUsertable model;
  String name, phone, address;
  @override
  void initState() {
    super.initState();
    readDataUser();
  }

  Future<Null> readDataUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String user_id = preferences.getString('id');
    String url =
        '${API.BASE_URL}/flutterapi/src/getuserwhereid.php?isAdd=true&id=$user_id';

    await Dio().get(url).then((value) {
      if (value.toString() != 'null') {
        var result = json.decode(value.data);

        for (var map in result) {
          setState(() {
            model = CUsertable.fromJson(map);
            name = model.name;
            phone = model.phone;
            address = model.address;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: model != null
          ? Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  // profile Icons
                  children: [
                    SizedBox(height: 80,),
                    AppIcon(
                      icon: Icons.person,
                      backgroundColor: Colors.blueAccent,
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
                            AccountWidget(
                              appIcon: AppIcon(
                                icon: Icons.person,
                                backgroundColor: Colors.blueAccent,
                                iconColor: Colors.white,
                                iconSize: 25,
                                size: 50,
                              ),
                              bigText: BigText(
                                text: name,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //phone
                            AccountWidget(
                              appIcon: AppIcon(
                                icon: Icons.phone,
                                backgroundColor: Colors.amber,
                                iconColor: Colors.white,
                                iconSize: 25,
                                size: 50,
                              ),
                              bigText: BigText(
                                text: phone,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            //email

                            //address
                            GestureDetector(
                              onTap: () {
                                MaterialPageRoute route = MaterialPageRoute(
                                    // builder: (context) => EditAccount(
                                    //     userModel: model )
                                    );
                                Navigator.push(context, route).then(
                                  (value) => readDataUser(),
                                );
                              },
                              child: AccountWidget(
                                appIcon: AppIcon(
                                  icon: Icons.location_on,
                                  backgroundColor: Colors.amber,
                                  iconColor: Colors.white,
                                  iconSize: 25,
                                  size: 50,
                                ),
                                bigText: BigText(
                                  text: address.length >= 20 ? "...." : address,
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
                              child: AccountWidget(
                                appIcon: AppIcon(
                                  icon: Icons.settings,
                                  backgroundColor: Colors.redAccent,
                                  iconColor: Colors.white,
                                  iconSize: 25,
                                  size: 50,
                                ),
                                bigText: BigText(
                                  text: "Logout",
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
          )
          : Style().showProgress(),
    );
  }
}
