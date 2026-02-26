import 'package:another_flushbar/flushbar_route.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

class utils {
  // field FocusNode....................
  static void fieldFocusChange(
    BuildContext context,
    FocusNode current,
    FocusNode nextFocus,
  ) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  // toastMessages
  static toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  //.........................flash bar :.....................
  static void flashBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        message: message,
        messageColor: Colors.black,
        messageSize: 16,
        backgroundColor: Colors.black12,
        duration: Duration(seconds: 2),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(15),
        borderRadius: BorderRadius.circular(10),
        boxShadows: [
          BoxShadow(
            color: Colors.black38.withOpacity(0.2),
            offset: const Offset(0, 4),
            blurRadius: 3,
          ),
        ],
        icon: const Icon(Icons.error_outline, size: 28, color: Colors.red),

        flushbarPosition: FlushbarPosition.TOP,
        forwardAnimationCurve: Curves.easeOutBack,
        reverseAnimationCurve: Curves.easeInBack,
      )..show(context),
    );
  }

  // snakbar message .....................
  static snakBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white54,

        duration: Duration(seconds: 2),

        elevation: 5,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        padding: const EdgeInsets.all(15),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text(
          message,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
    );
  }
}
