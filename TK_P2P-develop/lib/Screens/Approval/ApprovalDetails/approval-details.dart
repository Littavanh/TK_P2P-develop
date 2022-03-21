import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:p2p/Screens/Approval/ApprovalDetails/component/body.dart';
import 'package:p2p/localization/localization_constants.dart';
import 'dart:convert';

import '../../../constants.dart';

class ApprovalDetails extends StatefulWidget {
  final String appData;
  ApprovalDetails({Key key, this.appData}) : super(key: key);

  @override
  _ApprovalDetailsState createState() => _ApprovalDetailsState(appData);
}

class _ApprovalDetailsState extends State<ApprovalDetails> {
  String appData;
  _ApprovalDetailsState(this.appData);
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
    print("BACK BUTTON!"); // Do some stuff.
    return true;
  }

  @override
  Widget build(BuildContext context) {
    String jsonUser = jsonEncode(appData);

    // print(appData);
    return Scaffold(
        appBar: AppBar(
          // title: Text(jsonUser['title']),
          title: Text(getTranslated(context, 'ApprovalDetails')),
          backgroundColor: kPrimaryColor,
          shadowColor: Colors.transparent,
          centerTitle: true,
        ),
        body: Body(jsonUser: jsonUser));
  }
}
