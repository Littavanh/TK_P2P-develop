import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p2p/Screens/CashFlow/BalSummary/bal-summary.dart';
import 'package:p2p/Screens/CashFlow/CFCompare/cf-compare.dart';
import 'package:p2p/Screens/CashFlow/CFTrend/cf-trend.dart';
import 'package:p2p/localization/localization_constants.dart';
import 'package:p2p/routes/route_names.dart';

import '../../constants.dart';

class CashFlow extends StatefulWidget {
  @override
  _CashFlowState createState() => _CashFlowState();
}

class _CashFlowState extends State<CashFlow> {
  var myVariable = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   BackButtonInterceptor.add(myInterceptor);
  // }

  // @override
  // void dispose() {
  //   print("BACK BUTTON45678!");
  //   BackButtonInterceptor.remove(myInterceptor);
  //   super.dispose();
  // }

  // bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
  //   // Navigator.pop(context);
  //   print("BACK BUTTON!"); // Do some stuff.
  //   return true;
  // }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          automaticallyImplyLeading: false,
          elevation: 0,
          bottom: TabBar(
            labelColor: kPrimaryColor,
            unselectedLabelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Colors.white),
            tabs: [
              Tab(text: 'Bal Summary'),
              Tab(text: 'CF Trend'),
              Tab(text: 'CF Compare'),
            ],
          ),
          title: Text(getTranslated(context, 'CashFlow')),
          shadowColor: Colors.white,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(FontAwesomeIcons.bell),
                color: kWhiteColor,
                onPressed: () {
                  Navigator.pushNamed(context, notificationRoute);
                }),
          ],
        ),
        body: TabBarView(
          children: [
            BalSummary(),
            CFTrend(),
            CFCompare(),
          ],
        ),
      ),
    );
  }
}
