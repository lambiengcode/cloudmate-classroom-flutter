import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/blocs/authentication/bloc.dart';
import 'package:cloudmate/src/configs/application.dart';
import 'package:cloudmate/src/models/user.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:cloudmate/src/ui/common/dialogs/dialog_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class EditInfoScreen extends StatefulWidget {
  @override
  _EditInfoScreenState createState() => _EditInfoScreenState();
}

class _EditInfoScreenState extends State<EditInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _introController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  FocusNode textFieldFocus = FocusNode();
  String _firstName = '';
  String _lastName = '';
  String _phone = '';
  String _intro = '';

  @override
  void initState() {
    super.initState();
    UserModel? myInfo = AppBloc.authBloc.userModel;
    if (myInfo != null) {
      _firstNameController.text = myInfo.firstName!;
      _lastNameController.text = myInfo.lastName!;
      _phoneController.text = myInfo.phone!;
      _introController.text = myInfo.intro!;
      _firstName = myInfo.firstName!;
      _lastName = myInfo.lastName!;
      _phone = myInfo.phone!;
      _intro = myInfo.intro!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        elevation: .0,
        systemOverlayStyle: ThemeService.systemBrightness,
        leading: IconButton(
          onPressed: () => AppNavigator.pop(),
          icon: Icon(
            PhosphorIcons.caretLeft,
            size: 20.sp,
          ),
        ),
        title: Text(
          'Thông tin cá nhân',
          style: TextStyle(
            fontSize: 15.sp,
            fontFamily: FontFamily.lato,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                showDialogLoading(context);
                AppBloc.authBloc.add(
                  UpdateInfoUser(
                    phone: _phone,
                    intro: _intro,
                    firstName: _firstName,
                    lastName: _lastName,
                  ),
                );
              }
            },
            icon: Icon(
              PhosphorIcons.check,
              size: 20.sp,
              color: colorPrimary,
            ),
          ),
        ],
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
                                'Số điện thoại',
                                'Hãy nhập số điện thoại của bạn',
                                _phoneController,
                              ),
                              _buildDivider(context),
                              _buildLineInfo(
                                context,
                                'Giới thiệu',
                                'Hãy nhập lời giới thiệu về bạn',
                                _introController,
                              ),
                              _buildDivider(context),
                              SizedBox(height: 8.0),
                            ],
                          ),
                        ),
                        SizedBox(height: 12.0),
                        // GestureDetector(
                        //   onTap: () async {

                        //   },
                        //   child: Container(
                        //     height: 40.sp,
                        //     margin: EdgeInsets.symmetric(
                        //       horizontal: 12.w,
                        //     ),
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(8.sp),
                        //       color: colorPrimary,
                        //     ),
                        //     child: Center(
                        //       child: Text(
                        //         'Lưu thông tin',
                        //         style: TextStyle(
                        //           color: mC,
                        //           fontSize: 10.sp,
                        //           fontWeight: FontWeight.w600,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(height: 36.0),
                      ],
                    ),
                  ),
                ),

                // Button delete account
                SizedBox(height: 12.0),
                Visibility(
                  visible: Application.isProductionMode,
                  child: GestureDetector(
                    onTap: () async {
                      showDialogLoading(context);
                      AppBloc.authBloc.add(
                        DeleteAccount(),
                      );
                    },
                    child: Container(
                      height: 40.sp,
                      margin: EdgeInsets.symmetric(
                        horizontal: 12.w,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: colorHigh, width: 1.sp),
                        borderRadius: BorderRadius.circular(8.sp),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          'Xóa tài khoản',
                          style: TextStyle(
                            color: colorHigh,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.sp),
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
        maxLines: null,
        controller: controller,
        cursorColor: colorTitle,
        cursorRadius: Radius.circular(30.0),
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.95),
          fontSize: 11.sp,
          fontWeight: FontWeight.w500,
        ),
        validator: (val) {
          if (title == 'Họ của bạn') {
            return val!.trim().length == 0 ? valid : null;
          } else if (title == 'Tên của bạn') {
            return val!.trim().length == 0 ? valid : null;
          } else if (title == 'Số điện thoại') {
            return val!.trim().length < 10 ? valid : null;
          }
          return val!.trim().length == 0 ? valid : null;
        },
        onChanged: (val) {
          setState(() {
            if (title == 'Họ của bạn') {
              _firstName = val.trim();
            } else if (title == 'Tên của bạn') {
              _lastName = val.trim();
            } else if (title == 'Số điện thoại') {
              _phone = val.trim();
            } else {
              _intro = val.trim();
            }
          });
        },
        inputFormatters: title == 'Số điện thoại'
            ? [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ]
            : [
                FilteringTextInputFormatter.singleLineFormatter,
              ],
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
