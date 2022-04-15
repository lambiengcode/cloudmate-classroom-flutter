import 'package:flutter/material.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/utils/blurhash.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class ActiveFriendCard extends StatefulWidget {
  final String? blurHash;
  final String? urlToImage;
  final String? fullName;
  ActiveFriendCard({
    this.urlToImage,
    this.fullName,
    this.blurHash,
  });
  @override
  State<StatefulWidget> createState() => _ActivevFriendCardState();
}

class _ActivevFriendCardState extends State<ActiveFriendCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                height: 48.sp,
                width: 48.sp,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: colorPrimary,
                    width: 2.6,
                  ),
                ),
                alignment: Alignment.center,
                child: Container(
                  height: 46.sp,
                  width: 46.sp,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(1000.0),
                    child: BlurHash(
                      hash: widget.blurHash!,
                      image: widget.urlToImage,
                      imageFit: BoxFit.cover,
                      curve: Curves.bounceInOut,
                    ),
                  ),
                ),
              ),
              Container(
                height: 48.sp,
                width: 48.sp,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: colorPrimary,
                    width: 2.5,
                  ),
                ),
                alignment: Alignment.bottomRight,
                child: Container(
                  height: 12.sp,
                  width: 12.sp,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Container(
                    height: 9.2.sp,
                    width: 9.2.sp,
                    decoration: BoxDecoration(
                      color: colorActive,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 3.sp),
          Text(
            widget.fullName!.length > 10
                ? widget.fullName!.substring(0, 8) + '..'
                : widget.fullName!,
            style: TextStyle(
              fontSize: 9.sp,
              fontWeight: FontWeight.w600,
              fontFamily: FontFamily.lato,
            ),
          ),
        ],
      ),
    );
  }
}
