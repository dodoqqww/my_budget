import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'
    hide DropdownButton, DropdownMenuItem, DropdownButtonHideUnderline;
import 'package:flutter/services.dart';
import 'package:my_budget/models/wallet_type.dart';
import 'package:my_budget/providers/main_screen_providers.dart';
import 'package:my_budget/providers/settings_screen_providers.dart';
import 'package:my_budget/services/database_manager_service.dart';
import 'package:my_budget/services/service_locator.dart';
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
    final incomeWidgetProvider = context.read<IncomeWidgetProvider>();
    final expenseWidgetProvider = context.read<ExpenseWidgetProvider>();
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
                                if (date != null &&
                                    date != mainScreenProvider.selectedDate) {
                                  mainScreenProvider.changeDate(date);
                                  incomeWidgetProvider.refreshIncome(
                                      month: date);
                                  expenseWidgetProvider.refreshExpense(
                                      month: date);
                                }
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
                            "+ ${getFormattedCurrency(context: context, value: incomeWidgetProvider.sumIncome)}",
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
                            AddTrxScreen(
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
                  list: incomeWidgetProvider.allIncomeTrxs,
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
                            "- ${getFormattedCurrency(context: context, value: expenseWidgetProvider.sumExpense)}",
                        fitSize: 250,
                      )
                    ],
                  ),
                  FloatingActionButton(
                      child: Icon(Icons.add),
                      heroTag: null,
                      backgroundColor: Colors.red,
                      onPressed: () {
                        openDialog(context, AddTrxScreen(isIncome: false));
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
                  list: expenseWidgetProvider.allExpenseTrxs,
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
      list.length == 0
          ? Text("No Data")
          : ListView.builder(
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                print("$isIncome " + list[index].toString());
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

    Wallet wallet = getIt<DatabaseManagerService>().getWalletById(trx.walletId);

    TrxCategory trxCategory =
        getIt<DatabaseManagerService>().getTrxCategoryById(trx.categoryId);

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
                      text: trxCategory.name,
                      style: Theme.of(context).textTheme.bodyText1,
                      fitSize: 185,
                    ),
                    InkWell(
                        onTap: () {
                          addEditTrxScreenProvider
                              .changeSelectedEditCategory(trxCategory);
                          addEditTrxScreenProvider
                              .changeSelectedEditWallet(wallet);
                          openDialog(
                              context,
                              EditTrxScreen(
                                trx: trx,
                                isIncome: trx.isIncome,
                              ));
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
                          wallet.type.icon,
                          FittedText(
                            text: wallet.name,
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

class AddTrxScreen extends StatelessWidget {
  final bool isIncome;

  final nameCtrl = TextEditingController();
  final amountCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  AddTrxScreen({Key key, this.isIncome = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("AddScreen build()");

    final addEditTrxScreenProvider = context.watch<AddEditTrxScreenProvider>();
    final addEditCategoryScreenProvider =
        context.watch<AddEditCategoryScreenProvider>();
    final walletSettingsProvider = context.watch<WalletSettingsProvider>();
    final incomeWidgetProvider = context.watch<IncomeWidgetProvider>();
    final expenseWidgetProvider = context.watch<ExpenseWidgetProvider>();
    final mainScreenProvider = context.watch<MainScreenProvider>();

    DateTime time = mainScreenProvider.selectedDate;

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
                            time = dateTime;
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
                                            child:
                                                new DropdownButton<TrxCategory>(
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                              value: addEditTrxScreenProvider
                                                  .selectedAddCategory,
                                              items: _getCatDropDown(
                                                  addEditCategoryScreenProvider
                                                      .allCategorys),
                                              onChanged:
                                                  (TrxCategory newValue) {
                                                addEditTrxScreenProvider
                                                    .changeSelectedAddCategory(
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
                                            .selectedAddWallet,
                                        items: _getWalletDropDown(
                                            walletSettingsProvider.allWallets),
                                        onChanged: (Wallet newValue) {
                                          addEditTrxScreenProvider
                                              .changeSelectedAddWallet(
                                                  newValue);
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
                            FloatingActionButton(
                                heroTag: "saveBtn",
                                child: Icon(Icons.save),
                                backgroundColor: Colors.green,
                                onPressed: () async {
                                  Navigator.pop(context);
                                  await addEditTrxScreenProvider.addTrx(
                                      desc: descCtrl.text,
                                      amount: double.parse(amountCtrl.text),
                                      isIncome: isIncome,
                                      date: time);

                                  isIncome
                                      ? incomeWidgetProvider.refreshIncome(
                                          month:
                                              mainScreenProvider.selectedDate)
                                      : expenseWidgetProvider.refreshExpense(
                                          month:
                                              mainScreenProvider.selectedDate);
                                }),
                          ],
                        ),
                      )
                    ],
                  )),
            )));
  }

  List<DropdownMenuItem<TrxCategory>> _getCatDropDown(List<TrxCategory> cats) {
    List<DropdownMenuItem> list = cats.map((e) {
      return new DropdownMenuItem<TrxCategory>(
        child: Text(e.name),
        value: e,
      );
    }).toList();
    return list;
  }

  List<DropdownMenuItem> _getWalletDropDown(List<Wallet> wallets) {
    List<DropdownMenuItem> list = wallets.map((e) {
      return new DropdownMenuItem<Wallet>(
        child: Text(e.name),
        value: e,
      );
    }).toList();

    return list;
  }
}

class EditTrxScreen extends StatelessWidget {
  final Transaction trx;
  final bool isIncome;

  final nameCtrl = TextEditingController();
  final amountCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  EditTrxScreen({Key key, this.trx, this.isIncome = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("EditTrxScreen build()");

    DateTime time = DateTime.now();

    final addEditTrxScreenProvider = context.watch<AddEditTrxScreenProvider>();
    final addEditCategoryScreenProvider =
        context.watch<AddEditCategoryScreenProvider>();
    final walletSettingsProvider = context.watch<WalletSettingsProvider>();
    final incomeWidgetProvider = context.watch<IncomeWidgetProvider>();
    final expenseWidgetProvider = context.watch<ExpenseWidgetProvider>();
    final mainScreenProvider = context.watch<MainScreenProvider>();

    Wallet wallet = getIt<DatabaseManagerService>().getWalletById(trx.walletId);
    TrxCategory trxCategory =
        getIt<DatabaseManagerService>().getTrxCategoryById(trx.categoryId);

    amountCtrl.text = trx.amount.toString();
    descCtrl.text = trx.desc;
    time = trx.date;

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
                            time = dateTime;
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
                                                  .selectedEditCategory,
                                              items: _getCatDropDown(
                                                  addEditCategoryScreenProvider
                                                      .allCategorys,
                                                  cat: trxCategory),
                                              onChanged:
                                                  (TrxCategory newValue) {
                                                addEditTrxScreenProvider
                                                    .changeSelectedEditCategory(
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
                                            .selectedEditWallet,
                                        items: _getWalletDropDown(
                                            walletSettingsProvider.allWallets,
                                            wallet: wallet),
                                        onChanged: (Wallet newValue) {
                                          addEditTrxScreenProvider
                                              .changeSelectedEditWallet(
                                                  newValue);
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
                            Row(children: [
                              FloatingActionButton(
                                  heroTag: "deleteBtn",
                                  child: Icon(Icons.delete),
                                  backgroundColor: Colors.red,
                                  onPressed: () {
                                    addEditTrxScreenProvider.deleteTrx(trx);
                                    Navigator.pop(context);
                                    isIncome
                                        ? incomeWidgetProvider.refreshIncome(
                                            month:
                                                mainScreenProvider.selectedDate)
                                        : expenseWidgetProvider.refreshExpense(
                                            month: mainScreenProvider
                                                .selectedDate);
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
                                  heroTag: "editBtn",
                                  child: Icon(Icons.edit),
                                  backgroundColor: Colors.green,
                                  onPressed: () {
                                    addEditTrxScreenProvider.updateTrx(trx,
                                        amount: double.parse(amountCtrl.text),
                                        desc: descCtrl.text,
                                        time: time);
                                    Navigator.pop(context);

                                    isIncome
                                        ? incomeWidgetProvider.refreshIncome(
                                            month:
                                                mainScreenProvider.selectedDate)
                                        : expenseWidgetProvider.refreshExpense(
                                            month: mainScreenProvider
                                                .selectedDate);
                                  }),
                            ])
                          ],
                        ),
                      )
                    ],
                  )),
            )));
  }

  List<DropdownMenuItem> _getCatDropDown(List<TrxCategory> cats,
      {TrxCategory cat}) {
    bool contains = false;
    List<DropdownMenuItem> list = cats.map((e) {
      if (e == cat) {
        contains = true;
      }

      return new DropdownMenuItem<TrxCategory>(
        child: Text(e.name),
        value: e,
      );
    }).toList();
    if (!contains) {
      list.add(new DropdownMenuItem<TrxCategory>(
        child: Text(cat.name),
        value: cat,
      ));
    }

    return list;
  }

  List<DropdownMenuItem> _getWalletDropDown(List<Wallet> wallets,
      {Wallet wallet}) {
    bool contains = false;
    List<DropdownMenuItem> list = wallets.map((e) {
      if (e == wallet) {
        contains = true;
      }
      return new DropdownMenuItem<Wallet>(
        child: Text(e.name),
        value: e,
      );
    }).toList();

    if (!contains) {
      list.add(new DropdownMenuItem<Wallet>(
        child: Text(wallet.name),
        value: wallet,
      ));
    }

    return list;
  }
}
