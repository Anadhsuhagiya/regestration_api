import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:regestration_api/Product_details.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;

import 'model.dart';

class View_Product extends StatefulWidget {
  const View_Product({Key? key}) : super(key: key);

  @override
  State<View_Product> createState() => _View_ProductState();
}

class _View_ProductState extends State<View_Product> {
  bool status = false;
  List l = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Anadh();
  }

  Anadh() async {
    var url =
        Uri.parse('https://flutteranadh.000webhostapp.com/get_product.php');
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
      backgroundColor: Color(0xffe1e1e1),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "View Product",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),
        ),
        backgroundColor: Color(0xff040065),
      ),
      body: status
          ? ListView.builder(
              itemCount: l.length,
              itemBuilder: (context, index) {
                int a = int.parse(l[index].pRICE);
                var Discount = a - ((a * 10)/100);
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return Product_details(l[index],Discount);
                    },));
                  },
                  child: Card(
                    child: Container(
                      foregroundDecoration: RotatedCornerDecoration(
                        color: Color(0xffc40000),
                        geometry: const BadgeGeometry(width: 48, height: 48),
                        textSpan: const TextSpan(
                          text: 'off\n10%',
                          style: TextStyle(
                            fontSize: 10,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                            shadows: [BoxShadow(color: Colors.white, blurRadius: 4)],
                          ),
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          l[index].pRODUCTNAME,
                          style:
                              TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("₹ ${l[index].pRICE}",style: TextStyle(fontSize: 16,decoration: TextDecoration.lineThrough),),
                        leading: Container(
                          height: 40,
                          width: 40,
                          decoration: ShapeDecoration(
                            image: DecorationImage(image: NetworkImage('https://flutteranadh.000webhostapp.com/${l[index].pHOTO}'),fit: BoxFit.fill),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text("₹ $Discount"),
                        ),
                      ),
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
  String? pRODUCTNAME;
  String? pRICE;
  String? iNVENTORY;
  String? dESCRIPTION;
  String? pHOTO;

  Data(
      {this.id,
      this.pRODUCTNAME,
      this.pRICE,
      this.iNVENTORY,
      this.dESCRIPTION,
      this.pHOTO});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pRODUCTNAME = json['PRODUCT_NAME'];
    pRICE = json['PRICE'];
    iNVENTORY = json['INVENTORY'];
    dESCRIPTION = json['DESCRIPTION'];
    pHOTO = json['PHOTO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['PRODUCT_NAME'] = this.pRODUCTNAME;
    data['PRICE'] = this.pRICE;
    data['INVENTORY'] = this.iNVENTORY;
    data['DESCRIPTION'] = this.dESCRIPTION;
    data['PHOTO'] = this.pHOTO;
    return data;
  }
}
