import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:my_budget/models/transaction.dart';
import 'package:my_budget/models/wallet.dart';
import 'package:my_budget/ui/common/animations.dart';
import 'package:my_budget/ui/screens/add_trx_screen.dart';

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
                  Row(
                    children: [
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
                          icon: Icon(
                            Icons.date_range,
                            color: Colors.blue,
                          )),
                      Text(
                        "2021.August",
                        style: TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        print("export pdf || excel");
                      },
                      icon: Icon(
                        Icons.download,
                        color: Colors.blue,
                      ))
                ],
              ),
            ),
            Divider(
              thickness: 2,
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
                        openDialog(context, AddEditTrxScreen());
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
  final Transaction asd1 = Transaction(
      id: "id1",
      amount: 120.4,
      isIncome: true,
      category: TrxCategory(name: "Gift"),
      date: DateTime.now(),
      desc: "desc1",
      name: "name1",
      wallet: Wallet(
          id: "1", name: "OTP Bank", amount: 123456.0, type: WalletType.card));

  final Transaction asd2 = Transaction(
      id: "id2",
      amount: 1221.4,
      isIncome: true,
      category: TrxCategory(name: "Food"),
      date: DateTime.now(),
      desc: "desc2",
      name: "name2",
      wallet: Wallet(
          id: "2", name: "Home wallet", amount: 1234.0, type: WalletType.cash));

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
          child: Icon(Icons.arrow_upward, color: Colors.blue),
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
                    openDialog(context, AddEditTrxScreen(trx: trx));
                  },
                  child: Text(
                    "Edit",
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          ),
          Divider(color: Colors.black),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [trx.wallet.type.icon, Text(trx.wallet.name)],
            ),
            Text(
              "+ ${trx.amount} Ft",
              style: TextStyle(color: amountColor),
            )
          ])
        ],
      ),
    );
  }
}
