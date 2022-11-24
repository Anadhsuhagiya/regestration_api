import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'Login.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {

  ImagePicker _picker = ImagePicker();
  String imagePath = "";

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController Password = TextEditingController();
  TextEditingController contact = TextEditingController();

  bool nameerror = false;
  bool namevalid = false;
  bool emailerror = false;
  bool passerror = false;
  bool contacterror = false;
  bool hidepass = true;
  bool photoerror = false;

  int textLength = 0;
  int maxLength = 10;

  String contactmsg = "";
  String emailmsg = "";
  String passmsg = "";


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Regestration",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),
          ),
          backgroundColor: Color(0xff040065),
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return SimpleDialog(
                          title: Text("Select Image "),
                          children: [
                            ListTile(
                              title: Text("Camera"),
                              onTap: () async {
                                Navigator.pop(context);

                                final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
                                setState(() {
                                  if (photo != null) {
                                    imagePath = photo.path;
                                   photoerror = true;
                                  }
                                });
                                print(imagePath);

                              },
                            ),
                            ListTile(
                              title: Text("Gallary"),
                              onTap: () async {
                                Navigator.pop(context);
                                final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);

                                setState(() {
                                  if (photo != null) {
                                    imagePath = photo.path;
                                    photoerror = true;
                                  }
                                });
                                print(photo!.path);

                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 125, right: 125, top: 10, bottom: 10),
                    height: 140,
                    width: 140,
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Colors.transparent,
                        image: DecorationImage(
                            image: imagePath.isNotEmpty
                                ? FileImage(
                              File(imagePath),
                            ) as ImageProvider
                                : AssetImage(
                              'image/person-man.webp',
                            ),
                            fit: BoxFit.fill)),
                  )),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                      onChanged: (value) {
                        print(value);
                        if (nameerror) {
                          if (value.isNotEmpty) {
                            nameerror = false;
                            setState(() {

                            });
                          }
                        }
                      },
                      controller: name,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Color(0xff040065)),
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff040065), width: 3)),
                          border: OutlineInputBorder(),
                          hintText: "Enter Name",
                          labelText: "Name",
                          labelStyle: TextStyle(color: Color(0xff040065)),
                          errorText: nameerror
                              ? "Please Enter Valid Name"
                              : null,
                          prefixIcon: Icon(
                            Icons.person,
                            color: Color(0xff040065),
                          )),
                    ),
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
                      controller: email,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Color(0xff040065)),
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff040065), width: 3)),
                          border: OutlineInputBorder(),
                          hintText: "Enter Email Address",
                          labelText: "Email",
                          labelStyle: TextStyle(color: Color(0xff040065)),
                          errorText:
                          emailerror ? emailmsg : null,
                          prefixIcon: Icon(
                            Icons.email_rounded,
                            color: Color(0xff040065),
                          )),
                    ),
                  ),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                      onChanged: (value) {
                        textLength = value.length;
                        if (contacterror) {
                          if (value.isNotEmpty) {
                            setState(() {
                              contacterror = false;
                            });
                          }
                        }
                      },
                      controller: contact,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(color: Color(0xff040065)),
                      maxLength: 10,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff040065))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff040065), width: 3)),
                          counter: Offstage(),
                          suffixText:
                          '${textLength.toString()}/${maxLength.toString()}',
                          hintText: "Enter Your Contact",
                          labelText: "Contact",
                          labelStyle: TextStyle(color: Color(0xff040065)),
                          errorText:
                          contacterror ? contactmsg : null,
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Color(0xff040065),
                          )),
                    ),
                  ),
              Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 10, top: 3),
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
                      style: TextStyle(color: Color(0xff040065)),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xff040065), width: 3)),
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

                  String Name = name.text;
                  String Phone = contact.text;
                  String Email = email.text;
                  String pass = Password.text;
                  // Map m = {'name': Name, 'phone': Phone, 'email': Email, 'pass': pass};

                  bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(Email);
                  bool passValid =
                  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                      .hasMatch(pass);

                  String link = "https://flutteranadh.000webhostapp.com/register.php";

                  if(photoerror==false)
                  {
                    Fluttertoast.showToast(
                        msg: "Please Insert Profile Image",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 15.0
                    );
                  }
                  else if (Name.isEmpty) {
                    setState(() {
                      nameerror = true;
                    });
                  } else if (Email.isEmpty) {
                    setState(() {
                      emailerror = true;
                      emailmsg = "Enter Email Address";
                    });
                  } else if (!emailValid) {
                    setState(() {
                      emailerror = true;
                      emailmsg = "Please Enter Valid Email Address";
                    });
                  } else if (Phone.isEmpty) {
                    setState(() {
                      contacterror = true;
                      contactmsg = "Enter your Contact";
                    });
                  } else if (Phone.length < 10) {
                    setState(() {
                      contacterror = true;
                      contactmsg = "Please Enter 10 digit Contact";
                    });
                  } else if (pass.isEmpty) {
                    setState(() {
                      passerror = true;
                      passmsg = "Enter your password";
                    });
                  } else if (!passValid) {
                    setState(() {
                      passerror = true;
                      passmsg = "Please Enter Valid Formatted password";
                    });
                  }
                  else {
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

                    DateTime dt = DateTime.now();
                    String imageName = "$Name${dt.year}${dt.month}${dt.day}${dt.hour}${dt.minute}${dt.second}";

                    var formData = FormData.fromMap({
                      'name': Name,
                      'email': Email,
                      'phone': Phone,
                      'pass': pass,
                      'file': await MultipartFile.fromFile(imagePath, filename: imageName),
                    });
                    var response = await Dio().post(link, data: formData);

                    Navigator.pop(context);

                    if(response.statusCode == 200)
                      {
                        print("Response : ${response.data}");

                        Map map = jsonDecode(response.data);

                        int result = map['result'];

                        print(result);
                        if(result == 0)
                          {
                            print("Try Again");
                          }
                        else if(result == 1)
                          {
                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                               return Login();
                             },));
                          }
                      }

                    //http for small data send to php file
                    // var url = Uri.parse(link);
                    // var response = await http.post(url, body: m);
                    //
                    // Navigator.pop(context);
                    //
                    // print('Response status: ${response.statusCode}');
                    //
                    // if (response.statusCode == 200) {
                    //   print('Response body: ${response.body}');
                    // }
                  }
                },
                child: Container(
                  height: 50,
                  width: 120,
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
                    "SignUp",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),

              Center(
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                          return Login();
                        },));
                      },
                      child: Text(
                        "Already Login ?",
                        style: TextStyle(fontSize: 20),
                      ))),
              Container(
                height: 17,
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 15, top: 10),
                alignment: Alignment.center,
                child: Text(
                  "--------------- Or Signup with ---------------",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {},
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
                      child: Image.asset('image/google.png'),
                      padding: EdgeInsets.all(10),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
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
                      child: Image.asset('image/facebook.png'),
                      padding: EdgeInsets.all(10),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
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
                      child: Image.asset('image/twitter.png'),
                      padding: EdgeInsets.all(10),
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
