import 'package:appbirthdaycake/config/approute.dart';
import 'package:appbirthdaycake/custumer/model/cake_n_model.dart';
import 'package:appbirthdaycake/custumer/model/cart_model.dart';
import 'package:appbirthdaycake/widgets/dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:appbirthdaycake/helper/sqlite.dart';

import '../../style.dart';

class CartBody extends StatefulWidget {
  @override
  State<CartBody> createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  List<CartModel> cartModels = [];
  List<List<String>> listgasids = [];
  List<int> listamounts = [];
  CakeNModel cakens;
  int total = 0;
  int quantityInt = 0;
  bool status = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readSQLite();
  }

  Future<Null> readSQLite() async {
    var object = await SQLiteHlper().readAllDataFormSQLite();
    print('object length ==> ${object.length}');
    if (object.length != 0) {
      for (var model in object) {
        String sumString = model.sum;
        int sumInt = int.parse(sumString);
        setState(() {
          status = false;
          cartModels = object;
          total = total + sumInt;

          // gas_id = model.gas_id;
          // amount = model.amount;
        });
      }
    } else {
      setState(() {
        status = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   title: Text(
      //     'Cart',
      //     style: TextStyle(color: Colors.pink[200]),
      //   ),
      //   elevation: 0,
      // ),
      body: status
          ? Center(
              child: Container(
                height: 100,
                width: 100,
                child: Image.asset('assets/images/cart1.png'),
              ),
            )
          : buildcontents(),
    );
  }

  Widget buildcontents() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildmaintitleshop(),
            const Divider(
              color: Colors.black26,
              height: 30,
              thickness: 5,
            ),
            buildheadtitle(),
            buildlistWater(),
            const Divider(
              //height: 50,
              thickness: 10,
            ),
            buildTotal(),
            Style().mySizebox(),
            buildAddOrderButton(),
            buildPaymentButton(),
          ],
        ),
      ),
    );
  }

  Future<Null> orderThread() async {
    DateTime dateTime = DateTime.now();
    // print(dateTime.toString());
    String order_date_time = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
    List<String> cake_ids = [];
    List<String> imgcakes = [];
    List<String> texts = [];
    List<String> sizes = [];
    List<String> prices = [];
    List<String> amounts = [];
    List<String> sums = [];

    for (var model in cartModels) {
      cake_ids.add(model.cake_id);
      imgcakes.add(model.cake_img);
      texts.add(model.cake_text);
      prices.add(model.price);
      sizes.add(model.cake_size);
      amounts.add(model.amount);
      sums.add(model.sum);
    }
    String cake_id = cake_ids.toString();
    String imgcake = imgcakes.toString();
    String text = texts.toString();
    String price = prices.toString();
    String size = sizes.toString();
    String amount = amounts.toString();
    String sum = sums.toString();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String user_id = preferences.getString('id');
    String user_name = preferences.getString('Name');
    print(
        'orderDateTime == $order_date_time ,user_id ==> $user_id,user_name ==> $user_name ');
    print(
        'cake_id ==> $cake_ids,imgcake ==>$imgcake,text ==> $Text,size ==> $size, price ==> $price , amount ==> $amount , sum ==> $sum');

    String url =
        'http://192.168.1.34:8080/flutterapi/addOrder.php?isAdd=true&order_date_time=$order_date_time&user_id=$user_id&user_name=$user_name&cake_id=$cake_id&imgcake=$imgcake&text=$text&size=$size&price=$price&amount=$amount&sum=$sum&payment_status=payondelivery&status=userorder';

    await Dio().get(url).then((value) {
      if (value.toString() == 'true') {
        // updateQtyGas(amount, gas_id);
        clearOrderSQLite();

        //notificationtoShop(user_name);
      } else {
        normalDialog(context, 'ไม่สามารถสั่งซื้อได้กรุณาลองใหม่');
      }
    });
  }

  Widget buildTotal() => Row(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Style().showTitleH2('Total = '),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Style().showTitleHC('${total.toString()} THB'),
          ),
        ],
      );

  Widget buildmaintitleshop() {
    return Container(
      margin: EdgeInsets.only(top: 16, bottom: 16, left: 16),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              Style().showTitle('Shoppingcart',),
            ],
          ),
          //Style().mySizebox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //Style()
              //.showTitleH3('ระยะทาง : ${cartModels[0].distance} กิโลเมตร'),
              // Style().showTitleH3('ค่าจัดส่ง : ${cartModels[0].transport} บาท'),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     MyStyle().showTitleH3('ค่าจัดส่ง ${cartModels[0].transport}'),
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget buildheadtitle() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Style().showTitleH2('จำนวน'),
          ),
          Expanded(
            flex: 1,
            child: Style().showTitleH2('ขนาด'),
          ),
          Expanded(
            flex: 1,
            child: Style().showTitleH2('ข้อความ'),
          ),
          Expanded(
            flex: 1,
            child: Style().showTitleH2('รวม'),
          ),
        ],
      ),
    );
  }

  Widget buildPaymentButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 10, right: 10),
          width: 160,
          child: RaisedButton.icon(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            color: Colors.blueAccent,
            onPressed: () {
              // MaterialPageRoute route = MaterialPageRoute(
              //   builder: (context) => null,
              // );
              //Navigator.pushNamed(context, AppRoute.confirmpayment).then((value) => readSQLite());
            },
            label: Text(
              'ชำระเงินล่วงหน้า',
              style: TextStyle(color: Colors.white),
            ),
            icon: Icon(
              Icons.add_shopping_cart_sharp,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildAddOrderButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 10, right: 10),
          width: 160,
          child: RaisedButton.icon(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.indigoAccent,
            onPressed: () {
              orderThread();
            },
            label: Text(
              'สั่งซื้อปลายทาง',
              style: TextStyle(color: Colors.white),
            ),
            icon: Icon(
              Icons.add_shopping_cart_sharp,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Future<Null> clearOrderSQLite() async {
    await SQLiteHlper().deleteAllData().then(
      (value) {
        normalDialog2(
            context, "สั่งซื้อสำเร็จ", "รอรับสินค้าตรวจสอบการสั่งซื้อ");
        readSQLite();
      },
    );
  }

  Widget buildlistWater() => ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: cartModels.length,
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 10, bottom: 20),
            padding: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    '${cartModels[index].amount}x',
                    style: Style().mainhATitle,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    cartModels[index].cake_id,
                    style: Style().mainh23Title,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'ฺ  ',
                    style: Style().mainh23Title,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    ' ${cartModels[index].sum}ฺ THB',
                    style: Style().mainh23Title,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    color: Colors.red,
                    icon: Icon(Icons.delete_forever),
                    onPressed: () async {
                      int id = cartModels[index].id;
                      print('You Click delete id = $id');
                      await SQLiteHlper().deleteDataWhereId(id).then(
                        (value) {
                          print('delete Success id =$id');
                          readSQLite();
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          );
        },
      );
}
