import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/blocs/message/message_bloc.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class InputMessage extends StatefulWidget {
  final String conversationId;
  const InputMessage({required this.conversationId});
  @override
  _InputMessageState createState() => _InputMessageState();
}

class _InputMessageState extends State<InputMessage> {
  TextEditingController msgController = TextEditingController();
  String message = '';
  FocusNode focusNode = FocusNode();
  bool flagEdit = false;

  @override
  void initState() {
    super.initState();
  }

  _handleSendMessage() {
    if (message.length > 0) {
      AppBloc.messageBloc.add(SendMessageEvent(message: message));

      msgController.text = '';
      setState(() {
        message = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: null,
      margin: EdgeInsets.only(top: 12.sp, bottom: 20.sp),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 12.sp,
            ),
            child: chatControls(),
          ),
        ],
      ),
    );
  }

  Widget chatControls() {
    return Container(
      child: Row(
        children: <Widget>[
          SizedBox(width: 12.sp),
          Expanded(
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                TextFormField(
                  focusNode: focusNode,
                  controller: msgController,
                  style: TextStyle(
                    color: colorBlack,
                    fontSize: 12.sp,
                  ),
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 2,
                  onFieldSubmitted: (val) => _handleSendMessage(),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                      left: 16.sp,
                      bottom: 3.sp,
                      top: 3.sp,
                      right: 10.sp,
                    ),
                    hintText: 'Soạn tin nhắn...',
                    hintStyle: TextStyle(
                      color: colorDarkGrey,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    filled: true,
                    fillColor: mC,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40.sp)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      message = val.trim();
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(width: 10.sp),
          IconButton(
            icon: Icon(
              PhosphorIcons.telegramLogoFill,
              color: message.trim().length > 0 ? colorPrimary : colorDarkGrey,
              size: 20.sp,
            ),
            onPressed: () {
              _handleSendMessage();
            },
          ),
        ],
      ),
    );
  }
}
