import 'package:flutter/material.dart';
import 'package:p2p/components/textWithIcon.dart';
import 'package:p2p/constants.dart';
import 'package:p2p/constants/AppConstant.dart';
import 'package:p2p/main.dart';
import './background.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String emailId = globalMyLocalPrefes.getString(AppConstant.LoginGmailID);
    String fname = globalMyLocalPrefes.getString(AppConstant.FIRST_NAME);
    String lname = globalMyLocalPrefes.getString(AppConstant.LAST_NAME);
    String dptname = globalMyLocalPrefes.getString(AppConstant.DEPTNAME);
    String phone = globalMyLocalPrefes.getString(AppConstant.PHONENO);
    String businame = globalMyLocalPrefes.getString(AppConstant.BUSNAME);

    String img = globalMyLocalPrefes.getString(AppConstant.IMAGE);

    return Background(
      child: Container(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                width: 100.0,
                height: 100.0,
                margin: const EdgeInsets.all(20.0),
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/profile.png")))),

            TextWithIcon(
                textIcon: Icons.person,
                textValue:
                    (fname != "null" || fname != null) ? "$fname $lname" : "--",
                iconColor: kPrimaryColor),
            TextWithIcon(
                textIcon: Icons.email,
                textValue: emailId,
                iconColor: Colors.amber),

            TextWithIcon(
                textIcon: Icons.assignment_ind,
                textValue:
                    (dptname != "null" || dptname != null) ? dptname : "--",
                iconColor: Colors.blue[500]),
            TextWithIcon(
                textIcon: Icons.business,
                textValue:
                    (businame != "null" || businame != null) ? businame : "--",
                iconColor: Colors.green),
            TextWithIcon(
                textIcon: Icons.account_balance,
                textValue:
                    (dptname != "null" || dptname != null) ? dptname : "--",
                iconColor: Colors.blue[800]),
            TextWithIcon(
                textIcon: Icons.phone,
                textValue: (phone != "null" || phone != null) ? "--" : phone,
                iconColor: Colors.red),

            // SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }
}
