import 'package:flutter/material.dart';
import 'package:flutter_mobile_2school/src/themes/app_colors.dart';
import 'package:flutter_mobile_2school/src/themes/font_family.dart';
import 'package:flutter_mobile_2school/src/utils/blurhash.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

class MessageCard extends StatefulWidget {
  final int? pendingMessage;
  final String? urlToImage;
  final String? blurHash;
  final String? fullName;
  final String? lastMessage;
  final String? time;
  final bool? notification;
  final bool? isLast;
  MessageCard({
    this.pendingMessage,
    this.fullName,
    this.lastMessage,
    this.notification,
    this.time,
    this.urlToImage,
    this.blurHash,
    required this.isLast,
  });
  @override
  State<StatefulWidget> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
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
                        height: 40.sp,
                        width: 40.sp,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.25.sp),
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
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: FontFamily.lato,
                              wordSpacing: .01,
                            ),
                          ),
                          SizedBox(height: 4.sp),
                          Text(
                            widget.lastMessage!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 30.sp,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.time!,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 10.75.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: FontFamily.lato,
                            ),
                      ),
                      SizedBox(height: 4.sp),
                      widget.notification == false
                          ? Icon(
                              PhosphorIcons.bellSimpleSlash,
                              size: 16.sp,
                            )
                          : widget.pendingMessage == 0
                              ? Container()
                              : Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.5,
                                    vertical: 4.0,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: colorPrimary,
                                  ),
                                  child: Text(
                                    widget.pendingMessage.toString(),
                                    style: TextStyle(
                                      fontSize: 8.sp,
                                      color: mCL,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: FontFamily.lato,
                                    ),
                                  ),
                                ),
                    ],
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
