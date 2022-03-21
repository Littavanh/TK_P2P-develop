import 'package:flutter/material.dart';
import 'package:p2p/localization/localization_constants.dart';
import '../constants.dart';

class ForgetPassword extends StatelessWidget {
  final bool login;
  final Function press;
  const ForgetPassword({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RichText(
          text: TextSpan(
            text: getTranslated(context, "ForgetPassword"),
            style: TextStyle(
              color: kOrangeColor,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
