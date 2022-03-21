import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p2p/Screens/Approval/component/body.dart';
import 'package:p2p/Screens/NotificationPage/notification-page.dart';
import 'package:p2p/constants.dart';
import 'package:p2p/localization/localization_constants.dart';

class Approval extends StatefulWidget {
  @override
  _ApprovalState createState() => _ApprovalState();
}

class _ApprovalState extends State<Approval> {
  var titleLabel = 'Text label';
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        // drawer: NavDrawer(),
        appBar: AppBar(
          title: Text(getTranslated(context, 'Approval')),
          backgroundColor: kPrimaryColor,
          shadowColor: Colors.transparent,
          automaticallyImplyLeading: false,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(FontAwesomeIcons.bell),
                color: kWhiteColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotificationPage()),
                  );
                }),
          ],
        ),
        body: Body(),
      ),
    );
  }
}
