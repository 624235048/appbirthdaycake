import 'package:appbirthdaycake/Login/login_page.dart';
import 'package:appbirthdaycake/config/approute.dart';
import 'package:appbirthdaycake/custumer/HomeScreen/homepage.dart';
import 'package:appbirthdaycake/shop_owner/home/homescreen.dart';
import 'package:appbirthdaycake/shop_owner/signature/signature_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:appbirthdaycake/config/appsetting.dart';

import 'config/api.dart';
import 'custumer/shopping/shopcart.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: AppRoute().getAll,
      theme: ThemeData(primaryColor: Colors.pink.shade100),
      home:
      //HomeShopOwner()
      //ShopcartPage()
     // SignaturePage()
      FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(color: Colors.white);
          }
          final preferences = snapshot.data;
          final token = preferences.getString(AppSetting.userNameSetting ?? '');
          final chooseType = preferences.getString(API().keyType ?? '');

          if (token != null) {
            if (chooseType == 'Customer') {
              return HomePage();
            } else if (chooseType == 'ShopOwner') {
              return HomeShopOwner();
            } else {
              print('Invalid chooseType');
            }
          }
          return LoginPage();
        },
      ),
    );
  }
}
