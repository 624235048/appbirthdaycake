import 'package:appbirthdaycake/config/api.dart';
import 'package:appbirthdaycake/config/approute.dart';
import 'package:appbirthdaycake/custumer/model/Cake_size_model.dart';
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
  List<CakeSize> cakesikeModels = [];
  List<CartModel> cartModels = [];
  List<List<String>> listgasids = [];
  List<int> listamounts = [];
  CakeNModel cakens;
  int total = 0;
  int quantityInt = 0;
  bool status = true;

  @override
  void initState() {
    super.initState();
    readSQLite();
  }
  Future<Null> readSQLite() async {
    var object = await SQLiteHlper().readAllDataFormSQLite();
    print('object length ==> ${object.length}');
    int newTotal = 0; // สร้างตัวแปรใหม่เพื่อเก็บค่า total ที่ถูกคำนวณใหม่
    if (object.length != 0) {
      for (var model in object) {
        String sumString = model.sum;
        int sumInt = int.parse(sumString);
        newTotal += sumInt; // เพิ่มราคาสินค้าลงในตัวแปร newTotal
      }
    }
    setState(() {
      status = object.isEmpty; // ถ้า object ว่างเปล่าก็ให้ status เป็น true
      cartModels = object;
      total = newTotal; // กำหนดค่า total ให้เท่ากับ newTotal
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.pink[100],
          ),
          onPressed: () {
            Navigator.pushNamed(context, AppRoute.HomeRoute);
          },
        ),
      ),
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
              color: Colors.pinkAccent,
              height: 30,
              thickness: 5,
            ),
            buildheadtitle(),
            buildlistCake(),
            const Divider(
              //height: 50,
              color: Colors.pinkAccent,
              thickness: 5,
            ),
            SizedBox(
              height: 10,
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
    String distance = cartModels[0].distance;
    String transport = cartModels[0].transport;
    String pickupDate = cartModels[0].cake_date;
    String imgcakes = cartModels[0].cake_img;
    List<String> cake_ids = [];
    List<String> sizes = [];
    List<String> texts = [];
    List<String> prices = [];
    List<String> amounts = [];
    List<String> sums = [];

    for (var model in cartModels) {
      texts.add(model.cake_text);
      cake_ids.add(model.cake_id);
      prices.add(model.price);
      sizes.add(model.cake_size);
      amounts.add(model.amount);
      sums.add(model.sum);

    }

    String cake_id = cake_ids.toString();
    String price = prices.toString();
    String size = sizes.toString();
    String amount = amounts.toString();
    String count = sums.toString();
    String text = texts.toString();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String user_id = preferences.getString('id');
    String user_name = preferences.getString('name');

    String url =
        '${API.BASE_URL}/flutterapi/src/addOrder.php?isAdd=true&order_date_time=$order_date_time&user_id=$user_id&user_name=$user_name&distance=$distance&transport=$transport&cake_id=$cake_id&imgcake=$imgcakes&text=$text&size=$size&price=$price&amount=$amount&sum=$count&pickup_date=$pickupDate&payment_status=userorder&status=ชำระเงินปลายทาง';

    await Dio().get(url).then((value) {
      if (value.toString() == 'true') {
        //updateQtyGas(amount, gas_id);
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
          Row(
            children: [
              Style().showTitle('Shoppingcart'),
            ],
          ),
          Style().mySizebox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
               Style().showTitleH3('วันที่นัดรับ : ${cartModels[0].cake_date} '),
            ],
          ),
           // Row(
           //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           //   children: [
           //     MyStyle().showTitleH3('ค่าจัดส่ง ${cartModels[0].transport}'),
           //   ],
           // ),
        ],
      ),
    );
  }

  Widget buildheadtitle() {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Style().showTitleH2('จำนวน'),
              ),
              Expanded(
                //flex: 1,
                child: Style().showTitleH2('ขนาด'),
              ),
              Expanded(
                //flex: 1,
                child: Style().showTitleH2('ข้อความ'),
              ),
              // Expanded(
              //   //flex: 1,
              //   child: Style().showTitleH2('ราคา'),
              // ),
              Expanded(
                flex: 1,
                child: Style().showTitleH2('รวม'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildPaymentButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 10, right: 10),
          width: 160,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              primary: Colors.pink.shade200,
            ),
            onPressed: () {
              Navigator.pushNamed(context, AppRoute.PeymentRoute);
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
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              primary: Colors.pink.shade200,
            ),
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

  Widget buildlistCake() => ListView.builder(
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
                  child: Text(cartModels[index].cake_size ?? ''),
                ),
                Expanded(
                  flex: 2,
                  child: Text(cartModels[index].cake_text ?? ''
                    ,
                    //style: Style().mainh23Title,
                  ),
                ),
                // Expanded(
                //   flex: 2,
                //   child: Text(cartModels[index].price ?? ''
                //     //style: Style().mainh23Title,
                //   ),
                // ),
                Expanded(
                  flex: 1,
                  child: Text(
                    ' ${cartModels[index].price}ฺ THB',
                    style: Style().mainh23Title,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    color: Colors.red,
                    icon: Icon(Icons.cancel_presentation_sharp),
                    onPressed: () async {
                      int id = cartModels[index].id;
                      int price = int.parse(cartModels[index].price); // ราคาของสินค้าที่จะลบ
                      print('You Click delete id = $id');
                      await SQLiteHlper().deleteDataWhereId(id).then(
                        (value) {
                          print('delete Success id =$id');
                          setState(() {
                            total -= price; // ลบราคาสินค้าที่ถูกลบออกจากค่า total
                          });
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
