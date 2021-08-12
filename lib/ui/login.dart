import 'package:flutter/material.dart';
import 'package:my_budget/generated/l10n.dart';

class MyLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                S.of(context).welcome,
                style: Theme.of(context).textTheme.headline1,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: S.of(context).username,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: S.of(context).password,
                ),
                obscureText: true,
              ),
              SizedBox(
                height: 24,
              ),
              RaisedButton(
                color: Colors.yellow,
                child: Text(S.of(context).enter),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/catalog');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
