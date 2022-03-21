import 'package:flutter/material.dart';
import 'package:p2p/localization/localization_constants.dart';

class CustomAlertDialog extends StatelessWidget {
  final Color bgColor;
  final String title;
  final String message;
  final String positiveBtnText;
  final String negativeBtnText;
  final Function onPostivePressed;
  final Function onNegativePressed;
  final double circularBorderRadius;

  CustomAlertDialog({
    this.title,
    this.message,
    this.circularBorderRadius = 15.0,
    this.bgColor = Colors.white,
    this.positiveBtnText,
    this.negativeBtnText,
    this.onPostivePressed,
    this.onNegativePressed,
  })  : assert(bgColor != null),
        assert(circularBorderRadius != null);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null
          ? Center(
              child: Text(
              title,
              style: new TextStyle(
                fontSize: 20.0,
                color: Colors.black,
              ),
            ))
          : null,
      content: message != null
          ? Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 0.0, right: 0.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: new TextSpan(
                  // Note: Styles for TextSpans must be explicitly defined.
                  // Child text spans will inherit styles from parent
                  style: new TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    new TextSpan(
                        text: getTranslated(context, "AreYouSureYouWantTo")),
                    new TextSpan(
                        text: message,
                        style: new TextStyle(fontWeight: FontWeight.bold)),
                    new TextSpan(text: getTranslated(context, "ThisOrder")),
                  ],
                ),
              ))
          : null,
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(circularBorderRadius)),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 18.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                negativeBtnText != null
                    ? ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          if (onNegativePressed != null) {
                            onNegativePressed();
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red)),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            negativeBtnText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                        ))
                    // TextButton(
                    //     child: Text(negativeBtnText),
                    //     // textColor: Theme.of(context).accentColor,
                    //     onPressed: () {
                    //       Navigator.of(context).pop();
                    //       if (onNegativePressed != null) {
                    //         onNegativePressed();
                    //       }
                    //     },
                    //   )
                    : null,
                positiveBtnText != null
                    ? ButtonTheme(
                        height: 35.0,
                        minWidth: 110.0,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green)),
                          child: Text(
                            positiveBtnText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                backgroundColor: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                          onPressed: () {
                            if (onPostivePressed != null) {
                              onPostivePressed();
                            }
                          },
                        ))
                    // TextButton(
                    //     child: Text(positiveBtnText),
                    //     // textColor: Theme.of(context).accentColor,
                    //     onPressed: () {
                    //       if (onPostivePressed != null) {
                    //         onPostivePressed();
                    //       }
                    //     },
                    //   )
                    : null,
              ]),
        ),
      ],
    );
  }
}
