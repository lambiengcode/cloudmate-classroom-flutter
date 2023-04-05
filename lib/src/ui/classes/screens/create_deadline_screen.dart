import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:cloudmate/src/ui/common/dialogs/dialog_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';
import 'package:get/get.dart';

class CreateDeadlineScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreateDeadlinetScreenState();
}

class _CreateDeadlinetScreenState extends State<CreateDeadlineScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        systemOverlayStyle: ThemeService.systemBrightness,
        centerTitle: true,
        elevation: .0,
        leading: IconButton(
          onPressed: () => AppNavigator.pop(),
          icon: Icon(
            PhosphorIcons.caretLeft,
            size: 20.sp,
          ),
        ),
        title: Text(
          'Lên Deadline',
          style: TextStyle(
            fontSize: 15.sp,
            fontFamily: FontFamily.lato,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
      ),
      body: Container(
        height: 100.h,
        width: 100.w,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 2.5.sp),
              Divider(
                height: .25,
                thickness: .25,
              ),
              SizedBox(height: 8.0),
              _buildLineInfo(
                context,
                'Tiêu đề bài deadline',
                'Hãy nhập tiêu đề cho bài deadline này',
                _nameController,
              ),
              _buildDivider(context),
              _buildLineInfo(
                context,
                'Ngày hết hạn',
                'Hãy chọn ngày hết hạn',
                _nameController,
              ),
              _buildDivider(context),
              _buildLineInfo(
                context,
                'Giờ hết hạn',
                'Hãy chọn giờ hết hạn',
                _nameController,
              ),
              _buildDivider(context),
              SizedBox(height: 20.sp),
              GestureDetector(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    showDialogLoading(context);
                  }
                },
                child: Container(
                  height: 38.sp,
                  margin: EdgeInsets.symmetric(horizontal: 40.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.sp),
                    color: colorPrimary,
                  ),
                  child: Center(
                    child: Text(
                      'Tạo deadline',
                      style: TextStyle(
                        color: mC,
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 36.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLineInfo(context, title, valid, controller) {
    final _size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.fromLTRB(14.0, 18.0, 18.0, 4.0),
      child: TextFormField(
        maxLines: null,
        controller: controller,
        cursorColor: Theme.of(context).textTheme.bodyLarge!.color,
        cursorRadius: Radius.circular(30.0),
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge!.color,
          fontSize: _size.width / 26.0,
          fontWeight: FontWeight.w500,
        ),
        validator: (val) {
          if (title == 'Số điện thoại') {
            return GetUtils.isPhoneNumber(val!.trim()) ? null : valid;
          } else if (title == 'Tên của bạn') {
            return val!.trim().length == 0 ? valid : null;
          } else if (title == 'Mật khẩu') {
            return val!.trim().length < 6 ? valid : null;
          }
          return null;
        },
        onChanged: (val) {
          setState(() {});
        },
        inputFormatters: [
          title == 'Số điện thoại'
              ? FilteringTextInputFormatter.digitsOnly
              : FilteringTextInputFormatter.singleLineFormatter,
        ],
        obscureText: title == 'Mật khẩu' ? true : false,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.only(
            left: 12.0,
          ),
          border: InputBorder.none,
          labelText: title,
          labelStyle: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.8),
            fontSize: _size.width / 26.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(context) {
    return Divider(
      thickness: .25,
      height: .25,
      indent: 25.0,
      endIndent: 25.0,
    );
  }
}
