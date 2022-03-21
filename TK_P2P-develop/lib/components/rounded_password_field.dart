import 'package:flutter/material.dart';
import 'package:p2p/localization/localization_constants.dart';
import './text_field_container.dart';
import '../constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: getTranslated(context, "Password"),
          icon: Icon(
            Icons.vpn_key,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kGreyLightColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
