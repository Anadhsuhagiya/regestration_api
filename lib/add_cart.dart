import 'package:flutter/material.dart';

class cart extends StatefulWidget {

  String name;
  String photo;
  String price;
  double? discount;
  cart(this.name, this.photo, this.price, this.discount);


  @override
  State<cart> createState() => _cartState();
}

class _cartState extends State<cart> {
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

      body: ListView.builder(itemCount: widget.name.length,itemBuilder: (context, index) {
        return ListTile(
          title: Text("${widget.name}",style: TextStyle(fontSize: 17),),
          leading: CircleAvatar(child: Image.network('https://flutteranadh.000webhostapp.com/${widget.photo}')),
          trailing: IconButton(onPressed: () {

          }, icon: Icon(Icons.delete_forever)),
          subtitle: Row(
            children: [
              Text("${widget.price}",style: TextStyle(decoration: TextDecoration.lineThrough,color: Colors.grey),),
              Text("${widget.discount}",style: TextStyle(color: Colors.black),),
            ],
          ),
        );
      },),
    );
  }
}
