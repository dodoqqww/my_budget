import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:my_budget/ui/widgets/add_category_dialog.dart';
import 'package:my_budget/ui/widgets/fitted_text.dart';
import 'package:my_budget/ui/widgets/legend_widget.dart';

import './/models/reminder.dart';
import './/models/wallet.dart';
import './/ui/common/animations.dart';
import './/ui/common/style.dart';
import './/utils/util_datas.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("SettingsScreen build()");
    return Scaffold(
        body: Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: Column(
          children: [WalletSettings(), RemindersSettings(), OtherSettings()],
        ),
      ),
    ));
  }
}

class WalletSettings extends StatelessWidget {
  final wallet1 = Wallet(
      id: "1", name: "OTP card", amount: 123456.0, type: WalletType.card);
  final wallet2 = Wallet(
      id: "2", name: "Home wallet", amount: 1234.0, type: WalletType.cash);

  @override
  Widget build(BuildContext context) {
    return getAppCardStyle(
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(10),
        shrinkWrap: true,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Wallets:",
                style: Theme.of(context).textTheme.headline2,
              ),
              FloatingActionButton(
                  child: Icon(Icons.add),
                  heroTag: "addWalletBtn",
                  backgroundColor: Colors.green,
                  onPressed: () {
                    openDialog(context, AddEditWalletScreen());
                  })
            ],
          ),
          Divider(
            thickness: 2,
          ),
          ListView(
            shrinkWrap: true,
            children: [
              WalletListWidget(
                wallet: wallet1,
              ),
              WalletListWidget(
                wallet: wallet2,
              )
            ],
          )
        ],
      ),
    );
  }
}

class WalletListWidget extends StatelessWidget {
  final Wallet wallet;

  const WalletListWidget({Key key, @required this.wallet}) : super(key: key);

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
              FittedText(
                text: wallet.name,

                style: Theme.of(context).textTheme.bodyText1,
                fitSize: 180,
                //align: AlignmentDirectional.centerEnd,
              ),
              InkWell(
                  onTap: () {
                    openDialog(
                        context,
                        AddEditWalletScreen(
                          wallet: wallet,
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
          AppListItemDivider(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
              text: "+ ${wallet.amount} Ft",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.green),
              fitSize: 150,
              align: AlignmentDirectional.centerEnd,
            )
          ])
        ],
      ),
    );
  }
}

class RemindersSettings extends StatelessWidget {
  final rem1 = Reminder(
      id: "1", name: "Add salary", frequency: "Every month 10. at 12h");
  final rem2 =
      Reminder(id: "2", name: "Add food", frequency: "Every day at 6h");

  @override
  Widget build(BuildContext context) {
    return getAppCardStyle(
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(10),
        shrinkWrap: true,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Reminders:",
                style: Theme.of(context).textTheme.headline2,
              ),
              FloatingActionButton(
                  heroTag: "addReminderBtn",
                  child: Icon(Icons.add),
                  backgroundColor: Colors.green,
                  onPressed: () {
                    openDialog(context, AddEditReminderScreen());
                  })
            ],
          ),
          Divider(
            thickness: 2,
          ),
          ListView(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            children: [
              ReminderListWidget(
                reminder: rem1,
              ),
              ReminderListWidget(
                reminder: rem2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ReminderListWidget extends StatelessWidget {
  final Reminder reminder;

  const ReminderListWidget({Key key, @required this.reminder})
      : super(key: key);

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
              FittedText(
                text: reminder.name,
                style: Theme.of(context).textTheme.bodyText1,
                fitSize: 185,
              ),
              InkWell(
                  onTap: () {
                    openDialog(
                        context,
                        AddEditReminderScreen(
                          reminder: reminder,
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
          Divider(color: Colors.black),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            FittedText(
              text: reminder.frequency,
              style: Theme.of(context).textTheme.bodyText1,
              fitSize: 215,
            ),
            ToggleSwitch(
              minHeight: 30,
              minWidth: 40.0,
              cornerRadius: 20.0,
              activeBgColors: [
                [Colors.green],
                [Colors.red]
              ],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              initialLabelIndex: 1,
              totalSwitches: 2,
              labels: ['On', 'Off'],
              //animate: true,
              //curve: Curves.decelerate,
              radiusStyle: true,
              onToggle: (index) {
                print('switched to: $index');
              },
            ),
          ])
        ],
      ),
    );
  }
}

class OtherSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return getAppCardStyle(
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(10),
        shrinkWrap: true,
        children: [
          Text(
            "Others:",
            style: Theme.of(context).textTheme.headline2,
          ),
          Divider(
            thickness: 2,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Category management",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    IconButton(
                        onPressed: () {
                          openDialog(context, AddEditCategoryScreen());
                        },
                        icon: Icon(Icons.category, color: Colors.blue))
                  ],
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Currency setting",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    IconButton(
                        onPressed: () {
                          print("currency settings");
                        },
                        icon: Icon(Icons.paid, color: Colors.blue))
                  ],
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Backup",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    IconButton(
                        onPressed: () {
                          print("backup google drive");
                        },
                        icon: Icon(Icons.backup, color: Colors.blue))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AddEditWalletScreen extends StatelessWidget {
  final Wallet wallet;

  final nameCtrl = TextEditingController();
  final amountCtrl = TextEditingController();

  AddEditWalletScreen({Key key, this.wallet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool hasWallet = false;
    WalletType type;
    if (wallet != null) {
      print("asd");
      hasWallet = true;
      nameCtrl.text = wallet.name;
      amountCtrl.text = wallet.amount.toString();
      type = wallet.type;
    }

    print("AddWalletScreen build()");
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
                      ListView(
                        shrinkWrap: true,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 8, 20),
                            child: Text(
                              "Wallet:",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
                            child: TextField(
                              style: Theme.of(context).textTheme.bodyText1,
                              controller: nameCtrl,
                              decoration: getAppTextFieldDecoration(
                                  labelText: 'Name', context: context),
                              autofocus: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
                            child: TextField(
                              style: Theme.of(context).textTheme.bodyText1,
                              controller: amountCtrl,
                              decoration: getAppTextFieldDecoration(
                                  labelText: 'Amount', context: context),
                              autofocus: false,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8.0),
                            child: ToggleSwitch(
                              iconSize: 24,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .fontSize,
                              minWidth: 150,
                              initialLabelIndex:
                                  type == WalletType.card ? 0 : 1,
                              cornerRadius: 20.0,
                              activeFgColor: Colors.white,
                              inactiveBgColor: Colors.grey,
                              inactiveFgColor: Colors.white,
                              totalSwitches: 2,
                              labels: [
                                WalletType.card.name,
                                WalletType.cash.name
                              ],
                              icons: [Icons.credit_card, Icons.paid],
                              onToggle: (index) {
                                print('switched to: $index');
                              },
                            ),
                          ),

                          // TODO implement oprional fee feature

                          //  Padding(
                          //    padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
                          //    child: Row(
                          //      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //      children: [
                          //        Text("Other options:"),
                          //        IconButton(
                          //            onPressed: () {}, icon: Icon(Icons.add))
                          //      ],
                          //    ),
                          //  ),
                          //  ListView(
                          //    shrinkWrap: true,
                          //    padding: EdgeInsets.only(left: 25),
                          //    children: [
                          //      Row(
                          //        mainAxisAlignment:
                          //            MainAxisAlignment.spaceBetween,
                          //        children: [Text("Online fee"), Text("xxx Ft")],
                          //      ),
                          //      Text("Other fee")
                          //    ],
                          //  )
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
                            Visibility(
                              visible: hasWallet,
                              child: FloatingActionButton(
                                  heroTag: "deleteRemBtn",
                                  child: Icon(Icons.delete),
                                  backgroundColor: Colors.red,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                            ),
                            FloatingActionButton(
                                heroTag: "saveAddRemBtn",
                                child: wallet != null
                                    ? Icon(Icons.save)
                                    : Icon(Icons.add),
                                backgroundColor: Colors.green,
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ],
                        ),
                      )
                    ],
                  )),
            )));
  }
}

class AddEditReminderScreen extends StatelessWidget {
  final Reminder reminder;

  final nameCtrl = TextEditingController();

  AddEditReminderScreen({Key key, this.reminder}) : super(key: key);

  final PickerDataAdapter<String> pickAdapter = PickerDataAdapter<String>(
      pickerdata: new JsonDecoder().convert(PickerData));

  @override
  Widget build(BuildContext context) {
    final picker = Picker(
      textStyle: Theme.of(context).textTheme.bodyText1,
      hideHeader: true,
      adapter: pickAdapter,
    );

    if (reminder != null) {
      nameCtrl.text = reminder.name;
      picker.selecteds = [1, 1, 1];
    }

    print("AddEditReminderScreen build()");
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
                      ListView(
                        shrinkWrap: true,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 8, 20),
                            child: Text(
                              "Reminder:",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
                            child: TextField(
                              style: Theme.of(context).textTheme.bodyText1,
                              controller: nameCtrl,
                              decoration: getAppTextFieldDecoration(
                                  labelText: 'Name', context: context),
                              autofocus: false,
                            ),
                          ),
                          picker.makePicker(),
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
                            FloatingActionButton(
                                heroTag: "deleteFreBtn",
                                child: Icon(Icons.delete),
                                backgroundColor: Colors.red,
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                            FloatingActionButton(
                                heroTag: "saveAddFreBtn",
                                child: reminder != null
                                    ? Icon(Icons.save)
                                    : Icon(Icons.add),
                                backgroundColor: Colors.green,
                                onPressed: () {
                                  print(pickAdapter.getSelectedValues());
                                  print(picker.selecteds);
                                  Navigator.pop(context);
                                }),
                          ],
                        ),
                      )
                    ],
                  )),
            )));
  }
}

//TODO make better UI
class AddEditCategoryScreen extends StatelessWidget {
  final nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("AddEditCategoryScreen build()");
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
                      ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 8, 20),
                            child: Text(
                              "Categorys:",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: InkWell(
                                        onTap: () {
                                          openColorPicker(context);
                                        },
                                        child: Icon(
                                          Icons.circle,
                                          size: 32,
                                          color: Colors.amber,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      width: 225,
                                      child: TextField(
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        decoration: getAppTextFieldDecoration(
                                            labelText: "Name",
                                            context: context),
                                        controller: nameCtrl,
                                      ),
                                    ),
                                  ],
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
                            ),
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                            height: 350,
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                _settingsMyLegendWidget(
                                    text: "Investment",
                                    color: Colors.amber,
                                    context: context),
                                _settingsMyLegendWidget(
                                    text: "Food",
                                    color: Colors.red,
                                    context: context),
                                _settingsMyLegendWidget(
                                    text: "Car",
                                    color: Colors.green,
                                    context: context),
                                _settingsMyLegendWidget(
                                    text: "legendtest",
                                    color: Colors.amber,
                                    context: context),
                                _settingsMyLegendWidget(
                                    text: "legendtest",
                                    color: Colors.amber,
                                    context: context),
                                _settingsMyLegendWidget(
                                    text: "legendtest",
                                    color: Colors.amber,
                                    context: context),
                                _settingsMyLegendWidget(
                                    text: "legendtest",
                                    color: Colors.amber,
                                    context: context),
                                _settingsMyLegendWidget(
                                    text: "legendtest",
                                    color: Colors.amber,
                                    context: context),
                              ],
                            ),
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
                            FloatingActionButton(
                                heroTag: "deleteCatBtn",
                                child: Icon(Icons.delete),
                                backgroundColor: Colors.red,
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                            FloatingActionButton(
                                heroTag: "saveCatBtn",
                                child: Icon(Icons.save),
                                backgroundColor: Colors.green,
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ],
                        ),
                      )
                    ],
                  )),
            )));
  }

  Widget _settingsMyLegendWidget(
      {@required String text,
      @required Color color,
      @required BuildContext context}) {
    return GestureDetector(
      onTap: () {
        print("ouch: $text");
        nameCtrl.text = text;
      },
      child: Column(
        children: [
          MyLegendWidget(
            style: Theme.of(context).textTheme.bodyText1,
            text: text,
            color: color,
            space: 5.0,
          ),
          Divider(
            thickness: 1,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
