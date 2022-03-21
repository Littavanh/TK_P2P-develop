import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:p2p/Screens/Approval/approval.dart';
import 'package:p2p/Screens/HomePage/homePage.dart';
import 'package:p2p/constants/Services.dart';
import 'package:p2p/localization/localization_constants.dart';
// import 'package:toast/toast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:p2p/routes/route_names.dart';

class ApprovalAction extends StatefulWidget {
  final String actionText;
  final Map actionData;
  ApprovalAction(
      {Key key, @required this.actionText, @required this.actionData})
      : super(key: key);

  @override
  _ApprovalActionState createState() =>
      _ApprovalActionState(actionText, actionData);
}

class _ApprovalActionState extends State<ApprovalAction>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;
  String actionText;
  Map actionData;

  bool isLoading;
  _ApprovalActionState(this.actionText, this.actionData);

  @override
  void initState() {
    Map body = widget.actionData;
    print(body);
    //_submitAction(body);
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeInToLinear);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  Future<void> _submitAction(body) async {
    print('$body');

    setState(() {
      isLoading = true;
    });

    String uri = Services.ApprovalStatus;

    http.post(Uri.parse(uri), body: body).then((response) {
      var jsonResponse = jsonDecode(response.body);
      // MyRequests myRequest = new MyRequests.fromJson(jsonResponse);
      if (jsonResponse["StatusCode"] == 200) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(
            msg: "Status successfully updated to ${widget.actionText} !",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        print("j&&& $jsonResponse");
        Navigator.pushNamed(context, homeRoute);
      } else {
        print("ModelError: ${jsonResponse["ModelErrors"]}");
        if (jsonResponse["ModelErrors"] == 'Unauthorized') {
          GetToken().getToken().then((value) {});
        } else {
          Fluttertoast.showToast(
              msg: "Please check internet connection!!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(15.0),
              height: 180.0,
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(
                              top: 18.0, left: 0.0, right: 0.0),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: new TextSpan(
                              // Note: Styles for TextSpans must be explicitly defined.
                              // Child text spans will inherit styles from parent
                              style: new TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                new TextSpan(
                                    text: getTranslated(
                                        context, "AreYouSureYouWantTo")),
                                new TextSpan(
                                    text: '${widget.actionText}',
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold)),
                                new TextSpan(
                                    text: getTranslated(context, "ThisOrder")),
                              ],
                            ),
                          ))),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ButtonTheme(
                            height: 35.0,
                            minWidth: 110.0,
                            child: ElevatedButton(
                                onPressed: () => {Navigator.pop(context)},
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.red)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    getTranslated(context, 'No'),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                )),
                          )),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 10.0, top: 10.0, bottom: 10.0),
                          child: ButtonTheme(
                              height: 35.0,
                              minWidth: 110.0,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.green)),
                                child: Text(
                                  getTranslated(context, 'Yes'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      backgroundColor: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0),
                                ),
                                onPressed: () {
                                  Map body = widget.actionData;
                                  _submitAction(body);
                                },
                              ))),
                    ],
                  ))
                ],
              )),
        ),
      ),
    );
  }
}
