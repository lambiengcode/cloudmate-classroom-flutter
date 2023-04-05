import 'package:cloudmate/src/models/conversation_model.dart';
import 'package:flutter/material.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/utils/blurhash.dart';
import 'package:intl/intl.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class MessageCard extends StatefulWidget {
  final ConversationModel conversation;
  final bool isLast;
  MessageCard({
    required this.conversation,
    this.isLast = false,
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
                        height: 42.5.sp,
                        width: 42.5.sp,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(250.sp),
                          child: BlurHash(
                            hash: widget.conversation.idClass.blurHash,
                            image: widget.conversation.idClass.image,
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
                            widget.conversation.idClass.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: FontFamily.lato,
                              color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(.88),
                            ),
                          ),
                          SizedBox(height: 4.5.sp),
                          Text(
                            widget.conversation.latestMessage?.message ?? 'Chưa có tin nhắn',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 35.sp,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('HH:mm')
                            .format(widget.conversation.latestMessage?.createdAt ?? DateTime.now()),
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 10.75.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: FontFamily.lato,
                            ),
                      ),
                      SizedBox(height: 4.sp),
                      // widget.notification == false
                      //     ? Icon(
                      //         PhosphorIcons.bellSimpleSlash,
                      //         size: 16.sp,
                      //       )
                      //     : widget.pendingMessage == 0
                      //         ? Container()
                      //         : Container(
                      //             padding: EdgeInsets.all(6.sp),
                      //             decoration: BoxDecoration(
                      //               shape: BoxShape.circle,
                      //               color: colorPrimary,
                      //             ),
                      //             child: Text(
                      //               widget.pendingMessage.toString(),
                      //               style: TextStyle(
                      //                 fontSize: 9.sp,
                      //                 color: mCL,
                      //                 fontWeight: FontWeight.w600,
                      //                 fontFamily: FontFamily.lato,
                      //               ),
                      //             ),
                      //           ),
                    ],
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
