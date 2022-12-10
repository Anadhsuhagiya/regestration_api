import 'dart:async';

import 'package:flutter/material.dart';
import 'package:regestration_api/add_product.dart';
import 'package:regestration_api/view_product.dart';

import 'Login.dart';
import 'model.dart';

class HOME extends StatefulWidget {
  const HOME({Key? key}) : super(key: key);

  @override
  State<HOME> createState() => _HOMEState();
}

class _HOMEState extends State<HOME> {
  String ID = "";
  String NAME = "";
  String EMAIL = "";
  String PHONE = "";
  String PASSWORD = "";
  String IMAGEPATH = "";
  String IMAGEurl = "";
  bool status = false;
  double percent = 0.0;

  @override
  void initState() {
    super.initState();
    initpref();
  }

  initpref() async {
    Timer? timer;
    timer = Timer.periodic(Duration(milliseconds:1000),(_){
      setState(() {
        percent+=10;
        if(percent >= 100){
          timer!.cancel();
          // percent=0;
        }
      });
    });
    print(Model.prefs!.getBool('login'));

    ID = Model.prefs!.getString('id') ?? "";
    NAME = Model.prefs!.getString('Name') ?? "";
    EMAIL = Model.prefs!.getString('Email') ?? "";
    PHONE = Model.prefs!.getString('Phone') ?? "";
    PASSWORD = Model.prefs!.getString('Password') ?? "";
    IMAGEPATH = Model.prefs!.getString('Photo') ?? "";
    IMAGEurl = "https://flutteranadh.000webhostapp.com/$IMAGEPATH";
    setState(() {
      status = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Color(0xff040065)),
                  accountName: Text("$NAME"),
                    currentAccountPicture: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(IMAGEurl), fit: BoxFit.fill)),
                  ),
                  otherAccountsPictures: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(IMAGEurl), fit: BoxFit.fill)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(IMAGEurl), fit: BoxFit.fill)),
                    ),
                  ],
                  accountEmail: Text("$EMAIL")),
              Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return Add_Product();
                    },));
                  },
                  title: Text(
                    "Add Product",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  leading: Icon(Icons.add_circle_outline, color: Colors.black),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return View_Product();
                    },));
                  },
                  title: Text(
                    "View Product",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  leading: Icon(Icons.view_agenda_rounded, color: Colors.black),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {},
                  title: Text(
                    "Rate Us",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  leading: Icon(Icons.star, color: Colors.black),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {},
                  title: Text(
                    "Setting",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  leading: Icon(Icons.settings, color: Colors.black),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () async {
                    await Model.prefs!.clear();
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return Login();
                      },
                    ));
                  },
                  title: Text(
                    "Log Out",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  leading: Icon(Icons.logout, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  await Model.prefs!.clear();
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return Login();
                    },
                  ));
                },
                icon: Icon(Icons.logout))
          ],
          centerTitle: true,
          title: Text(
            "Home",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),
          ),
          backgroundColor: Color(0xff040065),
        ),

         body: Column()
        // CircularPercentIndicator(
        //   radius: 30.0,
        //   lineWidth: 8.0,
        //   animation: true,
        //   percent: percent/100,
        //   center: Text(
        //     percent.toString() + "%",
        //     style: TextStyle(
        //         fontSize: 10.0,
        //         fontWeight: FontWeight.w600,
        //         color: Colors.white),
        //   ),
        //   backgroundColor: Color(0xff5952ea),
        //   circularStrokeCap: CircularStrokeCap.round,
        //   progressColor: Color(0xffffffff),
        // )
      ),
    );
  }
}
