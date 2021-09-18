import 'package:flutter/material.dart';

showDialogLoading(context) {
  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    },
    barrierColor: Color(0x80000000),
    barrierDismissible: false,
  );
}
