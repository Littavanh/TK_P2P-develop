import 'package:flutter/material.dart';
import '../models/notiList.dart';

class ApprovalItem extends StatelessWidget {
  final List<NotiList> notiList;
  final Function goToDetails;

  const ApprovalItem(
    this.goToDetails, {
    Key key,
    this.notiList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // padding: new EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
        // child: new Card(
        //   child: new InkWell(
        //     onTap: goToDetails,
        //     child: Row(
        //       children: <Widget>[
        //         Container(
        //           height: 100,
        //           width: 10,
        //           decoration: new BoxDecoration(
        //             color: notiList.title == "PROOHQS10167"
        //                 ? Colors.grey
        //                 : Colors.orange,
        //             borderRadius: BorderRadius.only(
        //                 topLeft: Radius.circular(5.0),
        //                 bottomLeft: Radius.circular(5.0)),
        //           ),
        //         ),
        //         Expanded(
        //           child: Container(
        //             padding: const EdgeInsets.only(left: 8.0),
        //             child: Column(
        //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Text(
        //                   notiList.title,
        //                   style: new TextStyle(fontWeight: FontWeight.bold),
        //                 ),
        //                 Text(
        //                   notiList.desc,
        //                   style: new TextStyle(),
        //                 ),
        //                 Text(
        //                   'BU: Headquarter',
        //                   style: new TextStyle(),
        //                 ),
        //                 Text(
        //                   'Total: 100223 Kip',
        //                   style: new TextStyle(),
        //                 ),
        //               ],
        //             ),
        //             // color: Colors.amber,
        //             width: 100,
        //             height: 100,
        //           ),
        //         ),
        //         Container(
        //           height: 100,
        //           // width: 100,
        //           // color: Colors.blue,
        //           child: Container(
        //             padding: const EdgeInsets.only(right: 8.0),
        //             child: Column(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               crossAxisAlignment: CrossAxisAlignment.end,
        //               children: [
        //                 Padding(
        //                   padding: const EdgeInsets.only(top: 8.0, right: 8),
        //                   child: Text(
        //                     notiList.date,
        //                     style: new TextStyle(),
        //                   ),
        //                 ),
        //                 Padding(
        //                   padding: const EdgeInsets.only(top: 8.0, right: 8),
        //                   child: notiList.title == "PROOHQS10167"
        //                       ? Text(
        //                           'Pending',
        //                           style: new TextStyle(
        //                               fontWeight: FontWeight.bold,
        //                               color: kGreyLightColor),
        //                         )
        //                       : Text(
        //                           'On Hold',
        //                           style: new TextStyle(
        //                               fontWeight: FontWeight.bold,
        //                               color: kOrangeColor),
        //                         ),
        //                 ),
        //                 Padding(
        //                   padding: const EdgeInsets.only(bottom: 8.0),
        //                   child: SizedBox(
        //                     width: 90,
        //                     height: 30.0,
        //                     child: RaisedButton(
        //                       shape: RoundedRectangleBorder(
        //                           borderRadius: BorderRadius.circular(8.0),
        //                           side: BorderSide(color: Colors.green)),
        //                       onPressed: goToDetails,
        //                       padding: const EdgeInsets.all(0),
        //                       color: Colors.green,
        //                       textColor: Colors.white,
        //                       child: Text("Action".toUpperCase(),
        //                           style: TextStyle(fontSize: 14)),
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        );
  }
}
