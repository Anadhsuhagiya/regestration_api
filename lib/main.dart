import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:regestration_api/signup.dart';

void main()
{
    runApp(MaterialApp(debugShowCheckedModeBanner: false,home: splash(),));
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

        await Future.delayed(Duration(seconds: 5));
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
                return signup();
            },
        ));
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Center(
                child: Lottie.network('https://assets9.lottiefiles.com/packages/lf20_tll0j4bb.json'),
            ),
        );
    }
}
