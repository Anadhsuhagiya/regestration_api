import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_haptic/haptic.dart';
import 'package:lottie/lottie.dart';
import 'package:regestration_api/add_cart.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
import 'package:http/http.dart' as http;
import 'package:fluttericon/typicons_icons.dart';
import 'package:fluttericon/fontelico_icons.dart';
import 'package:fluttericon/linecons_icons.dart';

class Product_details extends StatefulWidget {
  var l;
  double discount;

  Product_details(this.l, this.discount);

  @override
  State<Product_details> createState() => _Product_detailsState();
}

class _Product_detailsState extends State<Product_details> {
  String Name = "";
  String Photo = "";
  String Price = "";
  String Description = "";
  double? Discount;
  int i = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    a();
  }

  a() {
    Name = widget.l.pRODUCTNAME;
    Photo = widget.l.pHOTO;
    Price = widget.l.pRICE;
    Discount = widget.discount;
    Description = widget.l.dESCRIPTION;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Details",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return cart();
                  },
                ));
              },
              icon: Icon(Icons.add_shopping_cart_outlined))
        ],
        backgroundColor: Color(0xff160021),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
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
          Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Center(
                    child: Text(
                      "${widget.l.pRODUCTNAME}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  foregroundDecoration: RotatedCornerDecoration(
                    color: Color(0xffc40000),
                    geometry: const BadgeGeometry(width: 68, height: 68),
                    textSpan: const TextSpan(
                      text: 'off\n10%',
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                        shadows: [BoxShadow(color: Colors.white, blurRadius: 4)],
                      ),
                    ),
                  ),
                  margin: EdgeInsets.all(10),
                  height: 300,
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                      color: Color(0xff730586).withOpacity(0.22),
                      shadows: [
                        BoxShadow(
                            blurRadius: 7,
                            spreadRadius: 1,
                            offset: Offset(0, 3),
                            color: Colors.black.withOpacity(0.5))
                      ],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                  child: Image.network(
                    'https://flutteranadh.000webhostapp.com/${widget.l.pHOTO}',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: Text(
                        "₹ ${widget.discount}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "₹ ${widget.l.pRICE}",
                      style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          fontSize: 18),
                    ),
                    InkWell(
                      onTap: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return SimpleDialog(
                              children: [
                                Container(
                                  height: 60,
                                  child: ListTile(
                                    leading: Container(
                                      height: 45,
                                      width: 45,
                                      alignment: Alignment.center,
                                      child: CircularProgressIndicator(color: Colors.black,),
                                    ),
                                    title: Text(
                                      "Please Wait ...",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        );

                        String link = 'https://flutteranadh.000webhostapp.com/cart.php';

                        Map map = {
                          'pro_name': Name,
                          'pro_price': Price,
                          'pro_inventory': i.toString(),
                          'pro_discount': Discount.toString(),
                          'pro_photo': Photo
                        };

                        // http for small data send to php file
                        var url = Uri.parse(link);
                        var response = await http.post(url, body: map);

                        Navigator.pop(context);

                        if (response.statusCode == 200) {
                          print("Response : ${response.body}");

                          Map map = jsonDecode(response.body);

                          int result = map['result'];

                          print("Result :- $result");
                          if (result == 0) {
                            print("Try Again");
                          }
                          else if(result == 1)
                          {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.bottomSlide,
                              title: 'Product Added Successfully',
                              desc: 'Your Product has been added to cart successfully...',
                              btnOkOnPress: () {
                                // Haptic Feedback for Success
                                Haptic.onSuccess();

                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                  return cart();
                                },));
                              },
                            )..show();

                          }
                        }

                      },
                      child: Container(
                        height: 50,
                        width: 140,
                        margin: EdgeInsets.all(10),
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
                          "Add To Cart",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Stack(
                    children: [
                      Positioned(
                        child: Container(
                          margin: EdgeInsets.all(10),
                          height: 45,
                          width: 95,
                          alignment: Alignment.center,
                          decoration: ShapeDecoration(
                              color: Color(0xff9103a9).withOpacity(0.5),
                              shadows: [
                                BoxShadow(
                                    blurRadius: 7,
                                    spreadRadius: 1,
                                    offset: Offset(0, 3),
                                    color: Colors.black.withOpacity(0.5))
                              ],
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)))),
                          child: Text(
                            "$i",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        ),
                      ),
                      Positioned(
                        left: -10,top: 7,
                        child: InkWell(
                          onTap: () {
                            if(i > 0 && i <= 100)
                              {
                                  i = i - 1;
                                  if(i==0){
                                    i=1;
                                  }
                              }
                            else
                              {
                                i = 1;
                              }
                            setState(() {

                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            height: 30,
                            width: 30,
                            alignment: Alignment.center,
                            decoration: ShapeDecoration(
                                color: Color(0xff730586).withOpacity(0.9),
                                shadows: [
                                  BoxShadow(
                                      blurRadius: 7,
                                      spreadRadius: 1,
                                      offset: Offset(0, 3),
                                      color: Colors.black.withOpacity(0.5))
                                ],
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(60)))),
                            child: Icon(Typicons.minus,color: Colors.white,)
                          ),
                        ),
                      ),// minus
                      Positioned(
                        right: -10,top: 7,
                        child: InkWell(
                          onTap: () {
                            if(i > 0 && i <= 100)
                            {
                                i = i + 1;
                            }
                            else
                            {
                              i = 1;
                            }
                            setState(() {

                            });
                          },
                          child: Container(
                              margin: EdgeInsets.all(10),
                              height: 30,
                              width: 30,
                              alignment: Alignment.center,
                              decoration: ShapeDecoration(
                                  color: Color(0xff730586).withOpacity(0.9),
                                  shadows: [
                                    BoxShadow(
                                        blurRadius: 7,
                                        spreadRadius: 1,
                                        offset: Offset(0, 3),
                                        color: Colors.black.withOpacity(0.5))
                                  ],
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(60)))),
                              child: Icon(Icons.add,color: Colors.white,)
                          ),
                        ),
                      ), // Plus
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
