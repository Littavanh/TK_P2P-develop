import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:p2p/Screens/Account/EditProfile/component/body.dart';
import 'package:p2p/Screens/Account/account.dart';
import 'package:p2p/Screens/HomePage/homePage.dart';
import 'package:p2p/constants.dart';
import 'package:p2p/localization/localization_constants.dart';

class EditProfile extends StatefulWidget {
  // final TabController tabBar;
  EditProfile();

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    print("BACK BUTTON45678!");
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Navigator.pop(context);
    // _onBackPressed(); // It worked for me instead of above line
    print("BACK BUTTON PRofile!"); // Do some stuff.
    return true;
  }

  var myVariable = 0;
  @override
  Widget build(BuildContext context) {
    myVariable = myVariable + 1;
    return Scaffold(
        appBar: AppBar(
          title: Text(getTranslated(context, 'MyProfile')),
          backgroundColor: kPrimaryColor,
        ),
        body: Body());
  }
}
