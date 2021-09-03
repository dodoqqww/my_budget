import 'package:flutter/material.dart'
    hide DropdownButton, DropdownMenuItem, DropdownButtonHideUnderline;
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:my_budget/ui/widgets/add_category_dialog.dart';
import 'package:my_budget/ui/widgets/fitted_text.dart';
import './/models/transaction_category.dart';
import './/ui/widgets/dropdown_widget.dart';

import 'package:expandable/expandable.dart';
import 'package:flutter_date_picker_timeline/flutter_date_picker_timeline.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import './/models/transaction.dart';
import './/models/wallet.dart';
import './/ui/common/animations.dart';
import './/ui/common/style.dart';
import 'package:quiver/time.dart';

class MainScreen extends StatelessWidget {
  final List<Transaction> list1 = [
    Transaction(
        id: "id1",
        amount: 1200000000.4,
        isIncome: true,
        category: TrxCategory(id: "1", name: "Gift"),
        date: DateTime.now(),
        desc: "desc1",
        name: "name1",
        wallet: Wallet(
            id: "1",
            name: "OTP Bank",
            amount: 123456.0,
            type: WalletType.card)),
    Transaction(
        id: "id2",
        amount: 1221.4,
        isIncome: true,
        category: TrxCategory(id: "2", name: "Food"),
        date: DateTime.now(),
        desc: "desc2",
        name: "name2",
        wallet: Wallet(
            id: "2",
            name: "Home wallet",
            amount: 1234.0,
            type: WalletType.cash))
  ];
  final List<Transaction> list2 = [
    Transaction(
        id: "id1",
        amount: 120.4,
        isIncome: false,
        category: TrxCategory(id: "1", name: "Gift"),
        date: DateTime.now(),
        desc: "desc1",
        name: "name1",
        wallet: Wallet(
            id: "1",
            name: "OTP Bank",
            amount: 123456.0,
            type: WalletType.card)),
    Transaction(
        id: "id1",
        amount: 120.4,
        isIncome: false,
        category: TrxCategory(id: "1", name: "Gift"),
        date: DateTime.now(),
        desc: "desc1",
        name: "name1",
        wallet: Wallet(
            id: "1",
            name: "OTP Bank",
            amount: 123456.0,
            type: WalletType.card)),
    Transaction(
        id: "id2",
        amount: 1221.4,
        isIncome: false,
        category: TrxCategory(id: "2", name: "Food"),
        date: DateTime.now(),
        desc: "desc2",
        name: "name2",
        wallet: Wallet(
            id: "2",
            name: "Home wallet",
            amount: 1234.0,
            type: WalletType.cash))
  ];

  @override
  Widget build(BuildContext context) {
    print("MainScreen build()");
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
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
                                okText: "Confirm",
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
                          style: TextStyle(fontSize: 28),
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
              FinancialSummaryWidget(
                list: list1,
                isIncome: true,
              ),
              FinancialSummaryWidget(
                list: list2,
                isIncome: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FinancialSummaryWidget extends StatelessWidget {
  final bool isIncome;
  final List<Transaction> list;

  FinancialSummaryWidget(
      {Key key, @required this.isIncome, @required this.list})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("IncomeWidget build()");

    String prefix = isIncome ? "+" : "-";

    //FlutterMoneyFormatter fmf = FlutterMoneyFormatter(amount: 12345678.9012345);

    //MoneyFormatterOutput fo = fmf.output;

    return ExpandableNotifier(
      // <-- Provides ExpandableController to its children
      child: getAppCardStyle(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Padding(
                      //  padding: const EdgeInsets.only(bottom: 5),
                      //  child: isIncome
                      //      ? Text("Income:", style: TextStyle(fontSize: 18))
                      //      : Text("Expense:", style: TextStyle(fontSize: 18)),
                      //),
                      FittedText(
                        size: 32,
                        color: isIncome ? Colors.green : Colors.red,
                        text: "$prefix 12,234.00 Ft",
                        fitSize: 250,
                      )
                    ],
                  ),
                  FloatingActionButton(
                      child: Icon(Icons.add),
                      heroTag: null,
                      backgroundColor: isIncome ? Colors.green : Colors.red,
                      onPressed: () {
                        openDialog(
                            context,
                            AddEditTrxScreen(
                              isIncome: isIncome,
                            ));
                      })
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Expandable(
                // <-- Driven by ExpandableController from ExpandableNotifier
                collapsed: ExpandableButton(
                  // <-- Expands when tapped on the cover photo
                  child: Container(
                    padding: EdgeInsets.only(bottom: 5),
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: Text(
                      "Details",
                      style: TextStyle(color: Colors.blue, fontSize: 18),
                    ),
                  ),
                ),

                expanded: TrxDetailsWidget(
                  list: list,
                  isIncome: isIncome,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TrxDetailsWidget extends StatelessWidget {
  final List<Transaction> list;
  final bool isIncome;

  TrxDetailsWidget({Key key, @required this.list, @required this.isIncome})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          width: double.infinity,
          child: Text("Transactions:",
              style: TextStyle(
                fontSize: 18,
                decoration: TextDecoration.underline,
              ))),
      ListView.builder(
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return TrxListItem(
                trx: list[index],
                amountColor: isIncome ? Colors.green : Colors.red);
          }),
      //TrxListItem(trx:asd2, Colors.green),
      Container(
        padding: EdgeInsets.fromLTRB(5, 5, 15, 5),
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

  const TrxListItem({@required this.trx, @required this.amountColor});

  @override
  Widget build(BuildContext context) {
    String prefix = trx.isIncome ? "+" : "-";
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
              FittedText(
                text: trx.name,
                color: Colors.black,
                size: 18,
                fitSize: 185,
              ),
              InkWell(
                  onTap: () {
                    openDialog(context, AddEditTrxScreen(trx: trx));
                  },
                  child: Text(
                    "Edit",
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  ))
            ],
          ),
          Divider(color: Colors.black),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                trx.wallet.type.icon,
                FittedText(
                  text: trx.wallet.name,
                  color: Colors.black,
                  size: 18,
                  fitSize: 125,
                ),
              ],
            ),
            FittedText(
              text: "$prefix ${trx.amount}Ft",
              color: amountColor,
              size: 18,
              fitSize: 150,
              align: AlignmentDirectional.centerEnd,
            ),
          ])
        ],
      ),
    );
  }
}

class AddEditTrxScreen extends StatelessWidget {
  final Transaction trx;
  final bool isIncome;

  final DateTime time = DateTime.now();

  final nameCtrl = TextEditingController();
  final amountCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  AddEditTrxScreen({Key key, this.trx, this.isIncome = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("AddEditTrxScreen build()");

    bool hasTrx = false;
    if (trx != null) {
      hasTrx = true;
      nameCtrl.text = trx.name;
      amountCtrl.text = trx.amount.toString();
      descCtrl.text = trx.desc;
    }

    return Material(
        type: MaterialType.transparency,
        // make sure that the overlay content is not cut off
        child: Container(
            padding: EdgeInsets.fromLTRB(10, 35, 10, 75),
            child: getAppCardStyle(
              child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: FlutterDatePickerTimeline(
                          selectedItemBackgroundColor: Colors.blue,
                          startDate: DateTime(time.year, time.month, 01),
                          endDate: DateTime(time.year, time.month,
                              daysInMonth(time.year, time.month)),
                          initialSelectedDate: time,
                          onSelectedDateChange: (DateTime dateTime) {
                            print(dateTime);
                          },
                        ),
                      ),
                      ListView(
                        shrinkWrap: true,
                        children: [
                          Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 275,
                                    child: InputDecorator(
                                      decoration: getAppTextFieldDecoration(
                                          labelText: "Category",
                                          hintText: "Category"),
                                      child: DropdownButtonHideUnderline(
                                        child: Container(
                                          height: 25,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 15),
                                            child: DropdownButton<String>(
                                              value: "Apple",
                                              items: [
                                                DropdownMenuItem(
                                                    value: "Apple",
                                                    child: Text('Apple')),
                                                DropdownMenuItem(
                                                    value: 'Google',
                                                    child: Text('Google')),
                                                DropdownMenuItem(
                                                    value: 'Samsung',
                                                    child: Text('Samsung')),
                                                DropdownMenuItem(
                                                    value: 'Sony',
                                                    child: Text('Sony')),
                                              ],
                                              onChanged: (String newValue) {
                                                //S setState(() {
                                                //S   dropdownValue = newValue;
                                                //S });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      addCategoryDialog(context);
                                    },
                                    child: Icon(
                                      Icons.add_rounded,
                                      color: Colors.blue,
                                      size: 40,
                                    ),
                                  )
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
                            child: Container(
                              height: 50,
                              width: 275,
                              child: InputDecorator(
                                decoration: getAppTextFieldDecoration(
                                    labelText: "Wallet", hintText: "Wallet"),
                                child: DropdownButtonHideUnderline(
                                  child: Container(
                                    height: 25,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: DropdownButton<String>(
                                        value: "Otp card",
                                        items: [
                                          DropdownMenuItem(
                                              value: "Otp card",
                                              child: Text('Otp card')),
                                          DropdownMenuItem(
                                              value: 'Home cash',
                                              child: Text('Home wallet')),
                                        ],
                                        onChanged: (String newValue) {
                                          //S setState(() {
                                          //S   dropdownValue = newValue;
                                          //S });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
                            child: TextField(
                              controller: amountCtrl,
                              decoration: getAppTextFieldDecoration(
                                  labelText: "Amount", hintText: "Amount"),
                              autofocus: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
                            child: TextField(
                              controller: descCtrl,
                              maxLines: 6,
                              decoration: getAppTextFieldDecoration(
                                labelText: 'Details',
                                hintText: 'Details',
                              ),
                              autofocus: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 10, 8),
                            child: Row(
                              children: <Widget>[
                                Text("Images:",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: 18)),
                                Spacer(),
                                IconButton(
                                  icon: Icon(
                                    Icons.camera,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () {
                                    //getImage(ImageSource.camera);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.image, color: Colors.blue),
                                  onPressed: () {
                                    //getImage(ImageSource.gallery);
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 10, 8),
                            child: GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3),
                                itemCount: 1,
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                      child: Container(
                                        //decoration: BoxDecoration(
                                        //  image: DecorationImage(
                                        //    image: FileImage(images[index]),
                                        //    fit: BoxFit.cover,
                                        //  ),
                                        //),
                                        child: Text('2'),
                                      ),
                                      onTap: () => print("image"),
                                    )),
                          )
                        ],
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.arrow_back)),
                            Spacer(),
                            Visibility(
                              visible: !hasTrx,
                              child: FloatingActionButton(
                                  heroTag: "addBtn",
                                  child: Icon(Icons.add),
                                  backgroundColor:
                                      isIncome ? Colors.green : Colors.red,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                            ),
                            Visibility(
                                visible: hasTrx,
                                child: Row(
                                  children: [
                                    FloatingActionButton(
                                        heroTag: "deleteBtn",
                                        child: Icon(Icons.delete),
                                        backgroundColor: Colors.red,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    FloatingActionButton(
                                        child: Icon(Icons.copy),
                                        heroTag: "copyBtn",
                                        backgroundColor: Colors.blue,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    FloatingActionButton(
                                        heroTag: "saveBtn",
                                        child: Icon(Icons.save),
                                        backgroundColor: Colors.green,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }),
                                  ],
                                ))
                          ],
                        ),
                      )
                    ],
                  )),
            )));
  }
}
