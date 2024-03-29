import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_face_pile/flutter_face_pile.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:overlay_group_avatar/overlay_group_avatar.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:regestration_api/Product_details.dart';
import 'package:regestration_api/add_cart.dart';
import 'package:regestration_api/add_product.dart';
import 'package:regestration_api/rename.dart';
import 'package:regestration_api/view_product.dart';

import 'package:http/http.dart' as http;
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
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
  bool stat = false;
  double percent = 0.0;
  List l = [];

  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;
  late Orientation _currentOrientation;

  @override
  void initState() {
    super.initState();
    initpref();
    Anadh();
  }

  Anadh() async {
    var url =
        Uri.parse('https://flutteranadh.000webhostapp.com/get_product.php');
    var response = await http.get(url);

    print("response :- $response");

    if (response.statusCode == 200) {
      Map map = jsonDecode(response.body);

      User user = User.fromJson(map);

      l = user.data!;

      print("Map : $map");

      setState(() {
        stat = true;
      });
      print(stat);
    }
  }

  initpref() async {
    Timer? timer;
    timer = Timer.periodic(Duration(milliseconds: 1000), (_) {
      setState(() {
        percent += 10;
        if (percent >= 100) {
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
      Model.splash_data = true;
    });
  }

  Widget getAd() {
    BannerAdListener bannerAdListener =
    BannerAdListener(onAdWillDismissScreen: (ad) {
      ad.dispose();
    }, onAdClosed: (ad) {
      debugPrint("Ad Got Closeed");
    });
    BannerAd bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: Platform.isAndroid
          ? "ca-app-pub-3940256099942544/6300978111"
          : "ca-app-pub-3940256099942544/2934735716",
      listener: bannerAdListener,
      request: const AdRequest(),
    );

    bannerAd.load();

    return SizedBox(
      height: 50,
      child: AdWidget(ad: bannerAd),
    );
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   _currentOrientation = MediaQuery.of(context).orientation;
  //   _loadAd();
  // }
  //
  // Future<void> _loadAd() async {
  //   await _anchoredAdaptiveAd?.dispose();
  //   setState(() {
  //     _anchoredAdaptiveAd = null;
  //     _isLoaded = false;
  //   });
  //
  //   final AnchoredAdaptiveBannerAdSize? size =
  //   await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
  //       MediaQuery.of(context).size.width.truncate());
  //
  //   if (size == null) {
  //     print('Unable to get height of anchored banner.');
  //     return;
  //   }
  //
  //   _anchoredAdaptiveAd = BannerAd(
  //     adUnitId: Platform.isAndroid
  //         ? 'ca-app-pub-3940256099942544/6300978111'
  //         : 'ca-app-pub-3940256099942544/2934735716',
  //     size: size,
  //     request: AdRequest(),
  //     listener: BannerAdListener(
  //       onAdLoaded: (Ad ad) {
  //         print('$ad loaded: ${ad.responseInfo}');
  //         setState(() {
  //           // When the ad is loaded, get the ad size and use it to set
  //           // the height of the ad container.
  //           _anchoredAdaptiveAd = ad as BannerAd;
  //           _isLoaded = true;
  //         });
  //       },
  //       onAdFailedToLoad: (Ad ad, LoadAdError error) {
  //         print('Anchored adaptive banner failedToLoad: $error');
  //         ad.dispose();
  //       },
  //     ),
  //   );
  //   return _anchoredAdaptiveAd!.load();
  // }
  //
  // Widget _getAdWidget() {
  //   return OrientationBuilder(
  //     builder: (context, orientation) {
  //       if (_currentOrientation == orientation &&
  //           _anchoredAdaptiveAd != null &&
  //           _isLoaded) {
  //         return Container(
  //           color: Colors.green,
  //           width: _anchoredAdaptiveAd!.size.width.toDouble(),
  //           height: _anchoredAdaptiveAd!.size.height.toDouble(),
  //           child: AdWidget(ad: _anchoredAdaptiveAd!),
  //         );
  //       }
  //       // Reload the ad if the orientation changes.
  //       if (_currentOrientation != orientation) {
  //         _currentOrientation = orientation;
  //         _loadAd();
  //       }
  //       return Container();
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xff480070).withOpacity(0.25),
          drawer: Drawer(
            child: ID == '5' ? Container(
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
              child: ListView(
                children: [
                  UserAccountsDrawerHeader(
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
                      accountName: Text("$NAME"),
                      currentAccountPicture: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 3, color: Colors.white),
                          shape: BoxShape.circle,
                          // image: DecorationImage(
                          //   image: NetworkImage(IMAGEurl),
                          //   fit: BoxFit.fill,
                          //   onError: (exception, stackTrace) {
                          //     Icon(Icons.supervised_user_circle_rounded);
                          //   },

                          // )
                        ),
                        child: ClipOval(
                          child: Image.network(
                            IMAGEurl,
                            fit: BoxFit.fill,
                            errorBuilder:
                                (context, Object exception, StackTrace) {
                              return const Icon(
                                Icons.supervised_user_circle_rounded,
                                size: 20,
                                color: Colors.white,
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {

                              if (loadingProgress == null) return child;
                              return Center(
                                child:
                                    // CircularPercentIndicator(
                                    //   radius: 20.0,
                                    //   lineWidth: 4.0,
                                    //   animation: true,
                                    //   restartAnimation: false,
                                    //   percent: percent/100,
                                    //   center: Text(
                                    //     percent.toString() + "%",
                                    //     style: TextStyle(
                                    //         fontSize: 7.0,
                                    //         fontWeight: FontWeight.w600,
                                    //         color: Colors.white),
                                    //   ),
                                    //   backgroundColor: Colors.black,
                                    //   circularStrokeCap: CircularStrokeCap.round,
                                    //   progressColor: Colors.white,
                                    // )
                                    CircularProgressIndicator(
                                  color: Color(0xffffffff),
                                  backgroundColor: Color(0xff430257),
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ??
                                              0)
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      otherAccountsPictures: [
                        OverlapAvatar(
                            itemCount: 2,
                            insideRadius: 18,

                            ///Determines how much in radius [Default value: 20]
                            outSideRadius: 20,

                            ///[outsideRadius must be gretter then insideRadius]Determines how much in radius [Default value: 24]
                            widthFactor: 0.5,

                            ///  Determines how much in horizontal they should overlap.[Default value: 0.6]
                            backgroundImage: NetworkImage(
                              IMAGEurl,
                            ),
                            backgroundColor: Colors.white),
                        // Container(
                        //   decoration: BoxDecoration(
                        //       shape: BoxShape.circle,
                        //       image: DecorationImage(
                        //           image: NetworkImage(IMAGEurl),
                        //           fit: BoxFit.fill)),
                        // ),
                        // Container(
                        //   decoration: BoxDecoration(
                        //       shape: BoxShape.circle,
                        //       image: DecorationImage(
                        //           image: NetworkImage(IMAGEurl),
                        //           fit: BoxFit.fill)),
                        // ),
                      ],
                      accountEmail: Text("$EMAIL")),
                  Card(
                    color: Color(0xff550077).withOpacity(0.5),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return rename();
                          },
                        ));
                      },
                      title: Text(
                        "Rename Page",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      leading: Icon(Icons.drive_file_rename_outline,
                          color: Colors.white),
                    ),
                  ),
                  Card(
                    color: Color(0xff550077).withOpacity(0.5),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Add_Product();
                          },
                        ));
                      },
                      title: Text(
                        "Add Product",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      leading:
                          Icon(Icons.add_circle_outline, color: Colors.white),
                    ),
                  ),
                  Card(
                    color: Color(0xff550077).withOpacity(0.5),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return HOME();
                          },
                        ));
                      },
                      title: Text(
                        "View Product",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      leading:
                          Icon(Icons.view_agenda_rounded, color: Colors.white),
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
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
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
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
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
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      leading: Icon(Icons.logout, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ) : Container(
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
              child: ListView(
                children: [
                  UserAccountsDrawerHeader(
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
                      accountName: Text("$NAME"),
                      currentAccountPicture: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 3, color: Colors.white),
                          shape: BoxShape.circle,
                          // image: DecorationImage(
                          //   image: NetworkImage(IMAGEurl),
                          //   fit: BoxFit.fill,
                          //   onError: (exception, stackTrace) {
                          //     Icon(Icons.supervised_user_circle_rounded);
                          //   },

                          // )
                        ),
                        child: ClipOval(
                          child: Image.network(
                            IMAGEurl,
                            fit: BoxFit.fill,
                            errorBuilder:
                                (context, Object exception, StackTrace) {
                              return const Icon(
                                Icons.supervised_user_circle_rounded,
                                size: 20,
                                color: Colors.white,
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {

                              if (loadingProgress == null) return child;
                              return Center(
                                child:
                                // CircularPercentIndicator(
                                //   radius: 20.0,
                                //   lineWidth: 4.0,
                                //   animation: true,
                                //   restartAnimation: false,
                                //   percent: percent/100,
                                //   center: Text(
                                //     percent.toString() + "%",
                                //     style: TextStyle(
                                //         fontSize: 7.0,
                                //         fontWeight: FontWeight.w600,
                                //         color: Colors.white),
                                //   ),
                                //   backgroundColor: Colors.black,
                                //   circularStrokeCap: CircularStrokeCap.round,
                                //   progressColor: Colors.white,
                                // )
                                CircularProgressIndicator(
                                  color: Color(0xffffffff),
                                  backgroundColor: Color(0xff430257),
                                  value: loadingProgress.expectedTotalBytes !=
                                      null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ??
                                          0)
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      otherAccountsPictures: [
                        OverlapAvatar(
                            itemCount: 2,
                            insideRadius: 18,

                            ///Determines how much in radius [Default value: 20]
                            outSideRadius: 20,

                            ///[outsideRadius must be gretter then insideRadius]Determines how much in radius [Default value: 24]
                            widthFactor: 0.5,

                            ///  Determines how much in horizontal they should overlap.[Default value: 0.6]
                            backgroundImage: NetworkImage(
                              IMAGEurl,
                            ),
                            backgroundColor: Colors.white),
                        // Container(
                        //   decoration: BoxDecoration(
                        //       shape: BoxShape.circle,
                        //       image: DecorationImage(
                        //           image: NetworkImage(IMAGEurl),
                        //           fit: BoxFit.fill)),
                        // ),
                        // Container(
                        //   decoration: BoxDecoration(
                        //       shape: BoxShape.circle,
                        //       image: DecorationImage(
                        //           image: NetworkImage(IMAGEurl),
                        //           fit: BoxFit.fill)),
                        // ),
                      ],
                      accountEmail: Text("$EMAIL")),
                  Card(
                    color: Color(0xff550077).withOpacity(0.5),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return rename();
                          },
                        ));
                      },
                      title: Text(
                        "Rename Page",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      leading: Icon(Icons.drive_file_rename_outline,
                          color: Colors.white),
                    ),
                  ),
                  // Card(
                  //   color: Color(0xff550077).withOpacity(0.5),
                  //   child: ListTile(
                  //     onTap: () {
                  //       Navigator.push(context, MaterialPageRoute(
                  //         builder: (context) {
                  //           return Add_Product();
                  //         },
                  //       ));
                  //     },
                  //     title: Text(
                  //       "Add Product",
                  //       style: TextStyle(
                  //           fontSize: 16,
                  //           color: Colors.white,
                  //           fontWeight: FontWeight.bold),
                  //     ),
                  //     leading:
                  //     Icon(Icons.add_circle_outline, color: Colors.white),
                  //   ),
                  // ),
                  Card(
                    color: Color(0xff550077).withOpacity(0.5),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return HOME();
                          },
                        ));
                      },
                      title: Text(
                        "View Product",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      leading:
                      Icon(Icons.view_agenda_rounded, color: Colors.white),
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
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
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
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
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
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
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
              "Home",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 19),
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
              stat
                  ? Column(
                      children: [
                        Expanded(
                          child: ListView.separated(itemBuilder: (context, index) {
                            int a = int.parse(l[index].pRICE);
                            var Discount = a - ((a * 10) / 100);

                            if(index!=0 && index % 5 == 0)
                              {
                                return getAd();
                              }
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return Product_details(
                                            l[index], Discount);
                                      },
                                    ));
                                  },
                                  child: Card(
                                    color: Color(0xff550077).withOpacity(0.2),
                                    shadowColor: Color(0xff4d4d4d),
                                    child: Container(
                                      foregroundDecoration:
                                      RotatedCornerDecoration(
                                        color: Color(0xffc40000),
                                        geometry: const BadgeGeometry(
                                            width: 48, height: 48),
                                        textSpan: const TextSpan(
                                          text: 'off\n10%',
                                          style: TextStyle(
                                            fontSize: 10,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.bold,
                                            shadows: [
                                              BoxShadow(
                                                  color: Colors.white,
                                                  blurRadius: 4)
                                            ],
                                          ),
                                        ),
                                      ),
                                      child: ListTile(
                                        title: Text(
                                          l[index].pRODUCTNAME,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          "₹ ${l[index].pRICE}",
                                          style: TextStyle(
                                              color: Color(0xffd3d3d3),
                                              fontSize: 16,
                                              decoration:
                                              TextDecoration.lineThrough),
                                        ),
                                        leading: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: ShapeDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      'https://flutteranadh.000webhostapp.com/${l[index].pHOTO}'),
                                                  fit: BoxFit.fill),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(20)))),
                                        ),
                                        trailing: Padding(
                                          padding:
                                          const EdgeInsets.only(right: 10),
                                          child: Text(
                                            "₹ $Discount",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );

                          }, separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 5,
                                );
                          }, itemCount: l.length,)
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return cart();
                              },
                            ));
                          },
                          child: Container(
                            height: 60,
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: ShapeDecoration(
                                color: Color(0xff730586).withOpacity(0.5),
                                shadows: [
                                  BoxShadow(
                                      blurRadius: 7,
                                      spreadRadius: 1,
                                      offset: Offset(0, 3),
                                      color: Colors.black.withOpacity(0.4))
                                ],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_shopping_cart_outlined,
                                  color: Colors.white,
                                ),
                                Text(
                                  "    Cart",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        color: Color(0xffffffff),
                      ),
                    ),
            ],
          )),
    );
  }
}

class User {
  List<Data>? data;

  User({this.data});

  User.fromJson(Map json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? pRODUCTNAME;
  String? pRICE;
  String? iNVENTORY;
  String? dESCRIPTION;
  String? pHOTO;

  Data(
      {this.id,
      this.pRODUCTNAME,
      this.pRICE,
      this.iNVENTORY,
      this.dESCRIPTION,
      this.pHOTO});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pRODUCTNAME = json['PRODUCT_NAME'];
    pRICE = json['PRICE'];
    iNVENTORY = json['INVENTORY'];
    dESCRIPTION = json['DESCRIPTION'];
    pHOTO = json['PHOTO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['PRODUCT_NAME'] = this.pRODUCTNAME;
    data['PRICE'] = this.pRICE;
    data['INVENTORY'] = this.iNVENTORY;
    data['DESCRIPTION'] = this.dESCRIPTION;
    data['PHOTO'] = this.pHOTO;
    return data;
  }
}


