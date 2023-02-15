import 'package:appbirthdaycake/Login/login_page.dart';
import 'package:appbirthdaycake/Register/register.dart';
import 'package:appbirthdaycake/custumer/HomeScreen/cake_design.dart';
import 'package:appbirthdaycake/custumer/HomeScreen/homepage.dart';
import 'package:appbirthdaycake/custumer/HomeScreen/logout.dart';
import 'package:appbirthdaycake/custumer/HomeScreen/profile.dart';
import 'package:appbirthdaycake/custumer/cakepage/cake_detail.dart';
import 'package:appbirthdaycake/custumer/cakepage/cake_page.dart';
import 'package:appbirthdaycake/custumer/shopping/cart_body.dart';
import 'package:appbirthdaycake/shop_owner/home/homescreen.dart';
import 'package:appbirthdaycake/shop_owner/so_cake/so_cakepage.dart';
import 'package:flutter/cupertino.dart';

class AppRoute{
  static const LoginRoute = "Login";
  static const RegisterRoute = "Register";
  static const HomeRoute = "HomePage";
  static const TypeCakeRoute = "TypeCakePage";
  static const CakeRoute = "CakePage";
  static const CakeDetailRoute = "CakeDetail";
  static const CakeDesignRoute = "CakeDesign";
  static const SOCakeRoute = "SOCake";
  static const HomeShopOwnerRoute = "HomeOS";
  static const ProfileRoute = "Profile";
  static const LogoutRoute = "Logout";
  static const CartRoute = "Cart";

  final _route = <String, WidgetBuilder>{
    LoginRoute : (context) => LoginPage(),
    RegisterRoute : (context) => RegisterPage(),
    HomeRoute : (context) => HomePage(),
    CakeRoute : (context) => CakePage(),
    CakeDetailRoute : (context) => CakeDetail(),
    CakeDesignRoute : (context) => CakeDesign(),
    SOCakeRoute : (context) => SOCakePage(),
    HomeShopOwnerRoute : (context) => HomeShopOwner(),
    ProfileRoute : (context) => AccountPage(),
    CartRoute : (context) => CartBody(),



  };
  get getAll => _route;
}