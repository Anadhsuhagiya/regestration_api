import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    initpref();
  }

  initpref() async {
    print(Model.prefs!.getBool('login'));

    ID = Model.prefs!.getString('id') ?? "";
    NAME = Model.prefs!.getString('Name') ?? "";
    EMAIL = Model.prefs!.getString('Email') ?? "";
    PHONE = Model.prefs!.getString('Phone') ?? "";
    PASSWORD = Model.prefs!.getString('Password') ?? "";
    IMAGEPATH = Model.prefs!.getString('Photo') ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xff040065),
                    Color(0xff42b3ff),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: ShapeDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color(0xff040065),
                            Color(0xff42b3ff),
                          ],
                        ),
                        shape: CircleBorder(),
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://flutteranadh.000webhostapp.com/$IMAGEPATH"),
                            fit: BoxFit.fill)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "$NAME",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "$EMAIL",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
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
                  await Model.prefs!.setBool('login', false);
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
                await Model.prefs!.setBool('login', false);
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

      body: Column(
        children: [

        ],
      ),
    );
  }
}
