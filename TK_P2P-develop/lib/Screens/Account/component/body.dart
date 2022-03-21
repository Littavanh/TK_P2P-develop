import 'package:flutter/material.dart';
import 'package:p2p/Screens/Account/EditProfile/editProfile.dart';
import 'package:p2p/components/LogoutOverlay.dart';
// import 'package:p2p/components/langDiaBox.dart';
import 'package:p2p/constants.dart';
import 'package:p2p/constants/AppConstant.dart';
import 'package:p2p/localization/localization_constants.dart';
import 'package:p2p/main.dart';
import 'package:p2p/routes/route_names.dart';
import './background.dart';
import 'package:p2p/classes/language.dart';

class Body extends StatefulWidget {
  final Widget thumbnail;
  const Body({
    Key key,
    this.thumbnail,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  void _changeLanguage(Language language) async {
    print(language.languageCode);
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String fname = globalMyLocalPrefes.getString(AppConstant.FIRST_NAME);
    String lname = globalMyLocalPrefes.getString(AppConstant.LAST_NAME);
    String depname = globalMyLocalPrefes.getString(AppConstant.DEPTNAME);

    return Background(
      child: Container(
        constraints: BoxConstraints.expand(
          height: Theme.of(context).textTheme.headline4.fontSize * 1.1 + 350.0,
        ),
        margin: const EdgeInsets.all(10.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView(
                  children: <Widget>[
                    Container(
                      child: ListTile(
                        leading: Container(
                            width: 80.0,
                            // height: 100.0,
                            // padding: const EdgeInsets.all(10.0),
                            decoration: new BoxDecoration(
                                // shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.contain,
                                    image: AssetImage(
                                        "assets/images/profile.png")))),
                        title: Text('$fname $lname'),
                        subtitle: Text('$depname'),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.person,
                          color: kOrangeColor,
                        ),
                        title: Text(getTranslated(context, 'MyProfile')),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          Navigator.of(context)
                              .push(new MaterialPageRoute(builder: (context) {
                            return new EditProfile();
                          }));
                        },
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.vpn_key,
                          color: Colors.green,
                        ),
                        title: Text(getTranslated(context, 'ChangePassword')),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          Navigator.pushNamed(context, changePasswordRoute);
                        },
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.exit_to_app,
                          color: Colors.redAccent,
                        ),
                        title: Text(getTranslated(context, 'Logout')),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => LogoutOverlay(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }
}
