import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/app_decorations.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback? toggleView;

  LoginPage({this.toggleView});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  FocusNode usernameFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  String email = '';
  String password = '';

  bool hidePassword = true;
  bool rememberPsw = false;

  hideKeyboard() => usernameFocus.unfocus();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: 100.h,
        width: 100.w,
        child: Form(
          key: _formKey,
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowGlow();
              return true;
            },
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 12.sp),
                        Container(
                          height: 42.h,
                          width: 100.w,
                          margin: EdgeInsets.fromLTRB(
                            10.w,
                            8.8.h - 12.sp,
                            10.w,
                            12.sp,
                          ),
                          child: Lottie.asset('assets/lottie/splash.json'),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                decoration: AppDecoration.buttonActionBorder(
                                        context, 6.sp)
                                    .decoration,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 10.0),
                                    _buildLineInfo(
                                      context,
                                      'Email',
                                      'Hãy nhập email của bạn',
                                      usernameFocus,
                                    ),
                                    Divider(
                                      thickness: .25,
                                      height: .25,
                                      indent: 16.sp,
                                      endIndent: 16.sp,
                                    ),
                                    _buildLineInfo(
                                      context,
                                      'Mật khẩu',
                                      'Mật khẩu phải có tối thiểu 6 kí tự',
                                      passwordFocus,
                                    ),
                                    SizedBox(height: 6.0),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  widget.toggleView!();
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    top: 18.sp,
                                    bottom: 12.sp,
                                  ),
                                  alignment: Alignment.center,
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontFamily: FontFamily.lato,
                                        fontSize: 11.sp,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .color,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'Bạn chưa có tài khoản? ',
                                        ),
                                        TextSpan(
                                          text: 'Đăng kí ngay',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {},
                                child: Container(
                                  height: 40.sp,
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 16.sp),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.sp),
                                    color: colorPrimary,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Đăng nhập',
                                      style: TextStyle(
                                        color: mC,
                                        fontSize: 10.sp,
                                        fontFamily: FontFamily.lato,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  '@${DateTime.now().year} Cloudmate copyright',
                  style: TextStyle(
                    fontSize: 8.sp,
                    fontFamily: FontFamily.lato,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 12.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLineInfo(context, title, valid, focusNode) {
    return Container(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        cursorColor: Theme.of(context).textTheme.bodyText2!.color,
        focusNode: focusNode,
        onFieldSubmitted: (val) {
          usernameFocus.unfocus();
          passwordFocus.requestFocus();
        },
        cursorRadius: Radius.circular(30.0),
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.95),
          fontSize: 11.sp,
          fontWeight: FontWeight.w500,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.singleLineFormatter,
        ],
        validator: (val) => null,
        onChanged: (val) {
          if (title == 'Email') {
            email = val.trim();
          } else {
            password = val.trim();
          }
        },
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.only(
            left: 12.0,
          ),
          border: InputBorder.none,
          labelText: title,
          labelStyle: TextStyle(
            color:
                Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.8),
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
