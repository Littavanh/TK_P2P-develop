import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p2p/Screens/Account/component/body.dart';
import 'package:p2p/classes/language.dart';
import 'package:p2p/localization/localization_constants.dart';
import 'package:p2p/main.dart';
import 'package:p2p/routes/route_names.dart';
import '../../constants.dart';

class Account extends StatefulWidget {
  // final TabController tabBar;
  Account();

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }

  var myVariable = 0;

  @override
  Widget build(BuildContext context) {
    myVariable = myVariable + 1;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(getTranslated(context, 'MyAccount')),
        backgroundColor: kPrimaryColor,
        shadowColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.bell),
            color: kWhiteColor,
            onPressed: () {
              Navigator.pushNamed(context, notificationRoute);
            }),
        actions: <Widget>[
          Padding(
            // margin: EdgeInsets.only(left: 0),
            padding: const EdgeInsets.all(8.0),
            // width: 50,
            // color: Colors.pink,
            child: DropdownButton<Language>(
              underline: SizedBox(),
              icon: Icon(
                Icons.language,
                color: Colors.white,
              ),
              onChanged: (Language language) {
                _changeLanguage(language);
              },
              items: Language.languageList()
                  .map<DropdownMenuItem<Language>>(
                    (e) => DropdownMenuItem<Language>(
                      value: e,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
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
        ],
      ),
      body: Body(),
    );
  }
}
