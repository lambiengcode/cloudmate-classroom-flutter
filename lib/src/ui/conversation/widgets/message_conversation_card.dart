import 'package:cloudmate/src/helpers/date_time_helper.dart';
import 'package:cloudmate/src/models/conversation_model.dart';
import 'package:cloudmate/src/models/message_model.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class MessageConversationCard extends StatefulWidget {
  final MessageModel messageModel;
  final MessageModel? prevModel;
  final MessageModel? nextModel;
  final bool isShowAvatar;
  final ConversationModel? conversationModel;

  MessageConversationCard({
    required this.messageModel,
    required this.conversationModel,
    this.nextModel,
    this.prevModel,
    this.isShowAvatar = false,
  });

  @override
  State<StatefulWidget> createState() => _MessageConversationCardState();
}

class _MessageConversationCardState extends State<MessageConversationCard> {
  late final GlobalKey messageCardKey;

  @override
  void initState() {
    super.initState();

    messageCardKey = GlobalKey(debugLabel: widget.messageModel.id);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        widget.prevModel == null ||
                isShowTime(widget.messageModel.createdAt, widget.prevModel!.createdAt)
            ? Container(
                padding: EdgeInsets.only(top: 20.sp, bottom: 12.sp),
                child: Text(
                  DateFormat('dd/MM/yyyy HH:mm').format(widget.messageModel.createdAt),
                  style: TextStyle(
                    color: colorDarkGrey,
                    fontSize: 10.sp,
                  ),
                ),
              )
            : SizedBox(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment:
              widget.messageModel.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            SizedBox(width: 5.sp),
            !widget.messageModel.isMe && widget.isShowAvatar
                ? Container(
                    height: 20.sp,
                    width: 20.sp,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(widget.messageModel.sender.image ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : SizedBox(height: 20.sp, width: 20.sp),
            senderLayout(),
          ],
        ),
      ],
    );
  }

  Widget senderLayout({bool canPressed = true}) {
    return Column(
      crossAxisAlignment:
          widget.messageModel.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            right: 8.sp,
            left: 5.sp,
            bottom: widget.nextModel == null ||
                    (widget.nextModel!.sender.id == widget.messageModel.sender.id)
                ? 8.sp
                : 16.sp,
          ),
          constraints: BoxConstraints(
            maxWidth: 65.w,
          ),
          decoration: BoxDecoration(
            border: null,
            color: widget.messageModel.isMe ? mCD : colorPrimary.withOpacity(.2),
            borderRadius: BorderRadius.all(Radius.circular(10.sp)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 12.sp),
            child: getMessage(),
          ),
        )
      ],
    );
  }

  getMessage() {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: colorBlack,
          fontSize: 12.sp,
          fontStyle: FontStyle.normal,
        ),
        text: widget.messageModel.message,
      ),
    );
  }
}
