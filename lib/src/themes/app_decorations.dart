import 'package:flutter/material.dart';
import 'package:cloudmate/src/themes/app_colors.dart';

class AppDecoration {
  final BoxDecoration decoration;
  AppDecoration({required this.decoration});
  factory AppDecoration.containerOnlyShadowTop(context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return AppDecoration(
        decoration: BoxDecoration(
          color: colorPrimaryBlack,
          boxShadow: [
            BoxShadow(
              color: colorBlack.withOpacity(.65),
              offset: Offset(-2, -2),
              blurRadius: 10,
            ),
          ],
        ),
      );
    } else {
      return AppDecoration(
        decoration: BoxDecoration(
          color: mC,
          boxShadow: [
            BoxShadow(
              color: mCL,
              offset: Offset(-2, -2),
              blurRadius: 10,
            ),
          ],
        ),
      );
    }
  }

  factory AppDecoration.buttonActionCircle(context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return AppDecoration(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colorPrimaryBlack,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.8),
              offset: Offset(1, 1),
              blurRadius: 1,
            ),
            BoxShadow(
              color: colorBlack.withOpacity(.35),
              offset: Offset(-1, -1),
              blurRadius: 1,
            ),
          ],
        ),
      );
    } else {
      return AppDecoration(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: mC,
          boxShadow: [
            BoxShadow(
              color: mCD,
              offset: Offset(1, 1),
              blurRadius: 1,
            ),
            BoxShadow(
              color: mCL,
              offset: Offset(-1, -1),
              blurRadius: 1,
            ),
          ],
        ),
      );
    }
  }

  factory AppDecoration.buttonActionCircleActive(context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return AppDecoration(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withOpacity(.4),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade900,
              offset: Offset(2, 2),
              blurRadius: 2,
              spreadRadius: -2,
            ),
          ],
        ),
      );
    } else {
      return AppDecoration(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: mCD,
          boxShadow: [
            BoxShadow(
              color: mCL,
              offset: Offset(2, 2),
              blurRadius: 2,
              spreadRadius: -2,
            ),
          ],
        ),
      );
    }
  }

  factory AppDecoration.buttonActionBorderActive(context, radius) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return AppDecoration(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: Colors.black.withOpacity(.4),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade900,
              offset: Offset(2, 2),
              blurRadius: 2,
              spreadRadius: -2,
            ),
          ],
        ),
      );
    } else {
      return AppDecoration(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: mCD,
          boxShadow: [
            BoxShadow(
              color: mCL,
              offset: Offset(2, 2),
              blurRadius: 2,
              spreadRadius: -2,
            ),
          ],
        ),
      );
    }
  }

  factory AppDecoration.buttonActionCircleCall(context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return AppDecoration(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colorPrimaryBlack,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.8),
              offset: Offset(2, 2),
              blurRadius: 2,
            ),
            BoxShadow(
              color: colorBlack.withOpacity(.35),
              offset: Offset(-2, -2),
              blurRadius: 2,
            ),
          ],
        ),
      );
    } else {
      return AppDecoration(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: mC.withOpacity(.1),
          boxShadow: [
            BoxShadow(
              color: mCM.withOpacity(.1),
              offset: Offset(.5, .5),
              blurRadius: .5,
            ),
            BoxShadow(
              color: mCL.withOpacity(.01),
              offset: Offset(-1, -1),
              blurRadius: .5,
            ),
          ],
        ),
      );
    }
  }

  factory AppDecoration.buttonActionBorder(context, radius) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return AppDecoration(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: colorPrimaryBlack,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.4),
              offset: Offset(4, 4),
              blurRadius: 4,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(.15),
              offset: Offset(-1, -1),
              blurRadius: 20,
            ),
          ],
        ),
      );
    } else {
      return AppDecoration(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: mC,
          boxShadow: [
            BoxShadow(
              color: mCD,
              offset: Offset(5, 5),
              blurRadius: 5,
            ),
            BoxShadow(
              color: mCL,
              offset: Offset(-2, -2),
              blurRadius: 2,
            ),
          ],
        ),
      );
    }
  }

  factory AppDecoration.tabBarDecoration(context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return AppDecoration(
          decoration: BoxDecoration(
        color: colorPrimaryBlack.withOpacity(.85),
        boxShadow: [
          BoxShadow(
            color: colorBlack,
            offset: Offset(-2, -2),
            blurRadius: 2,
          ),
          BoxShadow(
            color: colorBlack.withOpacity(.8),
            offset: Offset(2, 2),
            blurRadius: 2,
          ),
        ],
      ));
    } else {
      return AppDecoration(
        decoration: BoxDecoration(
          color: mCL,
          boxShadow: [
            BoxShadow(
              color: mCD,
              offset: Offset(2, 2),
              blurRadius: 2,
            ),
            BoxShadow(
              color: mC,
              offset: Offset(-2, -2),
              blurRadius: 2,
            ),
          ],
        ),
      );
    }
  }

  factory AppDecoration.tabBarDecorationSecond(context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return AppDecoration(
          decoration: BoxDecoration(
        color: colorPrimaryBlack,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.6),
            offset: Offset(1, 1),
            blurRadius: 1,
          ),
        ],
      ));
    } else {
      return AppDecoration(
        decoration: BoxDecoration(
          color: mC,
          boxShadow: [
            BoxShadow(
              color: mCD,
              offset: Offset(2, 2),
              blurRadius: 2,
            ),
          ],
        ),
      );
    }
  }

  factory AppDecoration.inputChatDecoration(context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return AppDecoration(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            8.0,
          ),
          color: Colors.black.withOpacity(.25),
          boxShadow: [
            BoxShadow(
              color: colorPrimaryBlack.withOpacity(.1),
              offset: Offset(2, 2),
              blurRadius: 2,
              spreadRadius: -2,
            ),
          ],
        ),
      );
    } else {
      return AppDecoration(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            8.0,
          ),
          color: mCD,
          boxShadow: [
            BoxShadow(
              color: mCL,
              offset: Offset(2, 2),
              blurRadius: 2,
              spreadRadius: -2,
            ),
          ],
        ),
      );
    }
  }
}
