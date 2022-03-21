import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:p2p/Screens/HomePage/homePage.dart';
import 'package:p2p/Screens/Login/login-page.dart';
import 'package:p2p/constants/AppConstant.dart';
import 'package:p2p/main.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      Timer(Duration(seconds: 5), () {
        _loadUserInfo();
      });
    }
  }

  _loadUserInfo() async {
    String token = globalMyLocalPrefes.getString(AppConstant.ACCESS_TOKEN);

    print("token 345 $token");
    if (token == null) {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (BuildContext context) => LoginScreen()));
    } else if (token != null) {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (BuildContext context) => HomePage(
                currentIndex: 0,
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              "assets/images/TKS_ERP.png",
              height: 100,
            ),
            Container(
              padding: const EdgeInsets.only(top: 80),
              child: SpinKitThreeBounce(
                color: Colors.blue,
                size: 30.0,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
