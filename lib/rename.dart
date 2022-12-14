import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_haptic/haptic.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/drawer/gf_drawer.dart';
import 'package:getwidget/components/drawer/gf_drawer_header.dart';
import 'package:lottie/lottie.dart';
import 'package:regestration_api/Login.dart';
import 'package:regestration_api/model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'HOME.dart';

class rename extends StatefulWidget {
  //
  // String id;
  // String name;
  // String email;
  // String phone;
  // String password;
  // String imagepath;
  //
  // rename(this.id, this.name, this.email, this.phone, this.password, this.imagepath);

  @override
  State<rename> createState() => _renameState();
}

class _renameState extends State<rename> {
  String ID = "";
  String NAME = "";
  String EMAIL = "";
  String PHONE = "";
  String PASSWORD = "";
  String IMAGEPATH = "";

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController Password = TextEditingController();
  TextEditingController contact = TextEditingController();
  bool nameerror = false;
  bool namevalid = false;

  @override
  void initState() {
    super.initState();

    initpref();

    name.text = NAME;
    email.text = EMAIL;
    contact.text = PHONE;
    Password.text = PASSWORD;
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff480070).withOpacity(0.25),
        drawer: Drawer(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xff190026),
                  Color(0xff380057),
                ],
              ),
            ),
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
                        Color(0xff290042),
                        Color(0xff7900c2),
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
                  color: Color(0xff550077).withOpacity(0.5),
                  child: ListTile(
                    onTap: () {},
                    title: Text(
                      "Rate Us",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    leading: Icon(Icons.star, color: Colors.white),
                  ),
                ),
                Card(
                  color: Color(0xff550077).withOpacity(0.5),
                  child: ListTile(
                    onTap: () {},
                    title: Text(
                      "Setting",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    leading: Icon(Icons.settings, color: Colors.white),
                  ),
                ),
                Card(
                  color: Color(0xff550077).withOpacity(0.5),
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
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    leading: Icon(Icons.logout, color: Colors.white),
                  ),
                ),
              ],
            ),
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
            "Update",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),
          ),
          backgroundColor: Color(0xff28003d),
        ),
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              // decoration: BoxDecoration(
              //   Lottie.network()
              //     // image: DecorationImage(
              //     //     image: AssetImage(
              //     //         'image/12922e803053151f09f1eb99248579c7.jpg'),
              //     //     opacity: 200,
              //     //     fit: BoxFit.cover)
              // ),
              child: Opacity(
                opacity: 0.15,
                child: Lottie.network(
                    'https://assets1.lottiefiles.com/packages/lf20_5ngs2ksb.json'),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Center(
                      child: Text(
                        "Update",
                        style: TextStyle(
                            color: Color(0xffffffff),
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      color: Color(0xffa400e1).withOpacity(0.2),
                      child: TextField(
                        onChanged: (value) {
                          print(value);
                          if (nameerror) {
                            if (value.isNotEmpty) {
                              nameerror = false;
                              setState(() {});
                            }
                          }
                        },
                        controller: name,
                        autofocus: false,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.sentences,
                        style: TextStyle(color: Color(0xffffffff)),
                        decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            border: OutlineInputBorder(),
                            hintText: "Enter Name",
                            labelText: "Name",
                            labelStyle: TextStyle(color: Color(0xffffffff)),
                            errorText:
                                nameerror ? "Please Enter Valid Name" : null,
                            prefixIcon: Icon(
                              Icons.person,
                              color: Color(0xffffffff),
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      color: Color(0xffa400e1).withOpacity(0.2),
                      child: TextField(
                        controller: email,
                        readOnly: true,
                        style: TextStyle(color: Color(0xffffffff)),
                        decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            border: OutlineInputBorder(),
                            hintText: "Enter Email Address",
                            labelText: "Email",
                            labelStyle: TextStyle(color: Color(0xffffffff)),
                            prefixIcon: Icon(
                              Icons.email_rounded,
                              color: Color(0xffffffff),
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      color: Color(0xffa400e1).withOpacity(0.2),
                      child: TextField(
                        controller: contact,
                        readOnly: true,
                        style: TextStyle(color: Color(0xffffffff)),
                        decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            border: OutlineInputBorder(),
                            hintText: "Enter Contact",
                            labelText: "Contact",
                            labelStyle: TextStyle(color: Color(0xffffffff)),
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Color(0xffffffff),
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      color: Color(0xffa400e1).withOpacity(0.2),
                      child: TextField(
                        controller: Password,
                        readOnly: true,
                        style: TextStyle(color: Color(0xffffffff)),
                        decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            border: OutlineInputBorder(),
                            hintText: "Enter Password",
                            labelText: "Password",
                            labelStyle: TextStyle(color: Color(0xffffffff)),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Color(0xffffffff),
                            )),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      // Haptic Feedback for Success
                      Haptic.onSuccess();
                      String Name = name.text;
                      String Email = email.text;
                      String Contact = contact.text;
                      Map map = {};

                      if (Name.isEmpty) {
                        setState(() {
                          nameerror = true;
                        });
                      } else {
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
                                      child: CircularProgressIndicator(),
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

                        String link =
                            "https://flutteranadh.000webhostapp.com/update.php";

                        Map m = {
                          'name': Name,
                          'email': Email,
                          'phone': Contact
                        };

                        var url = Uri.parse(link);
                        var response = await http.post(url, body: m);

                        Navigator.pop(context);

                        print('Response status: ${response.statusCode}');

                        if (response.statusCode == 200) {
                          print("response : ${response.body}");
                          map = jsonDecode(response.body);

                          int result = map['result'];

                          if (result == 1) {
                            Map data = map['data'];
                            setState(() {
                              NAME = data['name'];
                            });
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.bottomSlide,
                              title: 'Updated',
                              desc: 'Name Updated Successfully',
                              btnOkOnPress: () {
                                // Haptic Feedback for Success
                                Haptic.onSuccess();
                              },
                            )..show();
                          }
                        }
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 120,
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                          color: Color(0xff72069a),
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
                        "Update",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "If no Change ? them Press ",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        TextButton(
                            onPressed: () async {
                              await Model.prefs!.setInt('home', 1);
                              print(Model.prefs!.getInt('home'));
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return HOME();
                                },
                              ));
                            },
                            child: Text(
                              "Home",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff9816da),
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
