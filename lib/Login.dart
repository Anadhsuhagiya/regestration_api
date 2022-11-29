import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:regestration_api/home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController Username = TextEditingController();
  TextEditingController Password = TextEditingController();

  bool emailerror = false;
  bool passerror = false;
  bool hidepass = true;

  String emailmsg = "";
  String passmsg = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Login Panel",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),
          ),
          backgroundColor: Color(0xff040065),
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                alignment: Alignment.center,
                child: Image.network(
                    'https://t3.ftcdn.net/jpg/03/39/70/90/360_F_339709048_ZITR4wrVsOXCKdjHncdtabSNWpIhiaR7.jpg'),
              ),

              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    onChanged: (value) {
                      print(value);
                      if (emailerror) {
                        if (value.isNotEmpty) {
                          setState(() {
                            emailerror = false;
                          });
                        }
                      }
                    },
                    controller: Username,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Color(0xff040065), width: 3)),
                        border: OutlineInputBorder(),
                        hintText: "Enter Email Address",
                        labelText: "Email",
                        labelStyle: TextStyle(color: Color(0xff040065)),
                        errorText: emailerror ? emailmsg : null,
                        prefixIcon: Icon(
                          Icons.email_rounded,
                          color: Color(0xff040065),
                        )),
                  ),
              ),
              Padding(
                  padding:
                  const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 3),
                  child: TextField(
                    onChanged: (value) {
                      print(value);
                      if (passerror) {
                        if (value.isNotEmpty) {
                          setState(() {
                            passerror = false;
                          });
                        }
                      }
                    },
                    controller: Password,
                    obscureText: hidepass,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Color(0xff040065), width: 3)),
                        border: OutlineInputBorder(),
                        hintText: "Enter Your Password",
                        labelText: "Password",
                        labelStyle: TextStyle(color: Color(0xff040065)),
                        suffixIcon: IconButton(
                            onPressed: () {
                              hidepass = !hidepass;
                              setState(() {

                              });
                            },
                            icon: hidepass
                                ? Icon(
                              Icons.visibility,
                              color: Color(0xff040065),
                            )
                                : Icon(
                              Icons.visibility_off,
                              color: Color(0xff676767),
                            )),
                        errorText: passerror ? passmsg : null,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Color(0xff040065),
                        )),
                  ),
              ),

              InkWell(
                onTap: () async {
                  String username = Username.text;
                  String password = Password.text;

                  if (username.isEmpty) {
                    emailerror = true;
                    emailmsg = "Enter Uesrname ";
                    setState(() {

                    });
                  } else if (password.isEmpty) {
                    passerror = true;
                    passmsg = "Enter your password";
                    setState(() {

                    });
                  } else {
                    showDialog(context: context, builder: (context) {
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
                    },);

                    String api = 'https://flutteranadh.000webhostapp.com/login.php?username=$username&password=$password';

                    var response = await Dio().get(api);
                    print("response :- $response");

                    Navigator.pop(context);

                    if(response.statusCode == 200){
                      Map map = jsonDecode(response.data);

                      int result = map['result'];
                      print("result :- $result");

                      if(result == 0)
                        {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.bottomSlide,
                            title: 'Error',
                            desc: 'Username or Password is Invalid',
                            btnOkOnPress: () {},
                          )..show();
                        }
                      else
                        {
                          Map data = map['data'];

                          String id = data['id'];
                          String name = data['name'];
                          String email = data['email'];
                          String phone = data['phone'];
                          String password = data['password'];
                          String imagepath = data['photo'];
                          print(data);

                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                            return home(id,name,email,phone,password,imagepath);
                          },));
                        }
                    }
                  }
                },
                child: Container(
                  height: 50,
                  width: 120,
                  margin: EdgeInsets.only(left: 120, right: 120, top: 10),
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
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),

              Container(
                height: 17,
                width: double.infinity,
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                child: Text("--------------- Or Signin with ---------------",style: TextStyle(color: Colors.grey),),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {

                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      margin: EdgeInsets.only(top: 20),
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                          color: Color(0xffffffff),
                          shadows: [
                            BoxShadow(
                                blurRadius: 7,
                                spreadRadius: 1,
                                offset: Offset(0, 3),
                                color: Colors.black.withOpacity(0.4))
                          ],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Image.asset('image/google.png'),padding: EdgeInsets.all(10),
                    ),
                  ),
                  InkWell(
                    onTap: () {

                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      margin: EdgeInsets.only(top: 20),
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                          color: Color(0xffffffff),
                          shadows: [
                            BoxShadow(
                                blurRadius: 7,
                                spreadRadius: 1,
                                offset: Offset(0, 3),
                                color: Colors.black.withOpacity(0.4))
                          ],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Image.asset('image/facebook.png'),padding: EdgeInsets.all(10),
                    ),
                  ),
                  InkWell(
                    onTap: () {

                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      margin: EdgeInsets.only(top: 20),
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                          color: Color(0xffffffff),
                          shadows: [
                            BoxShadow(
                                blurRadius: 7,
                                spreadRadius: 1,
                                offset: Offset(0, 3),
                                color: Colors.black.withOpacity(0.4))
                          ],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Image.asset('image/twitter.png'),padding: EdgeInsets.all(10),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
