import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:p2p/constants.dart';
import 'package:p2p/models/notiList.dart';

class BalSummary extends StatefulWidget {
  @override
  _BalSummaryState createState() => _BalSummaryState();
}

class _BalSummaryState extends State<BalSummary> {
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();

  Future<Null> _selectDate(
      BuildContext context, selectedDate, dateSelected) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedDate) {
      if (dateSelected == 'FromDate') {
        setState(() {
          selectedFromDate = picked;
        });
      } else {
        setState(() {
          selectedToDate = picked;
        });
      }
    }
  }

  @override
  void initState() {
    emps = Employee.getUsers();
    super.initState();
  }

  @override
  List<Employee> emps = Employee.getUsers();

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 16, left: 15, right: 15, bottom: 25),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'From Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    width: size.width * 0.4,
                    decoration: new BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: GestureDetector(
                      onTap: () =>
                          _selectDate(context, selectedFromDate, 'FromDate'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${selectedFromDate.toLocal()}".split(' ')[0]),
                          Icon(
                            Icons.calendar_today,
                            size: 15,
                            color: kGreyLightColor,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('To Date',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Container(
                    padding: EdgeInsets.all(8),
                    width: size.width * 0.4,
                    decoration: new BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: GestureDetector(
                      onTap: () =>
                          _selectDate(context, selectedToDate, 'ToDate'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${selectedToDate.toLocal()}".split(' ')[0]),
                          Icon(
                            Icons.calendar_today,
                            size: 15,
                            color: kGreyLightColor,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          // color: kPrimaryColor,
          height: size.height * 0.60,
          child: ListView.builder(
            itemCount: cfHeading.length,
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 2, 10, 0),
                  decoration: BoxDecoration(
                      color: kSecondary,
                      borderRadius: new BorderRadius.all(Radius.circular(5.0))),
                  child: new ExpansionTile(
                    backgroundColor: kSecondary,
                    onExpansionChanged: (bool expanding) =>
                        setState(() => cfHeading[i].isExpanded = expanding),
                    title: Container(
                      // height: 30.0,

                      margin: const EdgeInsets.only(
                          top: 10.0, left: 0.0, right: 0.0, bottom: 10.0),
                      decoration: BoxDecoration(
                          color: kSecondary,
                          borderRadius:
                              new BorderRadius.all(Radius.circular(5.0))),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          cfHeading[i].title,
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                            fontSize: 20.0,
                            color: kWhiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: new Column(children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: new BorderRadius.all(
                                    Radius.circular(15.0))),
                            child: DataTable(
                              horizontalMargin: 9,
                              headingRowHeight: 40,
                              dataRowHeight: 35,
                              dividerThickness: 1,
                              columns: [
                                DataColumn(
                                  label: Text(
                                    "BU",
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                  numeric: false,
                                ),
                                DataColumn(
                                  label: Text(
                                    "LAK",
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                  numeric: false,
                                ),
                                DataColumn(
                                  label: Text(
                                    "THB",
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                  numeric: false,
                                ),
                                DataColumn(
                                  label: Text(
                                    "USA",
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                  numeric: false,
                                ),
                              ],

                              // rows: [],
                              rows: emps
                                  .map(
                                    (emp) => DataRow(
                                        selected: (emp.title == 'TOTAL'
                                            ? true
                                            : false),
                                        color: MaterialStateProperty
                                            .resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                          if (states
                                              .contains(MaterialState.selected))
                                            return Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withOpacity(0.2);
                                          return null; // Use the default value.
                                        }),
                                        cells: [
                                          DataCell(
                                            Text(
                                              emp.title,
                                              style: TextStyle(
                                                  // fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13),
                                            ),
                                          ),
                                          DataCell(
                                            Text(emp.lak),
                                          ),
                                          DataCell(
                                            Text(emp.thb),
                                          ),
                                          DataCell(
                                            Text(
                                              emp.usd,
                                            ),
                                          ),

                                          // DataCell(
                                          //   Text('${emp.id}'),
                                          // ),
                                          // DataCell(
                                          //   Text('${emp.email}'),
                                          // ),
                                        ]),
                                  )
                                  .toList(),
                            ),
                          )
                        ]),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class Employee {
  String title;
  String lak;
  String thb;
  String usd;
  Employee({this.title, this.lak, this.thb, this.usd});
  static List<Employee> getUsers() {
    return <Employee>[
      Employee(title: "Exhibition", lak: "2000", thb: "101", usd: "0.1"),
      Employee(title: "Headquorter", lak: "1233", thb: "100", usd: "0.1"),
      Employee(title: "ITECH", lak: "232", thb: "10", usd: "0.3"),
      Employee(title: "Banquet", lak: "1235", thb: "101", usd: "0.1"),
      Employee(title: "TK support", lak: "3546", thb: "101", usd: "0.6"),
      Employee(title: "Banquet", lak: "1235", thb: "101", usd: "0.1"),
      Employee(title: "TK support", lak: "3546", thb: "101", usd: "0.6"),
      Employee(title: "TOTAL", lak: "34546", thb: "601", usd: "1.6"),
    ];
  }
}

class CFHeading {
  String title;
  bool isExpanded;

  CFHeading(this.title, this.isExpanded);
}

List<CFHeading> cfHeading = [
  new CFHeading('Opening Balance (-\' 000)', false),
  new CFHeading('Cash In (-\' 000)', false),
  new CFHeading('Cash Out (-\' 000)', false),
  new CFHeading('Closing Balance (-\' 000)', false),
];
