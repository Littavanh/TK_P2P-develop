import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:p2p/Screens/Login/component/loginResponse.dart';
import 'package:p2p/components/forgetPassword.dart';
import 'package:p2p/constants.dart';
import 'package:p2p/constants/AppConstant.dart';
import 'package:p2p/constants/Network.dart';
import 'package:p2p/constants/Services.dart';
import 'package:p2p/localization/localization_constants.dart';
import 'package:p2p/main.dart';
import 'package:p2p/routes/route_names.dart';
import 'package:p2p/utils/UIhelper.dart';
// import 'package:toast/toast.dart';
import './background.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _email, _password;
  String _errorMessage = "";
  bool isLoading = false;
  final focus = FocusNode();
  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // SharedPreferences sharedPreferences;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String token = '';
  @override
  void initState() {
    isLoading = false;
    print("LOGINHHHHHH");
    generateTocken();
    super.initState();
  }

  void generateTocken() async {
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
  }

  Future<void> _handleSubmitted() async {
    if (_formKey.currentState.validate()) {
      UIhelper.dismissKeyboard(context);
      getToken();
    } else {
      print("Els");
    }
  }

  Future<void> getToken() async {
    Network().check().then((intenet) async {
      if (intenet != null && intenet) {
        // sharedPreferences = await SharedPreferences.getInstance();

        try {
          setState(() {
            isLoading = true;
          });
          final uri = Services.LOGIN;
          Map body = {
            "PassKey": "a486f489-76c0-4c49-8ff0-d0fdec0a162b",
            "UserName": usernameController.text.trim(),
            "UserPassword": passwordController.text.trim(),
            "TokenDevice": token.toString()
          };
          print("BODY: $body");

          print('[Login] URL: ${uri}; Body: ${body.toString()}');

          http.post(Uri.parse(uri), body: body).then((response) async {
            if (response.statusCode == 200) {
              var jsonResponse = jsonDecode(response.body);
              print("Reponse---2 : $jsonResponse");
              if (jsonResponse["StatusCode"] == 200) {
                ResultObject login =
                    new ResultObject.fromJson(jsonResponse["ResultObject"][0]);

                print("login.tokenKey: ${login.tokenKey}");
                await globalMyLocalPrefes.setInt(
                    AppConstant.USER_ID.toString(), login.userId);

                await globalMyLocalPrefes.setInt(
                    AppConstant.DEPARTMENT.toString(), login.departmentId);
                await globalMyLocalPrefes.setInt(
                    AppConstant.BUSINESSID.toString(), login.businessUnitId);

                await globalMyLocalPrefes.setString(
                    AppConstant.ACCESS_TOKEN, login.tokenKey);
                await globalMyLocalPrefes.setString(
                    AppConstant.FIRST_NAME, login.firstName);

                await globalMyLocalPrefes.setString(
                    AppConstant.LAST_NAME, login.lastName);
                await globalMyLocalPrefes.setString(
                    AppConstant.BUSNAME, login.businessUnitName);
                await globalMyLocalPrefes.setString(
                    AppConstant.DEPTNAME, login.departmentName);
                await globalMyLocalPrefes.setString(AppConstant.IMAGE,
                    login.photoPath == null ? "null" : login.photoPath);
                await globalMyLocalPrefes.setString(AppConstant.PHONENO,
                    login.mobile == null ? "null" : login.mobile);
                await globalMyLocalPrefes.setString(
                    AppConstant.EMAIL, login.email);
                await globalMyLocalPrefes.setString(
                    AppConstant.LoginGmailID, usernameController.text.trim());
                await globalMyLocalPrefes.setString(
                    AppConstant.PASSWORD, passwordController.text.trim());

                // sharedPreferences.setString(AppConstant.EMP_ID, login.emp_no);
//  Navigator.pushReplacementNamed(context, homeRoute);
                setState(() {
                  isLoading = false;
                });
                Navigator.pushNamedAndRemoveUntil(
                    context, homeRoute, ModalRoute.withName(homeRoute));
              } else {
                setState(() {
                  isLoading = false;
                });

                _scaffoldKey.currentState.showSnackBar(UIhelper.showSnackbars(
                    "Something wnet wrong.. Please try again later."));
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    // ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    // ScreenUtil.instance =
    //     ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: isLoading
            ? Container(
                color: Colors.black87,
                child: Center(child: CircularProgressIndicator()))
            : Background(
                child: SingleChildScrollView(
                    child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // SizedBox(height: size.height * 0.03),
                      Image.asset(
                        "assets/images/logo-pa.png",
                        height: size.height * 0.25,
                        width: 250,
                      ),
                      // SizedBox(height: size.height * 0.03),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(29),
                          border: Border.all(
                            color: kGreyLightColor,
                            width: 1,
                          ),
                        ),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          autofocus: true,
                          maxLength: 30,
                          controller: usernameController,
                          buildCounter: (BuildContext context,
                                  {int currentLength,
                                  int maxLength,
                                  bool isFocused}) =>
                              null,
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.email_rounded,
                                color: kOrangeColor,
                              ),
                              // hintText: hintText,
                              border: InputBorder.none,
                              hintText: getTranslated(context, "YourEmail"),
                              hintStyle: TextStyle(
                                  color: Colors.grey, fontSize: 15.0)),
                          validator: (value) =>
                              value.isEmpty ? 'Email Id can\'t be empty' : null,
                          onSaved: (value) => _email = value.trim(),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(29),
                          border: Border.all(
                            color: kGreyLightColor,
                            width: 1,
                          ),
                        ),
                        child: TextFormField(
                          obscureText: true,
                          cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                            hintText: getTranslated(context, "Password"),
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 15.0),
                            icon: Icon(
                              Icons.vpn_key,
                              color: kPrimaryColor,
                            ),
                            border: InputBorder.none,
                          ),
                          controller: passwordController,
                          autofocus: true,
                          // maxLength: 20,
                          focusNode: focus,
                          validator: (value) =>
                              value.isEmpty ? 'Password can\'t be empty' : null,
                          onSaved: (value) => _password = value,
                        ),
                      ),
                      // RoundedButton(
                      //   text: getTranslated(context, "Login"),
                      //   press: () {
                      //     Navigator.pushReplacementNamed(context, homeRoute);
                      //   },
                      // ),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        width: size.width * 0.8,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: FlatButton.icon(
                            padding: EdgeInsets.symmetric(
                                vertical: 13, horizontal: 0),
                            color: kPrimaryColor,
                            onPressed: () {
                              _handleSubmitted();
                            },
                            icon: Icon(
                              Icons.arrow_forward,
                              color: kWhiteColor,
                            ),
                            label: Text(
                              getTranslated(context, "Login"),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      ForgetPassword(
                        press: () {
                          Navigator.pushReplacementNamed(context, homeRoute);
                        },
                      ),
                      // SizedBox(height: size.height * 0.01),
                      Image.asset(
                        "assets/images/login-bg.png",
                        height: size.height * 0.40,
                      ),
                    ],
                  ),
                )),
              ));
  }
}
