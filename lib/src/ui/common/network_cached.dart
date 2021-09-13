import 'package:flutter/material.dart';
import 'package:cloudmate/src/themes/app_decorations.dart';

class ErrorLoadingImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecoration.buttonActionCircle(context).decoration,
    );
  }
}

class PlaceHolderImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecoration.inputChatDecoration(context).decoration,
    );
  }
}
