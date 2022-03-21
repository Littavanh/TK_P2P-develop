import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:p2p/Screens/Account/component/background.dart';
import 'package:p2p/Screens/ChangePAssword/changePassPODO.dart';
import 'package:p2p/Screens/HomePage/homePage.dart';
import 'package:p2p/constants/AppConstant.dart';
import 'package:p2p/constants/Network.dart';
import 'package:p2p/constants/Services.dart';
import 'package:p2p/main.dart';
import 'package:http/http.dart' as http;
import 'package:p2p/routes/route_names.dart';
import 'package:p2p/utils/UIhelper.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _curPassVisible = false;
  bool _newPassVisible = false;
  bool _confirmPassVisible = false;

  String errorTxt;

  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController curPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Background(
          child: !isLoading
              ? Container(
                  // padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 15),
                          child: Image(
                            image: AssetImage('assets/images/lock.png'),
                            height: 130,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: TextField(
                            obscureText: !_curPassVisible,
                            controller: curPassController,
                            decoration: InputDecoration(
                              labelText: 'Current Password',
                              border: OutlineInputBorder(),
                              hintText: 'Enter your current password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _curPassVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).hintColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _curPassVisible = !_curPassVisible;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: TextField(
                            obscureText: !_newPassVisible,
                            controller: newPassController,
                            decoration: InputDecoration(
                              labelText: 'New Password',
                              border: OutlineInputBorder(),
                              hintText: 'Enter new password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _newPassVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).hintColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _newPassVisible = !_newPassVisible;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: TextFormField(
                            obscureText: !_confirmPassVisible,
                            controller: confirmPassController,
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              border: OutlineInputBorder(),
                              hintText: 'Enter confirm password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _confirmPassVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).hintColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _confirmPassVisible = !_confirmPassVisible;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        errorTxt != null
                            ? Center(
                                child: Container(
                                  child: Text(
                                    errorTxt,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              )
                            : Container(),
                        Container(
                            height: 75,
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: ElevatedButton(
                              child: Text('Submit'),
                              onPressed: () {
                                if (confirmPassController.text.trim() !=
                                    newPassController.text.trim()) {
                                  setState(() {
                                    errorTxt =
                                        "New password & confirm password do not match !";
                                  });
                                } else {
                                  setState(() {
                                    errorTxt = null;
                                  });
                                  submitPass();
                                }
                              },
                            )),
                      ],
                    ),
                  ),
                )
              : Container(child: Center(child: CircularProgressIndicator()))),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: const Text(
            'Success!',
            style: TextStyle(color: Colors.green, fontSize: 18),
          )),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Center(
                  child: Text(
                      'Password changed successfully. Click OK and login again with new password.'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                child: const Text(
                  'OK',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, loginRoute, ModalRoute.withName(loginRoute));
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> submitPass() async {
    Network().check().then((intenet) async {
      if (intenet != null && intenet) {
        // sharedPreferences = await SharedPreferences.getInstance();

        try {
          setState(() {
            isLoading = true;
          });
          final uri = Services.ChangePassword;
          var token = await globalMyLocalPrefes
              .get(AppConstant.ACCESS_TOKEN.toString());
          Map body = {
            "TokenKey": token,
            "OldPassword": curPassController.text.trim(),
            "NewPassword": newPassController.text.trim()
          };
          print("BODY: $body");

          http.post(Uri.parse(uri), body: body).then((response) async {
            if (response.statusCode == 200) {
              var jsonResponse = jsonDecode(response.body);
              print("Reponse---2 : $jsonResponse");
              ChangePasswordPODO changepass =
                  new ChangePasswordPODO.fromJson(jsonResponse);
              print(changepass);
              if (jsonResponse["StatusCode"] == 200) {
                setState(() {
                  isLoading = false;
                });
                _showMyDialog();
              } else {
                if (changepass.modelErrors == 'Unauthorized') {
                  GetToken().getToken().then((value) {
                    submitPass();
                  });
                  // _getNewsList();
                  // Future<String> token = getToken();
                } else {
                  setState(() {
                    isLoading = false;
                  });
                  Fluttertoast.showToast(
                      msg: changepass.modelErrors,
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
        Navigator.pop(context);
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
}
