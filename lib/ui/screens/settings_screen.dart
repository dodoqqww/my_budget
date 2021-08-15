import 'package:flutter/material.dart';
import 'package:my_budget/models/wallet.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("SettingsScreen build()");
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [WalletSettings(), RemindersSettings()],
        ),
      ),
    ));
  }
}

class WalletSettings extends StatelessWidget {
  final wallet1 = Wallet(
      id: "1", name: "OTP Bank", amount: 123456.0, type: WalletType.card);
  final wallet2 = Wallet(
      id: "2", name: "Home wallet", amount: 1234.0, type: WalletType.cash);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      elevation: 20,
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
                style: TextStyle(fontSize: 24),
              ),
              FloatingActionButton(
                  child: Icon(Icons.add),
                  backgroundColor: Colors.green,
                  onPressed: () {})
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
              Text(wallet.name),
              InkWell(
                  onTap: () {
                    //  Navigator.of(context).push(PageRouteBuilder(
                    //      barrierColor: Colors.black.withOpacity(0.5),
                    //      transitionsBuilder: (context, a1, a2, widget) {
                    //        final curvedValue =
                    //            Curves.easeInOutBack.transform(a1.value) - 1.0;
                    //        return Transform(
                    //          transform: Matrix4.translationValues(
                    //              0.0, curvedValue * 100, 0.0),
                    //          child: Opacity(
                    //            opacity: a1.value,
                    //            child: TrxInfoScreen(trx: trx),
                    //          ),
                    //        );
                    //      },
                    //      opaque: false,
                    //      // ignore: missing_return
                    //      pageBuilder: (_1, _2, _3) {}));
                  },
                  child: Text(
                    "More",
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          ),
          Divider(color: Colors.black),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [wallet.type.icon, Text(wallet.type.name)],
            ),
            Text(
              "+ ${wallet.amount} Ft",
              style: TextStyle(color: Colors.green),
            )
          ])
        ],
      ),
    );
  }
}

class RemindersSettings extends StatelessWidget {
  //final wallet1 = Wallet(
  //    id: "1", name: "OTP Bank", amount: 123456.0, type: WalletType.card);
  //final wallet2 = Wallet(
  //    id: "2", name: "Home wallet", amount: 1234.0, type: WalletType.cash);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      elevation: 20,
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
                style: TextStyle(fontSize: 24),
              ),
              FloatingActionButton(
                  child: Icon(Icons.add),
                  backgroundColor: Colors.green,
                  onPressed: () {})
            ],
          ),
          Divider(
            thickness: 2,
          ),
          ListView(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            children: [
              ReminderListWidget(),
              ReminderListWidget(),
            ],
          ),
        ],
      ),
    );
  }
}

class ReminderListWidget extends StatelessWidget {
  // final Wallet wallet;
//
  // const WalletsListWidget({Key key, @required this.wallet}) : super(key: key);

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
              Text("Sallary add"),
              InkWell(
                  onTap: () {
                    //  Navigator.of(context).push(PageRouteBuilder(
                    //      barrierColor: Colors.black.withOpacity(0.5),
                    //      transitionsBuilder: (context, a1, a2, widget) {
                    //        final curvedValue =
                    //            Curves.easeInOutBack.transform(a1.value) - 1.0;
                    //        return Transform(
                    //          transform: Matrix4.translationValues(
                    //              0.0, curvedValue * 100, 0.0),
                    //          child: Opacity(
                    //            opacity: a1.value,
                    //            child: TrxInfoScreen(trx: trx),
                    //          ),
                    //        );
                    //      },
                    //      opaque: false,
                    //      // ignore: missing_return
                    //      pageBuilder: (_1, _2, _3) {}));
                  },
                  child: Text(
                    "Settings",
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          ),
          Divider(color: Colors.black),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "Every month 10th.",
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
