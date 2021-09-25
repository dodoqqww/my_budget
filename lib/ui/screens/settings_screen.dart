import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:my_budget/models/transaction_category.dart';
import 'package:my_budget/models/wallet_type.dart';
import 'package:my_budget/providers/settings_screen_providers.dart';
import 'package:my_budget/ui/widgets/add_category_dialog.dart';
import 'package:my_budget/ui/widgets/fitted_text.dart';
import 'package:my_budget/ui/widgets/legend_widget.dart';
import 'package:my_budget/utils/util_methods.dart';

import './/models/reminder.dart';
import './/models/wallet.dart';
import './/ui/common/animations.dart';
import './/ui/common/style.dart';
import './/utils/util_datas.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:provider/provider.dart';

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
          children: [WalletsSettings(), RemindersSettings(), OtherSettings()],
        ),
      ),
    ));
  }
}

class WalletsSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("WalletSettings build()");
    final walletSettingsProvider = context.watch<WalletSettingsProvider>();
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
          ListView.builder(
            shrinkWrap: true,
            itemCount: walletSettingsProvider.allWallets.length,
            itemBuilder: (BuildContext context, int index) {
              print(walletSettingsProvider.allWallets[index].toString());
              return WalletListWidget(
                  wallet: walletSettingsProvider.allWallets[index]);
            },
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
                  text: wallet.type.name,
                  style: Theme.of(context).textTheme.bodyText1,
                  fitSize: 125,
                ),
              ],
            ),
            FittedText(
              text:
                  "+ ${getFormattedCurrency(context: context, value: wallet.amount)}",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.green),
              fitSize: 165,
              align: AlignmentDirectional.centerEnd,
            )
          ])
        ],
      ),
    );
  }
}

class RemindersSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("RemindersSettings build()");
    final reminderSettingsProvider = context.watch<ReminderSettingsProvider>();
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
          ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: reminderSettingsProvider.allReminders.length,
              itemBuilder: (BuildContext context, int index) {
                return ReminderListWidget(
                    reminder: reminderSettingsProvider.allReminders[index]);
              }),
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
                [Colors.blue],
                [Colors.blue]
              ],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              initialLabelIndex: 1,
              totalSwitches: 2,
              labels: ['On', 'Off'],
              radiusStyle: true,
              onToggle: (index) {
                // TODO  implement reminder notification on/off
                print(reminder.name + ' switched to: $index');
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
    print("OtherSettings build()");
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
    final walletSettingsProvider = context.read<WalletSettingsProvider>();
    bool hasWallet = false;
    WalletType type;
    if (wallet != null) {
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
                                type = (index == 0)
                                    ? WalletType.card
                                    : WalletType.cash;
                                print('switched to: $index');
                              },
                            ),
                          ),

                          // TODO implement oprional fee feature
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
                                    print(wallet.toString());
                                    walletSettingsProvider.deleteWallet(wallet);
                                    Navigator.pop(context);
                                  }),
                            ),
                            FloatingActionButton(
                                heroTag: "saveAddRemBtn",
                                child: wallet != null
                                    ? Icon(Icons.edit)
                                    : Icon(Icons.add),
                                backgroundColor: Colors.green,
                                onPressed: () {
                                  wallet != null
                                      ? walletSettingsProvider.updateWallet(
                                          wallet,
                                          name: nameCtrl.text,
                                          amount: double.parse(amountCtrl.text),
                                          type: type)
                                      : walletSettingsProvider.addWallet(Wallet(
                                          name: nameCtrl.text,
                                          amount: double.parse(amountCtrl.text),
                                          type: type));
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
    final reminderSettingsProvider = context.read<ReminderSettingsProvider>();
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
                            Visibility(
                              visible: reminder != null,
                              child: FloatingActionButton(
                                  heroTag: "deleteFreBtn",
                                  child: Icon(Icons.delete),
                                  backgroundColor: Colors.red,
                                  onPressed: () {
                                    reminderSettingsProvider
                                        .deleteReminder(reminder);
                                    Navigator.pop(context);
                                  }),
                            ),
                            FloatingActionButton(
                                heroTag: "saveAddFreBtn",
                                child: reminder != null
                                    ? Icon(Icons.edit)
                                    : Icon(Icons.add),
                                backgroundColor: Colors.green,
                                onPressed: () {
                                  List<String> freqList =
                                      pickAdapter.getSelectedValues();
                                  reminder != null
                                      ? reminderSettingsProvider
                                          .updateReminder(reminder)
                                      : reminderSettingsProvider.addReminder(
                                          Reminder(
                                              id: "testreminder1",
                                              name: nameCtrl.text,
                                              frequency: freqList[0] +
                                                  " " +
                                                  freqList[1] +
                                                  " " +
                                                  freqList[2]));
                                  //print(pickAdapter.getSelectedValues());
                                  // print(picker.selecteds);
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

class AddEditCategoryScreen extends StatelessWidget {
  final nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("AddEditCategoryScreen build()");
    final addEditCategoryScreenProvider =
        context.watch<AddEditCategoryScreenProvider>();
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
                                        onTap: () async {
                                          addEditCategoryScreenProvider
                                              .changeSelectedCategoryColor(
                                                  await openColorPicker(context,
                                                      color: addEditCategoryScreenProvider
                                                          .selectedCategoryColor));
                                        },
                                        child: Icon(
                                          Icons.circle,
                                          size: 32,
                                          color: addEditCategoryScreenProvider
                                              .selectedCategoryColor,
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
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: addEditCategoryScreenProvider
                                    .allCategorys.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return SettingsMyLegendWidget(
                                      nameCtrl: nameCtrl,
                                      category: addEditCategoryScreenProvider
                                          .allCategorys[index],
                                      context: context);
                                }),
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
                                  addEditCategoryScreenProvider
                                      .deleteCategory();
                                  Navigator.pop(context);
                                }),
                            FloatingActionButton(
                                heroTag: "saveCatBtn",
                                child: Icon(Icons.edit),
                                backgroundColor: Colors.green,
                                onPressed: () {
                                  addEditCategoryScreenProvider
                                      .updateCategory();
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

class SettingsMyLegendWidget extends StatelessWidget {
  const SettingsMyLegendWidget({
    Key key,
    @required this.nameCtrl,
    @required this.category,
    @required this.context,
  }) : super(key: key);

  final TextEditingController nameCtrl;
  final TrxCategory category;

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final addEditCategoryScreenProvider =
        context.read<AddEditCategoryScreenProvider>();
    return GestureDetector(
      onTap: () {
        addEditCategoryScreenProvider.changeSelectedCategory(category);
        nameCtrl.text = category.name;
      },
      child: Container(
        child: Column(
          children: [
            MyLegendWidget(
              style: Theme.of(context).textTheme.bodyText1,
              text: category.name,
              color: category.color,
              space: 5.0,
            ),
            Divider(
              thickness: 1,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
