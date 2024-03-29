import 'package:appbirthdaycake/config/api.dart';
import 'package:appbirthdaycake/config/approute.dart';
import 'package:appbirthdaycake/custumer/model/cake_n_model.dart';
import 'package:appbirthdaycake/services/network.dart';
import 'package:flutter/material.dart';

class CakeBody extends StatelessWidget {
  const CakeBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: 
        FutureBuilder<CakeNModel>(
          future: NetworkService().getAllCakeNDio(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  //padding: EdgeInsets.only(top: 10, bottom: 15),
                  itemCount: snapshot.data.cakens.length,
                  itemBuilder: (context, index) {
                    var cake = snapshot.data.cakens[index];
                    return Material(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoute.CakeDetailRoute,arguments: cake);
                        },
                        child: Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(40, 5, 25, 10),
                              height: 280,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.pink[100],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(100, 20, 20, 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 120,
                                          child: Text(
                                            cake.cnId.toString(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Column(
                                            children: [
                                              Text(
                                                'ราคาเริ่มต้น',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Text('฿' + cake.cnPrice.toString(),
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                              // Text(
                                              //   'ราคา',
                                              //   style: TextStyle(
                                              //       color: Colors.grey),
                                              // ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 20,
                              top: 15,
                              bottom: 15,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image(
                                  width: 250,
                                  image: NetworkImage(
                                      API.CN_IMAGE + cake.cnImages),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
