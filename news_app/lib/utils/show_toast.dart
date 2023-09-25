import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_app/widgets/news_toast.dart';

void showToast(FToast fToast, String msg, {int seconds = 2, bool center = false}) {
  fToast.removeQueuedCustomToasts();
  fToast.showToast(
    child: NewsToast(
      msg: msg,
      fToast: fToast,
    ),
    toastDuration: Duration(seconds: seconds),
    gravity: center ? ToastGravity.CENTER : null,
    positionedToastBuilder: center
        ? null
        : (context, child) => Positioned(
              bottom: 16.0,
              left: 16,
              right: 16,
              child: child,
            ),
  );
}
