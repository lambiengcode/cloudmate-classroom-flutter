import 'package:cloudmate/src/helpers/string.dart';
import 'package:cloudmate/src/models/user.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:flutter/material.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class LobbyUserCard extends StatelessWidget {
  final UserModel userModel;
  const LobbyUserCard({required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 36.sp,
          width: 36.sp,
          padding: EdgeInsets.all(1.25.sp),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 1.5.sp,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(userModel.image!),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(height: 6.sp),
        Text(
          userModel.lastName!.formatName(12),
          style: TextStyle(
            fontFamily: FontFamily.lato,
            fontSize: 9.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
