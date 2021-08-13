import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("MainScreen build()");
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Date"),
                  IconButton(
                      onPressed: () {
                        showMonthPicker(
                          context: context,
                          firstDate: DateTime(DateTime.now().year - 1, 5),
                          lastDate: DateTime(DateTime.now().year + 1, 9),
                          initialDate: DateTime.now(),
                          //locale: Locale("es"),
                        ).then((date) {
                          // if (date != null) {
                          //   setState(() {
                          //     selectedDate = date;
                          //   });
                          // }
                        });
                      },
                      icon: Icon(Icons.date_range_outlined))
                ],
              ),
            ),
            IncomeWidget(),
          ],
        ),
      ),
    );
  }
}

class IncomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      // <-- Provides ExpandableController to its children
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Income"),
                      Text(
                        "000000000000 Ft",
                        style: TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                  FloatingActionButton(child: Icon(Icons.add), onPressed: () {})
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Expandable(
                // <-- Driven by ExpandableController from ExpandableNotifier
                collapsed: ExpandableButton(
                  // <-- Expands when tapped on the cover photo
                  child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Text(
                        "More",
                      )),
                ),
                expanded: Column(children: [
                  Container(
                      width: double.infinity, child: Text("Transactions")),
                  Text("data1"),
                  Text("data2"),
                  Text("data3"),
                  Container(
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.centerRight,
                    child: ExpandableButton(
                      // <-- Collapses when tapped on
                      child: Icon(Icons.arrow_upward),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
