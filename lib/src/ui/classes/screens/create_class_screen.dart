import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/public/constants.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:cloudmate/src/ui/classes/blocs/class/class_bloc.dart';
import 'package:cloudmate/src/ui/common/dialogs/dialog_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

class CreateClassScreen extends StatefulWidget {
  @override
  _CreateClassScreenState createState() => _CreateClassScreenState();
}

class _CreateClassScreenState extends State<CreateClassScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameClassController = TextEditingController();
  TextEditingController _classTopicController = TextEditingController();
  TextEditingController _introClassController = TextEditingController();
  String _name = '';
  String _topic = '';
  String _intro = '';

  @override
  void initState() {
    super.initState();
  }

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
          'Tạo lớp học mới',
          style: TextStyle(
            fontSize: 15.sp,
            fontFamily: FontFamily.lato,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyText1!.color,
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
              overscroll.disallowGlow();
              return true;
            },
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 2.5.sp),
                  Divider(
                    height: .25,
                    thickness: .25,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 12.0),
                            _buildLineInfo(
                              context,
                              Constants.className,
                              'Hãy nhập tên lớp học',
                              _nameClassController,
                            ),
                            _buildDivider(context),
                            _buildLineInfo(
                              context,
                              Constants.classTopic,
                              'Hãy nhập chủ đề của lớp học',
                              _classTopicController,
                            ),
                            _buildDivider(context),
                            _buildLineInfo(
                              context,
                              Constants.classIntro,
                              'Hãy nhập giới thiệu về lớp học của bạn',
                              _introClassController,
                            ),
                            _buildDivider(context),
                            SizedBox(height: 8.0),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.sp),
                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            showDialogLoading(context);
                            AppBloc.classBloc.add(
                              CreateClass(
                                context: context,
                                name: _name,
                                intro: _intro,
                                topic: _topic,
                              ),
                            );
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
                              'Tạo lớp học',
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
                  )
                ],
              ),
            ),
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
        controller: controller,
        cursorColor: Theme.of(context).textTheme.bodyText1!.color,
        cursorRadius: Radius.circular(30.0),
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyText1!.color,
          fontSize: _size.width / 26.0,
          fontWeight: FontWeight.w500,
        ),
        validator: (val) {
          return val!.trim().length == 0 ? valid : null;
        },
        onChanged: (val) {
          setState(() {
            if (title == Constants.className) {
              _name = val.trim();
            } else if (title == Constants.classTopic) {
              _topic = val.trim();
            } else if (title == Constants.classIntro) {
              _intro = val.trim();
            }
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
            color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.8),
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
