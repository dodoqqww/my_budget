import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:my_budget/models/transaction.dart';

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
                  Text("yyyy.MM"),
                  IconButton(
                      onPressed: () {
                        showMonthPicker(
                          context: context,
                          // firstDate: DateTime(DateTime.now().year - 1, 5),
                          // lastDate: DateTime(DateTime.now().year + 1, 9),
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
  Transaction asd1 =
      Transaction("id1", "name1", DateTime.now(), 120.4, "desc1");
  Transaction asd2 = Transaction("id2", "name2", DateTime.now(), 12.4, "desc2");

  @override
  Widget build(BuildContext context) {
    print("IncomeWidget build()");
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
                      Text("Income:"),
                      Text(
                        "+ 000000000000 Ft",
                        style: TextStyle(fontSize: 24, color: Colors.green),
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
                      width: double.infinity, child: Text("Transactions:")),
                  TrxListItem(asd1, Colors.green),
                  TrxListItem(asd2, Colors.green),
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

class TrxListItem extends StatelessWidget {
  final Transaction trx;
  final Color amountColor;

  const TrxListItem(this.trx, this.amountColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(trx.name),
              InkWell(
                  onTap: () {
                    print(trx.id + " info");
                  },
                  child: Text("info"))
            ],
          ),
          Divider(color: Colors.black),
          Container(
              alignment: Alignment.centerRight,
              child: Text(
                "+ ${trx.amount} Ft",
                style: TextStyle(color: amountColor),
              ))
        ],
      ),
    );
  }
}
