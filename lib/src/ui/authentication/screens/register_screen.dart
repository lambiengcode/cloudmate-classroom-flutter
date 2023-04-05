import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/blocs/authentication/bloc.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:cloudmate/src/ui/common/dialogs/dialog_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/utils.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback? toggleView;

  RegisterPage({this.toggleView});
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPswController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  FocusNode textFieldFocus = FocusNode();
  String firstName = '';
  String lastName = '';
  String email = '';
  String password = '';

  bool hidePassword = true;

  hideKeyboard() => textFieldFocus.unfocus();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        elevation: .0,
        systemOverlayStyle: ThemeService.systemBrightness,
        leading: IconButton(
          onPressed: () => widget.toggleView!(),
          icon: Icon(
            PhosphorIcons.caretLeft,
            size: 20.sp,
          ),
        ),
        title: Text(
          'Bắt đầu là thành viên',
          style: TextStyle(
            fontSize: 15.sp,
            fontFamily: FontFamily.lato,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
      ),
      body: Container(
        height: 100.h,
        width: 100.w,
        child: Form(
          key: _formKey,
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              return true;
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 2.5.sp),
                Divider(
                  height: .25,
                  thickness: .25,
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 12.0),
                              _buildLineInfo(
                                context,
                                'Họ của bạn',
                                'Hãy nhập họ của bạn',
                                _firstNameController,
                              ),
                              _buildDivider(context),
                              _buildLineInfo(
                                context,
                                'Tên của bạn',
                                'Hãy nhập tên của bạn',
                                _lastNameController,
                              ),
                              _buildDivider(context),
                              _buildLineInfo(
                                context,
                                'Email',
                                'Hãy nhập email của bạn',
                                _emailController,
                              ),
                              _buildDivider(context),
                              _buildLineInfo(
                                context,
                                'Mật khẩu',
                                'Mật khẩu phải có tối thiểu 6 kí tự',
                                _passwordController,
                              ),
                              _buildDivider(context),
                              Container(
                                padding: EdgeInsets.fromLTRB(14.0, 24.0, 18.0, 4.0),
                                child: TextFormField(
                                  controller: _confirmPswController,
                                  cursorColor: colorTitle,
                                  cursorRadius: Radius.circular(30.0),
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color!
                                        .withOpacity(.95),
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  validator: (val) =>
                                      val!.trim() != password ? 'Mật khẩu không khớp' : null,
                                  obscureText: hidePassword,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                    contentPadding: EdgeInsets.only(
                                      left: 12.0,
                                    ),
                                    border: InputBorder.none,
                                    labelText: 'Nhập lại mật khẩu',
                                    labelStyle: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color!
                                          .withOpacity(.8),
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              _buildDivider(context),
                              SizedBox(height: 8.0),
                            ],
                          ),
                        ),
                        SizedBox(height: 12.0),
                        GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              showDialogLoading(context);
                              AppBloc.authBloc.add(
                                RegisterEvent(
                                  username: email,
                                  password: password,
                                  firstName: firstName,
                                  lastName: lastName,
                                ),
                              );
                            }
                          },
                          child: Container(
                            height: 40.sp,
                            margin: EdgeInsets.symmetric(
                              horizontal: 12.w,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.sp),
                              color: colorPrimary,
                            ),
                            child: Center(
                              child: Text(
                                'Đăng kí ngay',
                                style: TextStyle(
                                  color: mC,
                                  fontSize: 10.sp,
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLineInfo(context, title, valid, controller) {
    return Container(
      padding: EdgeInsets.fromLTRB(12.sp, 16.sp, 16.sp, 2.5.sp),
      child: TextFormField(
        controller: controller,
        cursorColor: colorTitle,
        cursorRadius: Radius.circular(30.0),
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.95),
          fontSize: 11.sp,
          fontWeight: FontWeight.w500,
        ),
        validator: (val) {
          if (title == 'Email') {
            return !GetUtils.isEmail(val!) ? valid : null;
          } else if (title == 'Mật khẩu') {
            return val!.length < 6 ? valid : null;
          } else {
            return val!.length == 0 ? valid : null;
          }
        },
        onChanged: (val) {
          setState(() {
            if (title == 'Họ của bạn') {
              firstName = val.trim();
            } else if (title == 'Tên của bạn') {
              lastName = val.trim();
            } else if (title == 'Email') {
              email = val.trim();
            } else if (title == 'Mật khẩu') {
              password = val.trim();
            } else {}
          });
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
            fontSize: 11.sp,
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
      indent: 22.sp,
      endIndent: 22.sp,
    );
  }
}
