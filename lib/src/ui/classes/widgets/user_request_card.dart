import 'package:cloudmate/src/models/user.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/utils/blurhash.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';
import 'package:cloudmate/src/helpers/int.dart';

class UserRequestCard extends StatefulWidget {
  final UserModel user;
  final bool isLast;
  UserRequestCard({
    required this.user,
    this.isLast = false,
  });
  @override
  State<StatefulWidget> createState() => _UserRequestCardState();
}

class _UserRequestCardState extends State<UserRequestCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 12.sp, right: 8.sp),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        height: 42.5.sp,
                        width: 42.5.sp,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(250.sp),
                          child: BlurHash(
                            hash: widget.user.blurHash ?? '',
                            image: widget.user.image,
                            imageFit: BoxFit.cover,
                            curve: Curves.bounceInOut,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.user.displayName ?? '',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: FontFamily.lato,
                              color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(.88),
                            ),
                          ),
                          SizedBox(height: 2.sp),
                          Text(
                            widget.user.intro == '' ? '☃ Chưa cập nhật ☃' : widget.user.intro!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  fontSize: 10.5.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: FontFamily.lato,
                                ),
                          ),
                          SizedBox(height: 2.sp),
                          Text(
                            widget.user.role!.getRoleName(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  fontSize: 10.5.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: FontFamily.lato,
                                  color: colorPrimary,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    PhosphorIcons.dotsThreeBold,
                    size: 18.sp,
                    color: mC,
                  ),
                ),
              ],
            ),
          ),
          widget.isLast
              ? Container()
              : Divider(
                  thickness: .2,
                  height: .2,
                  indent: 14.w,
                  endIndent: 12.0,
                ),
        ],
      ),
    );
  }
}
