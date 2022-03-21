// import 'package:flutter/material.dart';
// import '../constants.dart';
// import '../language_constants.dart';
// import 'package:flutter_localization_master/classes/language.dart';
// import '../main.dart';
// // enum Language { english, laos }

// class LangDiaBox extends StatefulWidget {
//   LangDiaBox();

//   @override
//   _LangDiaBoxState createState() => _LangDiaBoxState();
// }

// class _LangDiaBoxState extends State<LangDiaBox>
//     with SingleTickerProviderStateMixin {
//   AnimationController controller;
//   Animation<double> scaleAnimation;

//   // Language _lang = Language.english;

//   void _changeLanguage(Language language) async {
//     Locale _locale = await setLocale(language.languageCode);
//     MyApp.setLocale(context, _locale);
//   }

//   @override
//   void initState() {
//     super.initState();

//     controller =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 500));
//     scaleAnimation =
//         CurvedAnimation(parent: controller, curve: Curves.easeInToLinear);

//     controller.addListener(() {
//       setState(() {});
//     });

//     controller.forward();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Material(
//         color: Colors.transparent,
//         child: ScaleTransition(
//           scale: scaleAnimation,
//           child: Container(
//             // height: 250,
//             // color: Colors.yellow,
//             child: Dialog(
//               insetPadding: const EdgeInsets.all(25.0),
//               child: Stack(
//                 overflow: Overflow.visible,
//                 // alignment: Alignment.center,
//                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Container(
//                     margin: const EdgeInsets.all(7.0),
//                     padding: const EdgeInsets.all(10.0),
//                     decoration: BoxDecoration(
//                         // color: Colors.pink,
//                         borderRadius: BorderRadius.circular(10.0)),
//                     height: 250,
//                     // color: Colors.pink,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         Text(
//                           'Select Your Language',
//                           style: TextStyle(
//                               fontSize: 20.0,
//                               color: Colors.black,
//                               fontWeight: FontWeight.bold),
//                           textAlign: TextAlign.center,
//                         ),
//                         Container(
//                           margin: const EdgeInsets.only(top: 15.0),
//                           child: Card(
//                               child: RadioListTile<Language>(
//                             title: Container(
//                               alignment: Alignment.topLeft,
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: <Widget>[
//                                   Padding(
//                                     padding: const EdgeInsets.only(right: 8.0),
//                                     child: Text(
//                                       'Lao',
//                                       style: TextStyle(
//                                         // fontSize: 20.0,
//                                         color: Colors.black,
//                                       ),
//                                       textAlign: TextAlign.center,
//                                     ),
//                                   ),
//                                   Image.asset(
//                                     "assets/images/lao3.jpg",
//                                     height: 35,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             value: Language.laos,
//                             groupValue: _lang,
//                             onChanged: (Language value) {
//                               setState(() {
//                                 _lang = value;
//                                  _changeLanguage(_lang);
//                                 print(_lang);
//                               });
//                             },
//                           )),
//                         ),
//                         Card(
//                           child: RadioListTile<Language>(
//                             title: Container(
//                               alignment: Alignment.topLeft,
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: <Widget>[
//                                   Padding(
//                                     padding: const EdgeInsets.only(right: 8.0),
//                                     child: Text(
//                                       'English',
//                                       style: TextStyle(
//                                         // fontSize: 20.0,
//                                         color: Colors.black,
//                                       ),
//                                       textAlign: TextAlign.center,
//                                     ),
//                                   ),
//                                   Image.asset(
//                                     "assets/images/usa2.png",
//                                     height: 32,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             value: Language.english,
//                             groupValue: _lang,
//                             onChanged: (Language value) {
//                               setState(() {
//                                 _lang = value;
//                                 print(_lang);
//                               });
//                             },
//                           ),
//                         ),
//                         RaisedButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           color: kOrangeColor,
//                           child: Text(
//                             'Done',
//                             style: TextStyle(color: kWhiteColor),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../constants.dart';

enum Language { english, laos }

class LangDiaBox extends StatefulWidget {
  LangDiaBox();

  @override
  _LangDiaBoxState createState() => _LangDiaBoxState();
}

class _LangDiaBoxState extends State<LangDiaBox>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  Language _lang = Language.english;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeInToLinear);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            // height: 250,
            // color: Colors.yellow,
            child: Dialog(
              insetPadding: const EdgeInsets.all(25.0),
              child: Stack(
                overflow: Overflow.visible,
                // alignment: Alignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(7.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        // color: Colors.pink,
                        borderRadius: BorderRadius.circular(10.0)),
                    height: 250,
                    // color: Colors.pink,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Select Your Language',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 15.0),
                          child: Card(
                              child: RadioListTile<Language>(
                            title: Container(
                              alignment: Alignment.topLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      'Lao',
                                      style: TextStyle(
                                        // fontSize: 20.0,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Image.asset(
                                    "assets/images/lao3.jpg",
                                    height: 35,
                                  ),
                                ],
                              ),
                            ),
                            value: Language.laos,
                            groupValue: _lang,
                            onChanged: (Language value) {
                              setState(() {
                                _lang = value;
                                print(_lang);
                              });
                            },
                          )),
                        ),
                        Card(
                          child: RadioListTile<Language>(
                            title: Container(
                              alignment: Alignment.topLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      'English',
                                      style: TextStyle(
                                        // fontSize: 20.0,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Image.asset(
                                    "assets/images/usa2.png",
                                    height: 32,
                                  ),
                                ],
                              ),
                            ),
                            value: Language.english,
                            groupValue: _lang,
                            onChanged: (Language value) {
                              setState(() {
                                _lang = value;
                                print(_lang);
                              });
                            },
                          ),
                        ),
                        RaisedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: kOrangeColor,
                          child: Text(
                            'Done',
                            style: TextStyle(color: kWhiteColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
