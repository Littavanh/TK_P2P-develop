import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:group_list_view/group_list_view.dart';
import 'dart:convert';
import 'package:p2p/Screens/Approval/ApprovalDetails/approval-details.dart';
import 'package:p2p/Screens/Approval/FilterDataPODO.dart';
import 'package:p2p/Screens/Approval/component/approvalPODO.dart';
import 'package:p2p/Screens/HomePage/homePage.dart';
import 'package:p2p/constants/AppConstant.dart';
import 'package:p2p/constants/Network.dart';
import 'package:p2p/constants/Services.dart';
import 'package:p2p/main.dart';
import '../../../constants.dart';
import 'package:http/http.dart' as http;
import './background.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isLoading;
  List<ResultObject> approvalList = [];
  List p2PTypeId = [];
  List businessUnitIds = [];
  String noDataTxt = "";
  Map<String, List> _elements = {
    'Team A': ['Klay Lewis', 'Ehsan Woodard', 'River Bains'],
    'Team B': ['Toyah Downs', 'Tyla Kane'],
  };
  // int userID;
  List selecteCategorys = [];
  List selecteP2PType = [];

  List<FilterResultObject> filterDataList = [];
  List<P2PType> P2pType = [];
  List<BusinessUnit> _buCategories = [];

  @override
  void initState() {
    isLoading = true;
    _getApproveList();

    super.initState();
  }

  Future<void> _getFilterList() async {
    Network().check().then((intenet) async {
      if (intenet != null && intenet) {
        try {
          final uri = Services.FilterData;
          filterDataList.clear();
          var token = await globalMyLocalPrefes
              .get(AppConstant.ACCESS_TOKEN.toString());
          Map<String, dynamic> body = {"TokenKey": token};
          Map<String, String> headers = {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          };
          http
              .post(Uri.parse(uri), body: json.encode(body), headers: headers)
              .then((response) async {
            var jsonResponse = jsonDecode(response.body);
            // print("Reponse---2 : $jsonResponse");
            if (jsonResponse["StatusCode"] == 200) {
              FilterData filterList = new FilterData.fromJson(jsonResponse);
              print("filterList---2 : $filterList");
              setState(() {
                filterDataList = filterList.resultObject;
                P2pType = filterDataList[0].p2PType;
                _buCategories = filterDataList[0].businessUnit;
                isLoading = false;
              });
              print("_buCategories: $_buCategories");
            } else {
              if (jsonResponse["ModelErrors"] == 'Unauthorized') {
                GetToken().getToken().then((value) {
                  _getFilterList();
                });
                // _getNewsList();
                // Future<String> token = getToken();
              } else {
                setState(() {
                  isLoading = false;
                });
                Fluttertoast.showToast(
                    msg: "Something went wrong.. Please try again later.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            }
          });
        } catch (e) {
          print("Error: $e");
          return (e);
        }
      } else {
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: "Something went wrong.. Please try again later.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  void _onCategorySelected(bool selected, categoryId, type) {
    if (selected == true) {
      if (type == 'P2pType' && !selecteP2PType.contains(categoryId)) {
        setState(() {
          selecteP2PType.add(categoryId);
        });
      } else if (!selecteCategorys.contains(categoryId)) {
        setState(() {
          selecteCategorys.add(categoryId);
        });
      }
    } else {
      if (type == 'P2pType') {
        setState(() {
          selecteP2PType.remove(categoryId);
        });
      } else {
        setState(() {
          selecteCategorys.remove(categoryId);
        });
      }
    }
  }

  void getDate() => {
        setState(() {
          p2PTypeId = selecteP2PType;
          businessUnitIds = selecteCategorys;
          isLoading = true;
        }),
        _getApproveList(),
        Navigator.pop(context)
      };

  Future<void> _getApproveList() async {
    Network().check().then((intenet) async {
      if (intenet != null && intenet) {
        try {
          setState(() {
            isLoading = true;
          });
          final uri = Services.ApprovalList;
          approvalList.clear();
          var token = await globalMyLocalPrefes
              .get(AppConstant.ACCESS_TOKEN.toString());

          var busiId =
              await globalMyLocalPrefes.get(AppConstant.BUSINESSID.toString());
          var deptId =
              await globalMyLocalPrefes.get(AppConstant.DEPARTMENT.toString());
          var userTd =
              await globalMyLocalPrefes.get(AppConstant.USER_ID.toString());

          Map<String, dynamic> body = {
            "UserId": userTd.toString(),
            "BusinessUnitId": busiId.toString(),
            "DepartmentId": deptId.toString(),
            "TokenKey": token,
            "P2PTypeId": p2PTypeId.toList(),
            "BusinessUnitIds": businessUnitIds.toList(),
          };
          Map<String, String> headers = {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          };
          // print("[_getApproveList] Boay = $body");

          // print('[RequestBody] = ${body.toString()}');

          http
              .post(Uri.parse(uri), body: json.encode(body), headers: headers)
              .then((response) async {
            var jsonResponse = jsonDecode(response.body);
            // print("Reponse---2 : $jsonResponse");
            if (jsonResponse["StatusCode"] == 200 &&
                jsonResponse["ResultObject"] != null) {
              // print('[ApproveListResponse] = ${jsonResponse.toString()}');
              ApprovalList approveList =
                  new ApprovalList.fromJson(jsonResponse);
              print('ApproveList: ' + approveList.toJson().toString());
              setState(() {
                approvalList = approveList.resultObject;
              });
              _getFilterList();
            } else {
              if (jsonResponse["ModelErrors"] == 'Unauthorized') {
                GetToken().getToken().then((value) {
                  _getApproveList();
                });
                // _getNewsList();
                // Future<String> token = getToken();
              } else if (jsonResponse["ModelErrors"] == 'Data Not Fount') {
                setState(() {
                  isLoading = false;
                });
                noDataTxt = jsonResponse["ModelErrors"];
              } else {
                setState(() {
                  isLoading = false;
                });
                Fluttertoast.showToast(
                    msg: jsonResponse["ModelErrors"],
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            }
          });
        } catch (e) {
          print("Error: $e");
          Fluttertoast.showToast(
              msg: "Something went wrong.. Please try again later.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          return (e);
        }
      } else {
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: "Please check internet connection.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  void _goToDetails(BuildContext context1, approveData) {
    String jsonUser = jsonEncode(approveData);
    print(jsonUser);

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ApprovalDetails(
            appData: jsonUser,
          ),
        ));
  }

  Widget notiDetailCard(approvalList) {
    return Container(
      decoration: new BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.1),
            blurRadius: 20.0, // soften the shadow
            spreadRadius: 0.0, //extend the shadow
            offset: Offset(
              5.0, // Move to right 10  horizontally
              5.0, // Move to bottom 10 Vertically
            ),
          )
        ],
      ),
      padding: new EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
      child: Column(
        children: [
          new Card(
            elevation: 0,
            child: new InkWell(
              onTap: () {
                _goToDetails(context, approvalList);
              },
              child: Row(
                children: <Widget>[
                  approvalList.appStatus == "Pending"
                      ? Container(
                          height: 100,
                          width: 10,
                          decoration: new BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5.0),
                                bottomLeft: Radius.circular(5.0)),
                          ),
                        )
                      : Container(),
                  approvalList.appStatus == "Approved"
                      ? Container(
                          height: 100,
                          width: 10,
                          decoration: new BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5.0),
                                bottomLeft: Radius.circular(5.0)),
                          ),
                        )
                      : Container(),
                  approvalList.appStatus == "Hold"
                      ? Container(
                          height: 100,
                          width: 10,
                          decoration: new BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5.0),
                                bottomLeft: Radius.circular(5.0)),
                          ),
                        )
                      : Container(),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            approvalList.appNo,
                            style: new TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(approvalList.requestBy),
                          Flexible(
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              strutStyle: StrutStyle(fontSize: 12.0),
                              text: TextSpan(
                                  style: TextStyle(color: Colors.black),
                                  text: approvalList.title),
                            ),
                          ),
                          Text(
                            'BU: ${approvalList.businessUnitName}',
                            style: new TextStyle(),
                          ),
                          Text(
                            'Total: ${approvalList.totalAmount} ${approvalList.currencyName}',
                            style: new TextStyle(),
                          ),
                        ],
                      ),
                      // color: Colors.amber,
                      width: 100,
                      height: 100,
                    ),
                  ),
                  Container(
                    height: 100,
                    // width: 100,
                    // color: Colors.blue,
                    child: Container(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, right: 8),
                            child: Text(
                              approvalList.appDate,
                              style: new TextStyle(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, right: 8),
                            child: approvalList.title != null
                                ? Text(
                                    approvalList.appStatus,
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: kGreyLightColor),
                                  )
                                : Container(),
                          ),
                          approvalList.appStatus != "Approved"
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: SizedBox(
                                    width: 90,
                                    height: 30.0,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          elevation:
                                              MaterialStateProperty.all(0),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.green),
                                          shadowColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.green)),
                                      onPressed: () {
                                        _goToDetails(context, approvalList);
                                      },
                                      child: Text("Action".toUpperCase(),
                                          style: TextStyle(fontSize: 14)),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (!isLoading) {
      return Scaffold(
        body: Background(
            child: Column(
          children: [
            Expanded(
                // child: Background(
                child: approvalList.length != 0
                    ? ListView(
                        padding: const EdgeInsets.all(8),
                        children: <Widget>[
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: approvalList.map((p) {
                                return notiDetailCard(p);
                              }).toList()),
                          SizedBox(
                            height: 50,
                          )
                        ],
                      )
                    : Center(child: Text(noDataTxt))
                // ),
                ),
          ],
        )),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.filter_list_outlined),
          onPressed: () {
            showModalBottomSheet<void>(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(// this is new
                      builder: (BuildContext context, StateSetter setState) {
                    return
                        // return AlertDialog(
                        //   title: Text('Filter'),
                        //   content: Container(
                        Wrap(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 20.0, bottom: 15.0),
                          child: Center(
                            child: Container(
                                width: 150.0,
                                child: Image.asset('assets/images/logo-pa.png'),
                                margin: EdgeInsets.all(0.0),
                                padding: EdgeInsets.all(0.0)),
                          ),
                        ),
                        Container(
                          height: size.height * 0.8,
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 8.0),
                          padding: EdgeInsets.all(0.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey[300],
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                padding: EdgeInsets.all(0.0),
                                child: Text(
                                  "Type",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: ListView.builder(
                                  itemCount: P2pType.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      // margin: EdgeInsets.fromLTRB(0, 8, 0, 8.0),
                                      height: 40,
                                      child: CheckboxListTile(
                                        value: selecteP2PType
                                            .contains(P2pType[index].typeId),
                                        selected: selecteP2PType
                                            .contains(P2pType[index].typeId),
                                        onChanged: (bool selected) {
                                          setState(() {});
                                          _onCategorySelected(selected,
                                              P2pType[index].typeId, "P2pType");
                                        },
                                        title: Text(P2pType[index].typeName,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w400)),
                                        secondary: const Icon(
                                          Icons.label_important,
                                          color: Colors.black,
                                          size: 20,
                                        ),
                                        activeColor: Colors.green,
                                        checkColor: Colors.white,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                height: 16,
                                margin: EdgeInsets.only(top: 8.0),
                                padding: EdgeInsets.all(0.0),
                                child: Text(
                                  "Business Unit",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: ListView.builder(
                                  itemCount: _buCategories.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      height: 40,
                                      child: CheckboxListTile(
                                        value: selecteCategorys.contains(
                                            _buCategories[index]
                                                .businessUnitId),
                                        selected: selecteCategorys.contains(
                                            _buCategories[index]
                                                .businessUnitId),
                                        onChanged: (bool selected) {
                                          setState(() {});
                                          _onCategorySelected(
                                              selected,
                                              _buCategories[index]
                                                  .businessUnitId,
                                              "_buCategories");
                                        },
                                        title: Text(
                                            _buCategories[index]
                                                .businessUnitName,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13.0,
                                                fontWeight: FontWeight.w400)),
                                        secondary: const Icon(
                                          Icons.lens,
                                          color: Colors.black,
                                          size: 16,
                                        ),
                                        activeColor: Colors.green,
                                        checkColor: Colors.white,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () => {getDate()},
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.orange)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: const EdgeInsets.fromLTRB(
                                      10, 10.0, 10, 10),
                                  child: const Text('Get Data',
                                      style: TextStyle(fontSize: 16)),
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ],
                    );
                  });
                });
          },
        ),
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Widget setupAlertDialoadContainer() {
    return GroupListView(
      sectionsCount: _elements.keys.toList().length,
      countOfItemInSection: (int section) {
        return _elements.values.toList()[section].length;
      },
      itemBuilder: _itemBuilder,
      groupHeaderBuilder: (BuildContext context, int section) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Text(
            _elements.keys.toList()[section],
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 10),
      sectionSeparatorBuilder: (context, section) => SizedBox(height: 10),
    );
  }

  Widget _itemBuilder(BuildContext context, IndexPath index) {
    String user = _elements.values.toList()[index.section][index.index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 8,
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 10.0),
          leading: CircleAvatar(
            child: Text(
              _getInitials(user),
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            backgroundColor: Colors.amber,
          ),
          title: Text(
            _elements.values.toList()[index.section][index.index],
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }

  String _getInitials(String user) {
    var buffer = StringBuffer();
    var split = user.split(" ");
    for (var s in split) buffer.write(s[0]);
    return buffer.toString().substring(0, split.length);
  }
}
