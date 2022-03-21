import 'package:flutter/material.dart';
import 'package:p2p/localization/localization_constants.dart';
import './component/body.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          content: Text(getTranslated(context, 'Tapbackagaintoleave')),
        ),
        child: Body(),
      ),
    );
  }
}
