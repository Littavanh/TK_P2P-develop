import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p2p/Screens/Account/account.dart';
import 'package:p2p/Screens/Approval/approval.dart';
import 'package:p2p/Screens/CashFlow/cashFlow.dart';
import 'package:p2p/Screens/Dashboard/dashboard-page.dart';
import 'package:p2p/Screens/Login/component/loginResponse.dart';
import 'package:p2p/constants.dart';
import 'package:p2p/constants/AppConstant.dart';
import 'package:p2p/constants/Network.dart';
import 'package:p2p/constants/Services.dart';
import 'package:p2p/localization/localization_constants.dart';
import 'package:p2p/main.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  final int currentIndex;
  HomePage({Key key, @required this.currentIndex}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(currentIndex);
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final List<Widget> _children = [
    Dashboard(),
    Approval(),
    // CashFlow(),
    Account()
  ];
  _HomePageState(this.currentIndex);
  // Map _source = {ConnectivityResult.none: false};
  // MyConnectivity _connectivity = MyConnectivity.instance;

  @override
  void initState() {
    print("Home1");
    super.initState();
    // _connectivity.initialise();
    // _connectivity.myStream.listen((source) {
    //   setState(() => _source = source);
    // });
  }

  @override
  void dispose() {
    print("Home3");

    // _connectivity.disposeStream();
    super.dispose();
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Home");

    return WillPopScope(
        onWillPop: () async => false,
        child: Align(
            alignment: Alignment.bottomLeft, // and bottomLeft
            child: SafeArea(
                bottom: true,
                top: false,
                child: DefaultTabController(
                  length: 3,
                  child: Scaffold(
                      body: _children[currentIndex], // new
                      bottomNavigationBar: new Theme(
                        data: Theme.of(context).copyWith(
                            // sets the background color of the `BottomNavigationBar`
                            canvasColor: kWhiteColor,
                            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
                            primaryColor: Colors.red,
                            textTheme: Theme.of(context).textTheme.copyWith(
                                caption: new TextStyle(
                                    color: Colors
                                        .yellow))), // sets the inactive color of the `BottomNavigationBar`
                        child: BottomNavigationBar(
                          type: BottomNavigationBarType.fixed,
                          selectedItemColor: kPrimaryColor,
                          unselectedItemColor: kGreyLightColor,
                          onTap: onTabTapped, // new
                          currentIndex: currentIndex, // new
                          items: [
                            new BottomNavigationBarItem(
                              icon: Icon(Icons.home),
                              label: getTranslated(context, 'Home'),
                            ),
                            new BottomNavigationBarItem(
                              icon: Icon(Icons.check_circle),
                              label: getTranslated(context, 'Approval'),
                            ),
                            // new BottomNavigationBarItem(
                              
                            //   icon: Icon(FontAwesomeIcons.chartLine),
                            //   label: getTranslated(context, 'CashFlow') ,
                              
                              
                            // ),
                            new BottomNavigationBarItem(
                              icon: Icon(Icons.person),
                              label: getTranslated(context, 'Account'),
                            ),
                          ],
                        ),
                      )),
                ))));
  }
}

class GetToken {
  Future<void> getToken() async {
    Network().check().then((intenet) async {
      if (intenet != null && intenet) {
        String username =
            globalMyLocalPrefes.getString(AppConstant.LoginGmailID);
        String password = globalMyLocalPrefes.getString(AppConstant.PASSWORD);
        print("New token:");
        try {
          final uri = Services.LOGIN;
          Map body = {
            "PassKey": "a486f489-76c0-4c49-8ff0-d0fdec0a162b",
            "UserName": username,
            "UserPassword": password
          };
          print("New token: $body");
          http.post(Uri.parse(uri), body: body).then((response) async {
            if (response.statusCode == 200) {
              var jsonResponse = jsonDecode(response.body);
              if (jsonResponse["StatusCode"] == 200) {
                ResultObject login =
                    new ResultObject.fromJson(jsonResponse["ResultObject"][0]);

                print("login.tokenKey: ${login.tokenKey}");
                print("userId---3 : ${login.userId}");

                await globalMyLocalPrefes.setInt(
                    AppConstant.USER_ID.toString(), login.userId);

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
                return login.tokenKey;
              } else {
                return "Something wnet wrong.. Please try again later.";
              }
            } else {
              print("response.statusCode.." + response.statusCode.toString());

              return "Something wnet wrong.. Please try again later.";
            }
          });
        } catch (e) {
          print("Error: $e");
          return (e);
        }
      } else {
        return "Please check internet connection";
      }
    });
  }
}
