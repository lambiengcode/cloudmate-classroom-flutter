import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class DialogAddAnswer extends StatefulWidget {
  final Function handleFinish;
  DialogAddAnswer({required this.handleFinish});

  @override
  State<StatefulWidget> createState() => _DialogAddAnswerState();
}

class _DialogAddAnswerState extends State<DialogAddAnswer> {
  String _answer = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.sp,
      height: 230.sp,
      padding: EdgeInsets.symmetric(vertical: 20.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.sp),
            child: Text(
              'Nhập câu trả lời',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.sp),
            ),
          ),
          SizedBox(height: 10.sp),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 13.5.sp),
            padding: EdgeInsets.only(left: 6.sp),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.all(Radius.circular(12.sp)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.sp),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.sp)),
                      color: Colors.transparent,
                    ),
                    child: TextField(
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color!,
                        fontSize: 11.sp,
                      ),
                      onChanged: (val) {
                        setState(() {
                          _answer = val.trim();
                        });
                      },
                      cursorColor: Colors.black,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(100),
                      ],
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Hãy nhập câu trả lời cho câu hỏi này...',
                        hintStyle: TextStyle(
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .color!
                              .withOpacity(.65),
                          fontSize: 11.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.sp),
          Divider(
            height: .25,
            thickness: .25,
          ),
          GestureDetector(
            onTap: () {
              widget.handleFinish(_answer);
              AppNavigator.pop();
            },
            child: Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 12.sp),
              child: Text(
                'Thêm câu trả lời',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
          Divider(
            height: .25,
            thickness: .25,
          ),
          GestureDetector(
            onTap: () {
              AppNavigator.pop();
            },
            child: Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 12.sp),
              child: Text(
                'Quay lại',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 11.5.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
