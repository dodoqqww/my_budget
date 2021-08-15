import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:my_budget/models/transaction.dart';
import 'package:my_budget/ui/screens/add_trx_screen.dart';
import 'package:my_budget/ui/screens/trx_info_screen.dart';

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
  @override
  Widget build(BuildContext context) {
    print("IncomeWidget build()");
    return ExpandableNotifier(
      // <-- Provides ExpandableController to its children
      child: Card(
        elevation: 20,
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text("Income:"
                            //,style: TextStyle(fontWeight: FontWeight.bold)
                            ),
                      ),
                      Text(
                        "+ 000000000000 Ft",
                        style: TextStyle(fontSize: 24, color: Colors.green),
                      ),
                    ],
                  ),
                  FloatingActionButton(
                      child: Icon(Icons.add),
                      backgroundColor: Colors.green,
                      onPressed: () {
                        //Navigator.pushNamed(context, '/addTrx');

                        Navigator.of(context).push(PageRouteBuilder(
                            barrierColor: Colors.black.withOpacity(0.5),
                            transitionsBuilder: (context, a1, a2, widget) {
                              final curvedValue =
                                  Curves.easeInOutBack.transform(a1.value) -
                                      1.0;
                              return Transform(
                                transform: Matrix4.translationValues(
                                    0.0, curvedValue * 100, 0.0),
                                child: Opacity(
                                  opacity: a1.value,
                                  child: AddTrxScreen(),
                                ),
                              );
                            },
                            opaque: false,
                            // ignore: missing_return
                            pageBuilder: (_1, _2, _3) {}));
                      })
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
                      "Details",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),

                expanded: TrxDetailsWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TrxDetailsWidget extends StatelessWidget {
  Transaction asd1 =
      Transaction("id1", "name1", DateTime.now(), 120.4, "desc1");
  Transaction asd2 = Transaction("id2", "name2", DateTime.now(), 12.4, "desc2");

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          width: double.infinity,
          child: Text("Transactions:",
              style: TextStyle(
                decoration: TextDecoration.underline,
              ))),
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
    ]);
  }
}

class TrxListItem extends StatelessWidget {
  final Transaction trx;
  final Color amountColor;

  const TrxListItem(this.trx, this.amountColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 5, 5, 5),
      decoration: BoxDecoration(
          border: Border(
        left: BorderSide(
          //color: Colors.green,
          width: 1,
        ),
      )),
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(trx.name),
              InkWell(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        barrierColor: Colors.black.withOpacity(0.5),
                        transitionsBuilder: (context, a1, a2, widget) {
                          final curvedValue =
                              Curves.easeInOutBack.transform(a1.value) - 1.0;
                          return Transform(
                            transform: Matrix4.translationValues(
                                0.0, curvedValue * 100, 0.0),
                            child: Opacity(
                              opacity: a1.value,
                              child: TrxInfoScreen(trx: trx),
                            ),
                          );
                        },
                        opaque: false,
                        // ignore: missing_return
                        pageBuilder: (_1, _2, _3) {}));
                  },
                  child: Text(
                    "More",
                    style: TextStyle(color: Colors.blue),
                  ))
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
