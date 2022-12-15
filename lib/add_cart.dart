import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class cart extends StatefulWidget {
  @override
  State<cart> createState() => _cartState();
}

class _cartState extends State<cart> {
  bool status = false;
  List l = [];
  String photoLink = "https://flutteranadh.000webhostapp.com/";
  int TotalPay = 0;
  int MyRound = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Anadh();
  }

  Anadh() async {
    var url = Uri.parse('https://flutteranadh.000webhostapp.com/get_cart.php');
    var response = await http.get(url);

    print("response :- $response");

    if (response.statusCode == 200) {
      Map map = jsonDecode(response.body);

      User user = User.fromJson(map);

      l = user.data!;

      print("Map : $map");

      setState(() {
        status = true;
      });
      print(status);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff480070).withOpacity(0.25),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Cart",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),
        ),
        backgroundColor: Color(0xff160021),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            // decoration: BoxDecoration(
            //     image: DecorationImage(
            //         image: AssetImage(
            //             'image/12922e803053151f09f1eb99248579c7.jpg'),
            //         opacity: 200,
            //         fit: BoxFit.cover)),
            child: Opacity(
              opacity: 0.15,
              child: Lottie.network(
                  'https://assets1.lottiefiles.com/packages/lf20_5ngs2ksb.json'),
            ),
          ),
          status
              ? Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: l.length,
                  itemBuilder: (context, index) {

                    double Total = double.parse(l[index].proDiscount) * double.parse(l[index].item);
                    MyRound = Total.round();
                    String total = MyRound.toString();
                    TotalPay = TotalPay + MyRound;
                    print(TotalPay);

                    return Card(
                      color: Color(0xff550077).withOpacity(0.2),
                      shadowColor: Color(0xff4d4d4d),
                      child: ListTile(
                        title: Text(
                          "${l[index].proName}",
                          style: TextStyle(fontSize: 23,color: Colors.white,fontWeight: FontWeight.bold),
                        ),
                        leading: Container(
                          height: 50,
                          width: 50,
                          padding: EdgeInsets.all(4),
                          decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      '${photoLink}${l[index].proPhoto}'),
                                  fit: BoxFit.fill)),
                        ),
                        trailing: IconButton(
                            onPressed: () async {

                            }, icon: Icon(Icons.delete_forever,color: Colors.grey,)),
                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                Text("₹ ${l[index].proPrice}",style: TextStyle(decoration: TextDecoration.lineThrough,color: Colors.grey),),
                                Text("   ₹ ${l[index].proDiscount}   ",style: TextStyle(color: Colors.white),),
                                Text("  10% Off",style: TextStyle(color: Colors.white)),
                              ],
                            ),
                            Row(mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("\nQty: ${l[index].item}",style: TextStyle(color: Colors.white)),
                              ],
                            ),
                            Row(mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("₹ $total /-  ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  print(l.length);
                  print("Payment :- $TotalPay");

                  //Payments


                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                      color: Color(0xff730586).withOpacity(0.5),
                      shadows: [
                        BoxShadow(
                            blurRadius: 7,
                            spreadRadius: 1,
                            offset: Offset(0, 3),
                            color: Colors.black.withOpacity(0.4))
                      ],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Text(
                    "Payment",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          )
              : Center(
            child: CircularProgressIndicator(
              color: Color(0xffffffff),
            ),
          ),
        ],
      )
    );
  }
}

class User {
  List<Data>? data;

  User({this.data});

  User.fromJson(Map json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? proName;
  String? proPrice;
  String? proDiscount;
  String? proPhoto;
  String? item;

  Data(
      {this.id,
      this.proName,
      this.proPrice,
      this.proDiscount,
      this.proPhoto,
      this.item});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    proName = json['Pro_name'];
    proPrice = json['Pro_price'];
    proDiscount = json['Pro_discount'];
    proPhoto = json['Pro_photo'];
    item = json['item'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Pro_name'] = this.proName;
    data['Pro_price'] = this.proPrice;
    data['Pro_discount'] = this.proDiscount;
    data['Pro_photo'] = this.proPhoto;
    data['item'] = this.item;
    return data;
  }
}

