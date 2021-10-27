import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/utils/blurhash.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

class UserRequestCard extends StatefulWidget {
  final String? urlToImage;
  final String? blurHash;
  final String? fullName;
  final DateTime? requestTime;
  final String? requestMessage;
  final bool? isLast;
  UserRequestCard({
    this.fullName,
    this.urlToImage,
    this.blurHash,
    this.requestTime,
    this.isLast,
    this.requestMessage,
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
                            hash: widget.blurHash ?? '',
                            image: widget.urlToImage,
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
                            widget.fullName!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: FontFamily.lato,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .color!
                                  .withOpacity(.88),
                            ),
                          ),
                          SizedBox(height: 2.sp),
                          Text(
                            widget.requestMessage!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 10.5.sp,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: FontFamily.lato,
                                    ),
                          ),
                          SizedBox(height: 2.sp),
                          Text(
                            DateFormat('HH:mm - dd/MM/yyyy')
                                .format(widget.requestTime!),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 10.5.sp,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: FontFamily.lato,
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
          widget.isLast!
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
