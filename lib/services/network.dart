import 'dart:convert';
import 'package:appbirthdaycake/config/api.dart';
import 'package:appbirthdaycake/custumer/model/Cake_size_model.dart';
import 'package:appbirthdaycake/custumer/model/cake_n_model.dart';
import 'package:appbirthdaycake/custumer/model/order_model.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;


class NetworkService {
  NetworkService._internal();

  static final NetworkService _instace = NetworkService._internal();

  factory NetworkService() => _instace;

  static final Dio _dio = Dio();

  //Login
  Future<String> validateUserLoginDio(String username, String password) async {
    FormData data = FormData.fromMap({
      'username': username,
      'password': password,
    });
    try {
      //var url = API.BASE_URL + '/flutterapp/f_user_login.php';
      //var url = API.BASE_URL + '/api/user';
      var url = API.BASE_URL + '/flutterapi/api/user';
      final response = await _dio.post(url, data: data);
      if (response.statusCode == 200) {
        var jsonString = response.data;
        // var jsonMap = json.encode(jsonString);
        String username = jsonString["username"];
        print('username = ' + username);
        String password = jsonString["password"];
        print('password = ' + password);
        if (username != 'failed') {
          return 'pass';
        } else {
          return 'failed';
        }
      } else {
        return 'failed';
      }
    } catch (Exception) {
      throw Exception('Network failed');
    }
  }

  //Cake
   Future<CakeNModel> getAllCakeNDio() async {
    var url = API.BASE_URL + API.CAKE_N;
    print('url getAllCakeGeneralDio() = ' + url);
    final response = await _dio.get(url);
    if (response.statusCode == 200) {
      print(response.data);
      return cakeNModelFromJson(json.encode(response.data));
    }
    throw Exception('Network failed');
  }

  Future<List<CakeSize>> getAllCakeSizeDio() async {
    var url = API.BASE_URL + API.CAKE_SIZE;
    print('url getAllCakeSizeDio() = ' + url);
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print(response.body);
      var jsonData = json.decode(response.body)['cake_size']; // แก้ไขตรงนี้เพื่อรับข้อมูล JSON ในรูปแบบที่ถูกต้อง
      return CakeSize.fromJsonList(jsonData);
    }
    throw Exception('Network failed');
  }

  Future<OrderModel> getAllOrderDio() async {
    var url = API.BASE_URL + API.Order;
    print('url getAllOrderDio() = ' + url);
    final response = await _dio.get(url);
    if (response.statusCode == 200) {
      final jsonData = response.data as Map<String, dynamic>;
      return OrderModel.fromJson(jsonData);
    }
    throw Exception('Network failed');
  }



}