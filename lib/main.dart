import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:regestration_api/HOME.dart';
import 'package:regestration_api/Login.dart';
import 'package:regestration_api/rename.dart';
import 'package:regestration_api/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: splash(),
  ));
}

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    go();
  }

  go() async {
    Model.prefs = await SharedPreferences.getInstance();

    await Future.delayed(Duration(seconds: 5));

    bool status = Model.prefs!.getBool('login') ?? false;
    int stat = Model.prefs!.getInt('home') ?? 0;

    if (status == true) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return rename();
        },
      ));
    }
    else {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return Login();
        },
      ));
    }
    if(stat == 1)
    {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return HOME();
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xff19002a),
              Color(0xff400069),
            ],
          ),
        ),
        child: Center(
          child: Lottie.network(
              'https://assets1.lottiefiles.com/packages/lf20_5ngs2ksb.json'),
        ),
      ),
    );
  }
}
