import 'package:flutter/material.dart';
import 'package:p2p/Screens/NotificationPage/component/body.dart';
import 'package:p2p/constants.dart';
import 'package:p2p/localization/localization_constants.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'Notification')),
        shadowColor: Colors.transparent,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: Body(),
    );
  }
}
