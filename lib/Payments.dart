import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Payments extends StatefulWidget {
  const Payments({Key? key}) : super(key: key);

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff480070).withOpacity(0.25),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Payment",
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
          ),        ],
      ),
    );
  }
}
