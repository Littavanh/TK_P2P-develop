import 'package:flutter/material.dart';
import 'package:p2p/Screens/Approval/ApprovalDetails/component/aprovHistoryPODO.dart';
import 'package:p2p/constants.dart';
import 'package:p2p/localization/localization_constants.dart';

void openHistory(BuildContext context, ApproveHistory appData) {
  Size size = MediaQuery.of(context).size;

  print("Data: ${appData.toString()}");

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9.0)), //this right here
        child: Container(
          height: size.height * 0.7,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 20),
                  child: Text(
                    getTranslated(context, "PreviousApproversNotes"),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: appData.resultObject.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10.0),
                          child: Container(
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      appData.resultObject[index]
                                                  .approverName !=
                                              ""
                                          ? Text(
                                              appData.resultObject[index]
                                                  .approverName,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  backgroundColor:
                                                      Colors.white),
                                            )
                                          : Container(),
                                      appData.resultObject[index]
                                                  .approverName !=
                                              ""
                                          ? Text(
                                              appData.resultObject[index]
                                                  .appDateTime,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                  appData.resultObject[index].remarks != ""
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Remarks : ",
                                              ),
                                              Flexible(
                                                child: new Text(
                                                    appData.resultObject[index]
                                                        .remarks,
                                                    style: TextStyle(),
                                                    textAlign: TextAlign.left),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RaisedButton(
                      color: kOrangeColor,
                      child: new Text(
                        getTranslated(context, 'Close'),
                        style: TextStyle(color: kWhiteColor),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
