import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

openDialog(BuildContext ctx, Widget widget) {
  Navigator.of(ctx).push(PageRouteBuilder(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionsBuilder: (context, a1, a2, widget_) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 10, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: widget,
          ),
        );
      },
      opaque: false,
      // ignore: missing_return
      pageBuilder: (_1, _2, _3) {}));
}
