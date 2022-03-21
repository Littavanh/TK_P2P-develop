import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p2p/Screens/Dashboard/component/dashboardPODO.dart';
import 'package:p2p/Screens/HomePage/homePage.dart';
import 'package:p2p/classes/language.dart';
import 'package:p2p/constants/AppConstant.dart';
import 'package:p2p/constants/Network.dart';
import 'package:p2p/constants/Services.dart';
import 'package:p2p/localization/localization_constants.dart';
import 'package:p2p/main.dart';
import 'package:p2p/routes/route_names.dart';
import 'package:p2p/utils/UIhelper.dart';
import '../../../constants.dart';
import './background.dart';

import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];
  // var data1 = [0.0, -2.0, 3.5, -2.0, 0.5, 0.7, 0.8, 1.0, 2.0, 3.0, 3.2];
  _BodyState();
  bool isLoading = true;
  ResultObject dashData;
  // MyConnectivity _connectivity = MyConnectivity.instance;
  // Map _source = {ConnectivityResult.none: false};
  @override
  void initState() {
    print("Home1");
    super.initState();
    // _connectivity.initialise();
    // _connectivity.myStream.listen((source) {
    //   if (mounted) {
    //     setState(() => _source = source);
    //   }
    // });
    getDashboardData();
  }

  @override
  void dispose() {
    //Connectivity().onConnectivityChanged.dispose();
    // _connectivity.disposeStream();
    super.dispose();
  }

  Material myTextItems(String title, String usaPrice, String thaiPrice) {
    Size size = MediaQuery.of(context).size;
    return Material(
      // color: Color(0xffE5E5E5),
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),

      shadowColor: Color(0x802196F3),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // verticalDirection: VerticalDirection.down,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Center(
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: 2, bottom: 4, left: 20, right: 20),
                          child: Text(
                            title,
                            style: TextStyle(
                                fontSize: 18.0,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold),
                          ))),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      // // verticalDirection: VerticalDirection.up,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            margin: const EdgeInsets.only(left: 0.0),
                            child: Image.asset(
                              "assets/images/usa2.png",
                              width: size.width * 0.06,
                            )),
                        Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              usaPrice,
                              style: TextStyle(
                                  color: kOrangeColor, fontSize: 20.0),
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      // verticalDirection: VerticalDirection.up,
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(left: 0.0),
                          child: Image.asset(
                            "assets/images/thai2.png",
                            width: size.width * 0.06,
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Text(
                              thaiPrice,
                              style: TextStyle(
                                  color: kPrimaryColor, fontSize: 20.0),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }

  Future<void> getDashboardData() async {
    Network().check().then((intenet) async {
      if (intenet != null && intenet) {
        try {
          setState(() {
            isLoading = true;
          });
          final uri = Services.DashboardData;
          print("uriuriuri::: $uri");

          var token = await globalMyLocalPrefes
              .get(AppConstant.ACCESS_TOKEN.toString());
          Map body = {
            "TokenKey": token,
          };
          print("body---2 : $body");
          http.post(Uri.parse(uri), body: body).then((response) async {
            if (response.statusCode == 200) {
              var jsonResponse = jsonDecode(response.body);
              print("Reponse---2 : $jsonResponse");
              DashboardDataPODO dashboarddata =
                  new DashboardDataPODO.fromJson(jsonResponse);
              // print(dashboarddata);
              if (jsonResponse["StatusCode"] == 200) {
                setState(() {
                  dashData = dashboarddata.resultObject;
                  isLoading = false;
                });
                print("dashData:: $dashData");
              } else {
                print(dashboarddata.modelErrors);
                if (dashboarddata.modelErrors == 'Unauthorized') {
                  GetToken().getToken().then((value) {
                    getDashboardData();
                  });
                  // _getNewsList();
                  // Future<String> token = getToken();
                } else {
                  setState(() {
                    isLoading = false;
                  });
                  Fluttertoast.showToast(
                      msg: dashboarddata.modelErrors,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              }
            } else {
              print("response.statusCode.." + response.statusCode.toString());
              setState(() {
                isLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(UIhelper.showSnackbars(
                  "Something wnet wrong.. Please try again later."));
            }
          }, onError: (error) {
            setState(() {
              isLoading = false;
            });
            print("Error == $error");
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: new Text('Something went wrong..'),
              duration: new Duration(seconds: 2),
            ));
          });
        } catch (e) {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(
              msg: "Please try again later.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          print("Error: $e");
          return (e);
        }
      } else {
        // Navigator.pop(context);
        Fluttertoast.showToast(
            msg: "Please check internet connection.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("@@@@@@@@@@@@@@@@@ $dashData");
    return Background(
      child: Column(children: [
        Container(
          margin: EdgeInsets.only(top: size.height * 0.05),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  // margin: EdgeInsets.only(top: size.height * 0.05),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          width: 30,
                          child: IconButton(
                              icon: Icon(FontAwesomeIcons.bell),
                              color: kPrimaryColor,
                              onPressed: () {
                                Navigator.pushNamed(context, notificationRoute);
                              }),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 70),
                          // color: Colors.yellow,
                          child: ClipOval(
                            child: Image.asset(
                              "assets/images/TKS_ERP.png",
                              height: 65,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Container(
                          child: DropdownButton<Language>(
                            underline: SizedBox(),
                            icon: Icon(
                              Icons.language,
                              color: Colors.pink,
                            ),
                            onChanged: (Language language) {
                              _changeLanguage(language);
                            },
                            items: Language.languageList()
                                .map<DropdownMenuItem<Language>>(
                                  (e) => DropdownMenuItem<Language>(
                                    value: e,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Image.asset(
                                          e.flag,
                                          height: 25,
                                        ),
                                        Container(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(e.name)),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                !isLoading
                    ? Container(
                        child: dashData != null
                            ? Column(children: [
                                Container(
                                  margin: EdgeInsets.only(top: 40),
                                  // margin: EdgeInsets.only(top: size.height * 0.1),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: myTextItems(
                                          getTranslated(context, "BuyingRate"),
                                          dashData.buyUsd != null
                                              ? dashData.buyUsd.toString()
                                              : "-",
                                          dashData.buyBaht != null
                                              ? dashData.buyBaht.toString()
                                              : "-",
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: myTextItems(
                                            getTranslated(
                                                context, "SellingRate"),
                                            dashData.sellUsd != null
                                                ? dashData.sellUsd.toString()
                                                : "-",
                                            dashData.sellBaht != null
                                                ? dashData.sellBaht.toString()
                                                : "-",
                                          )),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 30, left: 20, right: 20),
                                  // margin: EdgeInsets.only(top: size.height * 0.2),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          _buildStatCard(
                                              'PO Transactions',
                                              getTranslated(
                                                  context, 'TotalBudget'),
                                              dashData.pOTotalBudget != null
                                                  ? dashData.pOTotalBudget
                                                      .toString()
                                                  : "-",
                                              Colors.orange),
                                          _buildStatCard(
                                              'PO Transactions',
                                              getTranslated(
                                                  context, 'Outstanding'),
                                              dashData.pOOutStanding != null
                                                  ? dashData.pOOutStanding
                                                      .toString()
                                                  : "-",
                                              Colors.deepPurple),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          _buildStatCard(
                                              'Non-PO Transactions',
                                              getTranslated(
                                                  context, 'TotalBudget'),
                                              dashData.nonPOTotalBudget != null
                                                  ? dashData.nonPOTotalBudget
                                                      .toString()
                                                  : "-",
                                              Colors.green),
                                          _buildStatCard(
                                              'Non-PO Transactions',
                                              getTranslated(
                                                  context, 'Expenses'),
                                              dashData.nonPOExpense != null
                                                  ? dashData.nonPOExpense
                                                      .toString()
                                                  : "-",
                                              Colors.blue),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ])
                            : Container(
                                margin: EdgeInsets.only(top: size.height * 0.2),
                                child: Text(
                                  "No Data!!!",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ))
                    : Container(
                        margin: EdgeInsets.only(top: size.height * 0.2),
                        child: Center(child: CircularProgressIndicator())),
              ],
            ),
          ),
        ),
      ]),
      // ),
    );
  }

  Expanded _buildStatCard(
      String title, String subtitle, String count, MaterialColor color) {
    return Expanded(
        child: Container(
            margin: const EdgeInsets.all(7.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    subtitle,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                  child: Text(count,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            )));
  }
}
