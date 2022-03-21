import 'package:flutter/material.dart';
import '../Dashboard/component/body.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Body(),
    );
  }

  //  Future<T> _onBackPressed<T>(BuildContext context, Widget page) {

}
