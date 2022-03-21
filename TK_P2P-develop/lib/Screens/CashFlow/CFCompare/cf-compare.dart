import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import '../../../constants.dart';

class CFCompare extends StatefulWidget {
  const CFCompare({
    Key key,
  }) : super(key: key);
  @override
  _CFTrendState createState() => _CFTrendState();
}

class _CFTrendState extends State<CFCompare> {
  DateTime initialDate = DateTime.now();

  DateTime selectedDate;
  @override
  void initState() {
    super.initState();

    selectedDate = this.initialDate;
    _onSelectedDateChanged(selectedDate);
  }

  void _onSelectedDateChanged(DateTime newDate) {
    print(newDate);

    setState(() {
      selectedDate = newDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Container(
        padding: EdgeInsets.only(top: 16, left: 5, right: 5, bottom: 0),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    // color: Colors.pink,
                    height: 70,
                    child: Icon(
                      Icons.arrow_left,
                      size: 50,
                      color: Colors.grey,
                    )),
                Expanded(
                  // color: Colors.pink,
                  // height: size.height * 0.1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'To Month',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        // width: size.width * 0.4,
                        decoration: new BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            showMonthPicker(
                              context: context,
                              firstDate: DateTime(DateTime.now().year - 10, 5),
                              lastDate: DateTime(DateTime.now().year + 0,
                                  DateTime.now().month),
                              initialDate: initialDate,
                              locale: Locale("en"),
                            ).then((date) {
                              if (date != null) {
                                _onSelectedDateChanged(date);
                              }
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ((selectedDate.month).toInt() > 9)
                                    ? '${selectedDate?.year} / ${selectedDate?.month}'
                                    : '${selectedDate?.year} / 0${selectedDate?.month}',

                                // '$selectedDate',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
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
                ),
                Container(
                    height: 70,
                    child: Icon(
                      Icons.arrow_right,
                      size: 50,
                      color: Colors.grey,
                    )),
              ],
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(bottom: 30),
                // padding: const EdgeInsets.all(8),
                children: [
                  Container(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(width: 1.0, color: kGreyLightColor),
                          borderRadius:
                              new BorderRadius.all(Radius.circular(5.0))),
                      child: DataTable(
                        horizontalMargin: 7,
                        headingRowHeight: 40,
                        dataRowHeight: 35,
                        dividerThickness: 0,
                        columns: [
                          DataColumn(
                            label: Text(
                              "In M LAK",
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                            numeric: false,
                          ),
                          DataColumn(
                            label: Text(
                              ((selectedDate.month).toInt() > 9)
                                  ? "${selectedDate.month} AC"
                                  : "0${selectedDate.month} AC",
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 12),
                            ),
                            numeric: false,
                          ),
                          DataColumn(
                            label: Text(
                              (selectedDate.month.toInt() > 9)
                                  ? "${selectedDate.month} FC"
                                  : "0${selectedDate.month} FC",
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 12),
                            ),
                            numeric: false,
                          ),
                          DataColumn(
                            label: Text(
                              'Var %',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 12),
                            ),
                            numeric: false,
                          ),
                        ],
                        rows: [
                          DataRow(
                            color: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.selected))
                                return Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.2);
                              return Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.2); // Use the default value.
                            }),
                            cells: [
                              DataCell(
                                Text(
                                  "Opening Bal",
                                  style: TextStyle(
                                      // fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                ),
                              ),
                              DataCell(
                                Text("200"),
                              ),
                              DataCell(
                                Text("3"),
                              ),
                              DataCell(
                                Text(
                                  "3435",
                                ),
                              ),
                            ],
                          ),
                          DataRow(
                            color: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.selected))
                                return Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.2);
                              return Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.2); // Use the default value.
                            }),
                            cells: [
                              DataCell(
                                Text(
                                  "Cash In",
                                  style: TextStyle(
                                      // fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                ),
                              ),
                              DataCell(
                                Text("200"),
                              ),
                              DataCell(
                                Text("3"),
                              ),
                              DataCell(
                                Text(
                                  "3435",
                                ),
                              ),
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.label_important,
                                      size: 13,
                                      color: kPrimaryColor,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text('Operation'),
                                  ],
                                ),
                              ),
                              DataCell(
                                Text("200"),
                              ),
                              DataCell(
                                Text("3"),
                              ),
                              DataCell(
                                Text(
                                  "3435",
                                ),
                              ),
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.label_important,
                                      size: 13,
                                      color: kPrimaryColor,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text('FX & Transfer'),
                                  ],
                                ),
                              ),
                              DataCell(
                                Text("200"),
                              ),
                              DataCell(
                                Text("3"),
                              ),
                              DataCell(
                                Text(
                                  "3435",
                                ),
                              ),
                            ],
                          ),
                          DataRow(
                            color: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.selected))
                                return Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.2);
                              return Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.2); // Use the default value.
                            }),
                            cells: [
                              DataCell(
                                Text(
                                  "Cash Out",
                                  style: TextStyle(
                                      // fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                ),
                              ),
                              DataCell(
                                Text("200"),
                              ),
                              DataCell(
                                Text("3"),
                              ),
                              DataCell(
                                Text(
                                  "3435",
                                ),
                              ),
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(
                                      Icons.label_important,
                                      size: 13,
                                      color: kPrimaryColor,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text('Operation'),
                                  ],
                                ),
                              ),
                              DataCell(
                                Text("200"),
                              ),
                              DataCell(
                                Text("3"),
                              ),
                              DataCell(
                                Text(
                                  "3435",
                                ),
                              ),
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        Icons.fiber_manual_record,
                                        size: 10,
                                        color: kPrimaryColor,
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Text('Operating'),
                                    ],
                                  ),
                                ),
                              ),
                              DataCell(
                                Text("200"),
                              ),
                              DataCell(
                                Text("3"),
                              ),
                              DataCell(
                                Text(
                                  "3435",
                                ),
                              ),
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        Icons.fiber_manual_record,
                                        size: 10,
                                        color: kPrimaryColor,
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Text('Financing'),
                                    ],
                                  ),
                                ),
                              ),
                              DataCell(
                                Text("200"),
                              ),
                              DataCell(
                                Text("3"),
                              ),
                              DataCell(
                                Text(
                                  "3435",
                                ),
                              ),
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        Icons.fiber_manual_record,
                                        size: 10,
                                        color: kPrimaryColor,
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Text('Investing'),
                                    ],
                                  ),
                                ),
                              ),
                              DataCell(
                                Text("200"),
                              ),
                              DataCell(
                                Text("3"),
                              ),
                              DataCell(
                                Text(
                                  "3435",
                                ),
                              ),
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(
                                      Icons.label_important,
                                      size: 13,
                                      color: kPrimaryColor,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text('FX & Transfer'),
                                  ],
                                ),
                              ),
                              DataCell(
                                Text("200"),
                              ),
                              DataCell(
                                Text("3"),
                              ),
                              DataCell(
                                Text(
                                  "3435",
                                ),
                              ),
                            ],
                          ),
                          DataRow(
                            color: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.selected))
                                return Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.2);
                              return Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.2); // Use the default value.
                            }),
                            cells: [
                              DataCell(
                                Text(
                                  "Net Cash",
                                  style: TextStyle(
                                      // fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                ),
                              ),
                              DataCell(
                                Text("200"),
                              ),
                              DataCell(
                                Text("3"),
                              ),
                              DataCell(
                                Text(
                                  "3435",
                                ),
                              ),
                            ],
                          ),
                          DataRow(
                            color: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.selected))
                                return Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.2);
                              return Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.2); // Use the default value.
                            }),
                            cells: [
                              DataCell(
                                Text(
                                  "Closing Bal",
                                  style: TextStyle(
                                      // fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                ),
                              ),
                              DataCell(
                                Text("200"),
                              ),
                              DataCell(
                                Text("3"),
                              ),
                              DataCell(
                                Text(
                                  "3435",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
