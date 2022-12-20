import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_haptic/haptic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:regestration_api/HOME.dart';

class Add_Product extends StatefulWidget {
  const Add_Product({Key? key}) : super(key: key);

  @override
  State<Add_Product> createState() => _Add_ProductState();
}

class _Add_ProductState extends State<Add_Product> {

  ImagePicker _picker = ImagePicker();
  String imagePath = "";
  bool photoerror = false;

  TextEditingController Product_name = TextEditingController();
  TextEditingController Product_price = TextEditingController();
  TextEditingController Inventory = TextEditingController();
  TextEditingController Description = TextEditingController();
  bool Pro_name_error = false;
  bool Pro_price_error = false;
  bool Inventory_error = false;
  bool des_error = false;
  bool Pro_name_valid = false;
  bool Pro_price_valid = false;
  bool Inventory_valid = false;

  String price = "";
  String INventory = "";
  String DEscription = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff480070).withOpacity(0.25),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add Product",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),
        ),
        backgroundColor: Color(0xff160021),
      ),
      body: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
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
              SingleChildScrollView(
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

                                    final XFile? photo = await _picker.pickImage(
                                        source: ImageSource.camera);
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
                                    final XFile? photo = await _picker.pickImage(
                                        source: ImageSource.gallery);

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
                        height: 150,
                        width: 150,
                        margin: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                                image: imagePath.isNotEmpty
                                    ? FileImage(
                                  File(imagePath),
                                ) as ImageProvider
                                    : AssetImage(
                                  'image/1.webp',
                                ),
                                fit: BoxFit.fill),
                            shadows: [
                              BoxShadow(
                                  spreadRadius: -3,
                                  blurStyle: BlurStyle.normal,
                                  offset: Offset(2, 5),
                                  blurRadius: 8,
                                  color: Colors.black
                              )
                            ],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)))),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        color: Color(0xffa400e1).withOpacity(0.2),
                        child: TextField(
                          onChanged: (value) {
                            print(value);
                            if (Pro_name_error) {
                              if (value.isNotEmpty) {
                                Pro_name_error = false;
                                setState(() {

                                });
                              }
                            }
                          },
                          controller: Product_name,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.sentences,
                          style: TextStyle(color: Color(0xffffffff)),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(),
                              hintText: "Enter Product Name",
                              hintStyle: TextStyle(color: Colors.grey),
                              labelText: "Product Name",
                              labelStyle: TextStyle(color: Color(0xffffffff)),
                              errorText: Pro_name_error
                                  ? "Please Enter Valid Product Name"
                                  : null,
                              prefixIcon: Icon(
                                EvaIcons.bookmark,
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
                          onChanged: (value) {
                            print(value);
                            if (Pro_price_error) {
                              if (value.isNotEmpty) {
                                Pro_price_error = false;
                                setState(() {

                                });
                              }
                            }
                          },
                          controller: Product_price,
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: Color(0xffffffff)),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(),
                              hintText: "Enter Product Price",
                              hintStyle: TextStyle(color: Colors.grey),
                              labelText: "Product Price",
                              labelStyle: TextStyle(color: Color(0xffffffff)),
                              errorText: Pro_price_error
                                  ? "Please Enter Valid Product Price"
                                  : null,
                              prefixIcon: Icon(
                                Icons.currency_rupee_sharp,
                                color: Color(0xffffffff),size: 16,
                              )),
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
                            if (Inventory_error) {
                              if (value.isNotEmpty) {
                                Inventory_error = false;
                                setState(() {

                                });
                              }
                            }
                          },
                          controller: Inventory,
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: Color(0xffffffff)),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(),
                              hintText: "Enter Inventory ",
                              hintStyle: TextStyle(color: Colors.grey),
                              labelText: "Inventory",
                              labelStyle: TextStyle(color: Color(0xffffffff)),
                              errorText: Inventory_error
                                  ? "Please Enter Valid Inventory"
                                  : null,
                              prefixIcon: Icon(
                                Icons.inventory,
                                color: Color(0xffffffff),size: 16,
                              )),
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
                            if (des_error) {
                              if (value.isNotEmpty) {
                                des_error = false;
                                setState(() {

                                });
                              }
                            }
                          },
                          controller: Description,
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 6,
                          style: TextStyle(color: Color(0xffffffff)),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(),
                              hintText: "Enter Description About Product ",
                              hintStyle: TextStyle(color: Colors.grey),
                              labelText: "Description",
                              labelStyle: TextStyle(color: Color(0xffffffff)),
                              errorText: Inventory_error
                                  ? "Please Enter Valid Description"
                                  : null,),
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: () async {
                        // Haptic Feedback for Success
                        Haptic.onSuccess();
                        String Pro_Name = Product_name.text;
                        String Pro_Price = Product_price.text;
                        String inventory = Inventory.text;
                        String description = Description.text;
                        // Map m = {'name': Name, 'phone': Phone, 'email': Email, 'pass': pass};

                        String link = "https://flutteranadh.000webhostapp.com/product.php";

                        if (photoerror == false) {
                          Fluttertoast.showToast(
                              msg: "Please Insert Product Image",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 15.0
                          );
                        }
                        else if (Pro_Name.isEmpty) {
                          setState(() {
                            Pro_name_error = true;
                          });
                        } else if (Pro_Price.isEmpty) {
                          setState(() {
                            Pro_price_error = true;
                            price = "Enter Email Address";
                          });
                        } else if (inventory.isEmpty) {
                          setState(() {
                            Inventory_error = true;
                            INventory = "Enter your Contact";
                          });
                        } else if (description.isEmpty) {
                          setState(() {
                            des_error = true;
                            DEscription = "Enter your password";
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
                          String imageName = "$Pro_Name${dt.year}${dt.month}${dt.day}${dt
                              .hour}${dt.minute}${dt.second}";

                          var formData = FormData.fromMap({
                            'pro_name': Pro_Name,
                            'pro_price': Pro_Price,
                            'inventory': inventory,
                            'description': description,
                            'file': await MultipartFile.fromFile(
                                imagePath, filename: imageName),
                          });
                          var response = await Dio().post(link, data: formData);

                          Navigator.pop(context);

                          if (response.statusCode == 200) {
                            print("Response : ${response.data}");

                            Map map = jsonDecode(response.data);

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
                              desc: 'Your Product has been added successfully...',
                              btnOkOnPress: () {
                                // Haptic Feedback for Success
                                Haptic.onSuccess();
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                  return HOME();
                                },));

                              },
                            )..show();

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
                            color: Color(0xff5f0380),
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
                          "Add",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
    );
  }
}
