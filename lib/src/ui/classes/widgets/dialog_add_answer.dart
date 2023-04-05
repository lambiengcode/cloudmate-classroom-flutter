import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class DialogInput extends StatefulWidget {
  final Function handleFinish;
  final String title;
  final String buttonTitle;
  final String hideInputField;
  DialogInput({
    required this.handleFinish,
    required this.title,
    required this.buttonTitle,
    this.hideInputField = 'Hãy nhập câu trả lời cho câu hỏi này...',
  });

  @override
  State<StatefulWidget> createState() => _DialogInputState();
}

class _DialogInputState extends State<DialogInput> {
  String _answer = '';

  @override
  void initState() {
    super.initState();
  }

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
              widget.title,
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
                    child: TextFormField(
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color!,
                        fontSize: 11.sp,
                      ),
                      onChanged: (val) {
                        setState(() {
                          if (widget.title == 'Nhập mã PIN') {
                            _answer = val.trim().toUpperCase();
                          } else {
                            _answer = val.trim();
                          }
                        });
                      },
                      cursorColor: Colors.black,
                      inputFormatters: [
                        ...widget.title == 'Nhập mã PIN' ? [UpperCaseTextFormatter()] : [],
                        LengthLimitingTextInputFormatter(100),
                      ],
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: widget.hideInputField,
                        hintStyle: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.65),
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
              AppNavigator.pop();
              widget.handleFinish(_answer);
            },
            child: Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 12.sp),
              child: Text(
                widget.buttonTitle,
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

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
