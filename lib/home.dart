import 'package:flutter/material.dart';
import 'package:regestration_api/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class home extends StatefulWidget {
  //
  // String id;
  // String name;
  // String email;
  // String phone;
  // String password;
  // String imagepath;
  //
  // home(this.id, this.name, this.email, this.phone, this.password, this.imagepath);


  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  String? ID;
  String? NAME;
  String? EMAIL;
  String? PHONE;
  String? PASSWORD;
  String? IMAGEPATH;


  @override
  void initState() {
    super.initState();

    initpref();
  }

  initpref() async {
    Model.prefs!.setBool('login', true);
    print(Model.prefs!.getBool('login'));

    ID = Model.prefs!.getString('id');
    NAME = Model.prefs!.getString('Name');
    EMAIL = Model.prefs!.getString('Email');
    PHONE = Model.prefs!.getString('Phone');
    PASSWORD = Model.prefs!.getString('Password');
    IMAGEPATH = Model.prefs!.getString('Photo');
  }

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
          Text("$ID"),
          Text("$NAME"),
          Text("$EMAIL"),
          Text("$PHONE"),
          Text("$PASSWORD"),
          Text("$IMAGEPATH"),
        ],
      ),
    );
  }
}
