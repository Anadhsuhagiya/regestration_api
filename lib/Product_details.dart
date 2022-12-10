
import 'package:flutter/material.dart';
import 'package:regestration_api/add_cart.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';

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
  double? Discount;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    a();
  }

  a(){
    Name = widget.l.pRODUCTNAME;
    Photo = widget.l.pHOTO;
    Price = widget.l.pRICE;
    Discount = widget.discount;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Details",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),
        ),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return cart(Name,Photo,Price,Discount);
            },));
          }, icon: Icon(Icons.add_shopping_cart_outlined))
        ],
        backgroundColor: Color(0xff040065),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "${widget.l.pRODUCTNAME}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 40,
                fontWeight: FontWeight.bold,
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
                color: Colors.white,
                shadows: [
                  BoxShadow(
                      blurRadius: 7,
                      spreadRadius: 1,
                      offset: Offset(0, 3),
                      color: Colors.black.withOpacity(0.4))
                ],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)))),
            child: Image.network(
                'https://flutteranadh.000webhostapp.com/${widget.l.pHOTO}'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Text(
                  "₹ ${widget.discount}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text("₹ ${widget.l.pRICE}",style: TextStyle(color: Colors.grey,decoration: TextDecoration.lineThrough,fontSize: 18),),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return cart(Name,Photo,Price,Discount);
                  },));
                },
                child: Container(
                  height: 50,
                  width: 140,
                  margin: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                      color: Color(0xff040065),
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


        ],
      ),
    );
  }
}
