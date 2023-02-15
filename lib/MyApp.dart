import 'package:appbirthdaycake/Login/login_page.dart';
import 'package:appbirthdaycake/config/approute.dart';
import 'package:appbirthdaycake/custumer/HomeScreen/homepage.dart';
import 'package:appbirthdaycake/shop_owner/home/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:appbirthdaycake/config/appsetting.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: AppRoute().getAll,
      theme: ThemeData(primaryColor: Colors.white),
      home:
      //HomeShopOwner()
      FutureBuilder(
          future: SharedPreferences.getInstance(),
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Container(color: Colors.white,);
            }
            final token = snapshot.data.getString(AppSetting.userNameSetting ?? '');
            if(token != null ){
              return HomePage();
            }
            return LoginPage();
          }
      ),
    );
  }
}
