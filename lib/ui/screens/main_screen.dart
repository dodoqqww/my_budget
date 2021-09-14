import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'
    hide DropdownButton, DropdownMenuItem, DropdownButtonHideUnderline;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:my_budget/providers/main_screen_providers.dart';
import 'package:my_budget/ui/widgets/add_category_dialog.dart';
import 'package:my_budget/ui/widgets/fitted_text.dart';
import 'package:my_budget/utils/util_methods.dart';
import './/models/transaction_category.dart';
import './/ui/widgets/dropdown_widget.dart';
import 'package:provider/provider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_date_picker_timeline/flutter_date_picker_timeline.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import './/models/transaction.dart';
import './/models/wallet.dart';
import './/ui/common/animations.dart';
import './/ui/common/style.dart';
import 'package:quiver/time.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("MainScreen build()");
    final mainScreenProvider = context.watch<MainScreenProvider>();
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
                                initialDate: mainScreenProvider.selectedDate,
                                //locale: Locale("es"),
                              ).then((date) {
                                print("asd");
                                mainScreenProvider.changeDate(date);
                              });
                            },
                            icon: Icon(
                              Icons.date_range,
                              color: Colors.blue,
                            )),
                        Text(
                          getFormatedyyyyMMMMDate(
                              mainScreenProvider.selectedDate),
                          style: Theme.of(context).textTheme.headline2,
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
              IncomeWidget(selectedDate: mainScreenProvider.selectedDate),
              ExpenseWidget(selectedDate: mainScreenProvider.selectedDate),
            ],
          ),
        ),
      ),
    );
  }
}

class IncomeWidget extends StatelessWidget {
  final DateTime selectedDate;

  const IncomeWidget({Key key, this.selectedDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("IncomeWidget build()");
    final incomeWidgetProvider = context.watch<IncomeWidgetProvider>();

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
                      FittedText(
                        style: Theme.of(context)
                            .textTheme
                            .headline1
                            .copyWith(color: Colors.green),
                        text:
                            "+ ${getFormattedCurrency(context: context, value: incomeWidgetProvider.getSumIncome(month: selectedDate))}",
                        fitSize: 250,
                      )
                    ],
                  ),
                  FloatingActionButton(
                      child: Icon(Icons.add),
                      heroTag: null,
                      backgroundColor: Colors.green,
                      onPressed: () {
                        openDialog(
                            context,
                            AddEditTrxScreen(
                              isIncome: true,
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
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.blue),
                    ),
                  ),
                ),

                expanded: TrxDetailsWidget(
                  list: incomeWidgetProvider.getAllExpenseTrxs(
                      month: selectedDate),
                  isIncome: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpenseWidget extends StatelessWidget {
  final DateTime selectedDate;

  const ExpenseWidget({Key key, this.selectedDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("ExpenseWidget build()");
    final expenseWidgetProvider = context.watch<ExpenseWidgetProvider>();
    // print(expenseWidgetProvider.allExpenseTrxs.length);
    //_getFormattedCurrency(context);

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
                      FittedText(
                        style: Theme.of(context)
                            .textTheme
                            .headline1
                            .copyWith(color: Colors.red),
                        text:
                            "- ${getFormattedCurrency(context: context, value: expenseWidgetProvider.getSumExpense(month: selectedDate))}",
                        fitSize: 250,
                      )
                    ],
                  ),
                  FloatingActionButton(
                      child: Icon(Icons.add),
                      heroTag: null,
                      backgroundColor: Colors.red,
                      onPressed: () {
                        openDialog(context, AddEditTrxScreen(isIncome: false));
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
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.blue),
                    ),
                  ),
                ),

                expanded: TrxDetailsWidget(
                  list: expenseWidgetProvider.getAllExpenseTrxs(
                      month: selectedDate),
                  isIncome: false,
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
                fontSize: Theme.of(context).textTheme.bodyText1.fontSize,
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
    final addEditTrxScreenProvider = context.read<AddEditTrxScreenProvider>();
    String prefix = trx.isIncome ? "+" : "-";
    return Row(
      children: [
        RotatedBox(
            quarterTurns: 3,
            child: Text(
              getFormatedMMddDate(trx.date),
              style: Theme.of(context).textTheme.bodyText2,
            )),
        Container(
          width: 320,
          //height: 100,
          margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
          decoration: BoxDecoration(
              border: Border(
            left: BorderSide(
              //color: Colors.green,
              width: 1,
            ),
          )),
          //padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FittedText(
                      text: trx.category.name,
                      style: Theme.of(context).textTheme.bodyText1,
                      fitSize: 185,
                    ),
                    InkWell(
                        onTap: () {
                          addEditTrxScreenProvider
                              .changeSelectedCategory(trx.category);
                          addEditTrxScreenProvider
                              .changeSelectedWallet(trx.wallet);
                          openDialog(context, AddEditTrxScreen(trx: trx));
                        },
                        child: Text(
                          "Edit",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.blue),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: AppListItemDivider(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          trx.wallet.type.icon,
                          FittedText(
                            text: trx.wallet.name,
                            style: Theme.of(context).textTheme.bodyText1,
                            fitSize: 125,
                          ),
                        ],
                      ),
                      FittedText(
                        text:
                            "$prefix ${getFormattedCurrency(context: context, value: trx.amount)}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: amountColor),
                        fitSize: 150,
                        align: AlignmentDirectional.centerEnd,
                      ),
                    ]),
              )
            ],
          ),
        ),
      ],
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

    final addEditTrxScreenProvider = context.watch<AddEditTrxScreenProvider>();

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
                          unselectedItemTextStyle: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.blue),
                          selectedItemTextStyle: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.white),
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
                                          context: context),
                                      child: DropdownButtonHideUnderline(
                                        child: Container(
                                          height: 25,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 15),
                                            child: DropdownButton<TrxCategory>(
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                              value: addEditTrxScreenProvider
                                                  .selectedCategory,
                                              items: getTrxDropDown(
                                                  addEditTrxScreenProvider
                                                      .allCategorys,
                                                  cat: hasTrx
                                                      ? trx.category
                                                      : null),
                                              onChanged:
                                                  (TrxCategory newValue) {
                                                addEditTrxScreenProvider
                                                    .changeSelectedCategory(
                                                        newValue);
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
                                    labelText: "Wallet", context: context),
                                child: DropdownButtonHideUnderline(
                                  child: Container(
                                    height: 25,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: DropdownButton<Wallet>(
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        value: addEditTrxScreenProvider
                                            .selectedWallet,
                                        items: getWalletDropDown(
                                            addEditTrxScreenProvider.allWallets,
                                            wallet: hasTrx ? trx.wallet : null),
                                        onChanged: (Wallet newValue) {
                                          addEditTrxScreenProvider
                                              .changeSelectedWallet(newValue);
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
                              style: Theme.of(context).textTheme.bodyText1,
                              controller: amountCtrl,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: getAppTextFieldDecoration(
                                  labelText: "Amount", context: context),
                              autofocus: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
                            child: TextField(
                              style: Theme.of(context).textTheme.bodyText1,
                              controller: descCtrl,
                              maxLines: 6,
                              decoration: getAppTextFieldDecoration(
                                  labelText: 'Details', context: context),
                              autofocus: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 10, 8),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Images:",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
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
                          Container(
                            height: 100,
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
                                    addEditTrxScreenProvider.addTrx();
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
                                          addEditTrxScreenProvider.deleteTrx();
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
                                          addEditTrxScreenProvider.copyTrx();
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
                                          addEditTrxScreenProvider.updateTrx();
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

  List<DropdownMenuItem> getTrxDropDown(List<TrxCategory> cats,
      {TrxCategory cat}) {
    List<DropdownMenuItem> list = cats.map((e) {
      return new DropdownMenuItem<TrxCategory>(
        child: Text(e.name),
        value: e,
      );
    }).toList();
    if (trx != null) {
      list.add(new DropdownMenuItem<TrxCategory>(
        child: Text(cat.name),
        value: cat,
      ));
    }

    return list;
  }

  //TODO BUG
  List<DropdownMenuItem> getWalletDropDown(List<Wallet> wallets,
      {Wallet wallet}) {
    List<DropdownMenuItem> list = wallets.map((e) {
      return new DropdownMenuItem<Wallet>(
        child: Text(e.name),
        value: e,
      );
    }).toList();

    if (wallet != null) {
      list.add(new DropdownMenuItem<Wallet>(
        child: Text(wallet.name),
        value: wallet,
      ));
    }

    return list;
  }
}
