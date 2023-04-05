import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class DialogAddDad extends StatefulWidget {
  final Function(String, String) handleFinish;
  DialogAddDad({
    required this.handleFinish,
  });

  @override
  State<StatefulWidget> createState() => _DialogAddDadState();
}

class _DialogAddDadState extends State<DialogAddDad> {
  String _key = '';
  String _value = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.sp,
      height: 200.sp,
      padding: EdgeInsets.symmetric(vertical: 20.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.sp),
            child: Text(
              'Thêm câu trả lời',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.sp),
            ),
          ),
          SizedBox(height: 12.sp),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.sp),
            child: Row(
              children: [
                _buildInput((p0) => _key = p0),
                _buildInput((p0) => _value = p0),
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
              widget.handleFinish(_key, _value);
            },
            child: Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 12.sp),
              child: Text(
                'Lưu',
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

  Widget _buildInput(Function(String) onChanged) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.sp),
        padding: EdgeInsets.only(left: 6.sp),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.all(Radius.circular(4.sp)),
        ),
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
            onChanged: onChanged,
            cursorColor: Colors.black,
            inputFormatters: [
              LengthLimitingTextInputFormatter(100),
            ],
            keyboardType: TextInputType.multiline,
            maxLines: 1,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '',
              hintStyle: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.65),
                fontSize: 11.sp,
              ),
            ),
          ),
        ),
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
