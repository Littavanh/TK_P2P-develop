import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p2p/Screens/Approval/ApprovalDetails/approval-details.dart';
import 'package:p2p/Screens/HomePage/homePage.dart';
import 'package:p2p/Screens/NotificationPage/component/notiPODO.dart';
import 'package:p2p/constants.dart';
import 'package:p2p/constants/AppConstant.dart';
import 'package:p2p/constants/Network.dart';
import 'package:p2p/constants/Services.dart';
import 'package:p2p/main.dart';
import 'package:p2p/utils/UIhelper.dart';
import 'package:http/http.dart' as http;

import './background.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  _BodyState();
  bool isLoading = true;
  List<NotiResultObject> notiLists;
  String noDataTxt = "";

  @override
  void initState() {
    super.initState();
    getNotiData();
  }

  void _goToDetails(BuildContext context1, approveData) {
    String jsonUser = jsonEncode(approveData);
    print(jsonUser);

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ApprovalDetails(
            appData: jsonUser,
          ),
        ));
  }

  Future<void> getNotiData() async {
    Network().check().then((intenet) async {
      if (intenet != null && intenet) {
        try {
          setState(() {
            isLoading = true;
          });
          final uri = Services.NotificationList;
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
              NotiPodo notiResponse = new NotiPodo.fromJson(jsonResponse);
              // print(notiResponse);
              if (jsonResponse["StatusCode"] == 200) {
                setState(() {
                  notiLists = notiResponse.resultObject;
                  isLoading = false;
                });
                print("notiLists:: $notiLists");
              } else {
                print(notiResponse.modelErrors);
                if (jsonResponse["ModelErrors"] == 'Unauthorized') {
                  GetToken().getToken().then((value) {
                    getNotiData();
                  });
                } else if (jsonResponse["ModelErrors"] == 'Data Not Fount') {
                  setState(() {
                    isLoading = false;
                  });
                  noDataTxt = jsonResponse["ModelErrors"];
                } else {
                  setState(() {
                    isLoading = false;
                  });
                  Fluttertoast.showToast(
                      msg: notiResponse.modelErrors,
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

  Widget notiDetailCard(notiItem) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: new BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.1),
            blurRadius: 20.0, // soften the shadow
            spreadRadius: 0.0, //extend the shadow
            offset: Offset(
              5.0, // Move to right 10  horizontally
              5.0, // Move to bottom 10 Vertically
            ),
          )
        ],
      ),
      padding: new EdgeInsets.only(left: 5.0, right: 5.0, top: 10),
      child: new Card(
        elevation: 0,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                FontAwesomeIcons.bell,
                size: 20,
                color: kOrangeColor,
              ),
            ),
            Container(
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: size.width * 0.58,
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        notiItem.appNo != null
                            ? Text(
                                notiItem.appNo,
                                style: new TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold),
                              )
                            : Container(),
                        notiItem.businessUnitName != null
                            ? Text(
                                "${notiItem.businessUnitName} (${notiItem.appType})",
                                style: new TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold),
                              )
                            : Container(),

                        notiItem.totalAmount != null
                            ? Text(
                                "Total: ${notiItem.totalAmount} ${notiItem.currencyName}",
                                style: new TextStyle(
                                  fontSize: 13.0,
                                ),
                              )
                            : Container(),

                        notiItem.appStatus != null
                            ? Text(
                                "Status: ${notiItem.appStatus}",
                                style: new TextStyle(
                                  fontSize: 13.0,
                                ),
                              )
                            : Container(),

                        // new Placeholder(),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        notiItem.appDate != null
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, right: 8),
                                child: Text(
                                  notiItem.appDate,
                                  style: new TextStyle(),
                                ),
                              )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, right: 8),
                          child: notiItem.appStatus != null
                              ? Text(
                                  notiItem.appStatus,
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: kGreyLightColor),
                                )
                              : Container(),
                        ),
                        notiItem.appStatus != "Approved"
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: SizedBox(
                                  width: 90,
                                  height: 30.0,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(0),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.green),
                                        shadowColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.green)),
                                    onPressed: () {
                                      _goToDetails(context, notiItem);
                                    },
                                    child: Text("Action".toUpperCase(),
                                        style: TextStyle(fontSize: 14)),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ), // new Placeholder(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        child: Column(
      children: [
        !isLoading
            ? Expanded(
                // child: Background(
                child: notiLists.length != 0
                    ? ListView(
                        padding: const EdgeInsets.all(8),
                        children: <Widget>[
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: notiLists.map((p) {
                                print(p.toString());
                                return notiDetailCard(p);
                              }).toList()),
                          SizedBox(
                            height: 50,
                          )
                        ],
                      )
                    : Center(child: Text(noDataTxt))
                // ),
                )
            : Container(
                margin: EdgeInsets.only(top: size.height * 0.2),
                child: Center(child: CircularProgressIndicator())),
      ],
    ));
  }
}
