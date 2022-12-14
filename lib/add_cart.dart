import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:regestration_api/Theme/lightcolor.dart';

import 'Theme/theme.dart';

class cart extends StatefulWidget {
  @override
  State<cart> createState() => _cartState();
}

class _cartState extends State<cart> {
  bool status = false;
  List l = [];
  String photoLink = "https://flutteranadh.000webhostapp.com/";

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
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Cart",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),
        ),
        backgroundColor: Color(0xff040065),
      ),
      body: status
          ? ListView.builder(
              itemCount: l.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      "${l[index].proName}",
                      style: TextStyle(fontSize: 19,),
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
                          String link = 'https://flutteranadh.000webhostapp.com/cart.php';

                          Map map = {
                            'pro_name': l[index].proName,
                            'pro_price': l[index].proPrice,
                            'pro_inventory': l[index].item,
                            'pro_discount': l[index].proDiscount,
                            'pro_photo': l[index].proPhoto
                          };

                          // http for small data send to php file
                          var url = Uri.parse(link);
                          var response = await http.post(url, body: map);

                          Navigator.pop(context);

                        }, icon: Icon(Icons.delete_forever)),
                    subtitle: Column(
                      children: [
                        Row(
                          children: [
                            Text("₹ ${l[index].proDiscount}   `",style: TextStyle(color: Colors.black),),
                            Text("₹ ${l[index].proPrice}",style: TextStyle(decoration: TextDecoration.lineThrough),),
                            Text("  10% Off",style: TextStyle(color: Colors.black)),
                          ],
                        ),
                        Row(
                          children: [
                            Text("\nQty: ${l[index].item}",style: TextStyle(color: Colors.black)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(
                color: Color(0xff040065),
              ),
            ),
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
