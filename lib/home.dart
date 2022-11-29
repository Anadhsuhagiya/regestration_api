import 'package:flutter/material.dart';

class home extends StatefulWidget {

  String id;
  String name;
  String email;
  String phone;
  String password;
  String imagepath;

  home(this.id, this.name, this.email, this.phone, this.password, this.imagepath);


  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Home Page",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),
        ),
        backgroundColor: Color(0xff040065),
      ),

      body: Column(
        children: [
          Text("${widget.id}"),
          Text("${widget.name}"),
          Text("${widget.email}"),
          Text("${widget.phone}"),
          Text("${widget.password}"),
          Text("${widget.imagepath}"),
        ],
      ),
    );
  }
}
