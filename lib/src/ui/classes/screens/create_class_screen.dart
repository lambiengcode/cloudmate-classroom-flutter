import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/blocs/share_exam/share_exam_bloc.dart';
import 'package:cloudmate/src/models/class_model.dart';
import 'package:cloudmate/src/public/constants.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:cloudmate/src/ui/classes/blocs/class/class_bloc.dart';
import 'package:cloudmate/src/ui/common/dialogs/dialog_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';
import 'package:cloudmate/src/helpers/string.dart';

class CreateClassScreen extends StatefulWidget {
  final ClassModel? classModel;
  const CreateClassScreen({this.classModel});
  @override
  _CreateClassScreenState createState() => _CreateClassScreenState();
}

class _CreateClassScreenState extends State<CreateClassScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameClassController = TextEditingController();
  TextEditingController _classTopicController = TextEditingController();
  TextEditingController _introClassController = TextEditingController();
  TextEditingController _priceClassController = TextEditingController();
  String _name = '';
  String _topic = '';
  String _intro = '';
  String _price = '';
  List<String> _pickExams = [];

  @override
  void initState() {
    super.initState();
    if (widget.classModel != null) {
      _nameClassController.text = widget.classModel!.name;
      _introClassController.text = widget.classModel!.intro;
      _classTopicController.text = widget.classModel!.topic;
      _priceClassController.text = widget.classModel!.price.toInt().toString().formatMoney();
      _name = widget.classModel!.name;
      _topic = widget.classModel!.topic;
      _intro = widget.classModel!.intro;
      _price = widget.classModel!.price.toInt().toString().formatMoney();
      _pickExams = widget.classModel!.setOfQuestionShare ?? [];
    }
    AppBloc.shareExamBloc.add(GetShareExamEvent());
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
          widget.classModel != null ? 'Chỉnh sửa lớp học' : 'Tạo lớp học mới',
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
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              return true;
            },
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            _buildLineInfo(
                              context,
                              Constants.price,
                              'Hãy thêm giá cho khoá học của bạn',
                              _priceClassController,
                            ),
                            _buildDivider(context),
                            SizedBox(height: 8.0),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.sp),
                      Visibility(
                        visible: widget.classModel != null,
                        child: Column(
                          children: [
                            BlocBuilder<ShareExamBloc, ShareExamState>(
                              builder: (context, state) {
                                if (state is GetDoneShareExam) {
                                  return Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(horizontal: 22.sp),
                                    child: Wrap(
                                      spacing: 5,
                                      runSpacing: 10,
                                      children: state.exams.map((exam) {
                                        int indexOfShare =
                                            _pickExams.indexWhere((element) => element == exam.id);
                                        bool isPicked = indexOfShare != -1;
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (isPicked) {
                                                _pickExams.removeAt(indexOfShare);
                                              } else {
                                                _pickExams.add(exam.id);
                                              }
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 6.25.sp,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                30.sp,
                                              ),
                                              color: isPicked ? colorPrimary : Colors.grey,
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(width: 16.sp),
                                                Text(
                                                  exam.name,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(width: 16.sp),
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  );
                                }

                                return Container();
                              },
                            ),
                            SizedBox(height: 20.sp),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            showDialogLoading(context);
                            if (widget.classModel != null) {
                              AppBloc.classBloc.add(
                                EditClass(
                                  context: context,
                                  id: widget.classModel!.id,
                                  name: _name,
                                  intro: _intro,
                                  topic: _topic,
                                  setOfQuestionShare: _pickExams,
                                  price: double.parse(_price.replaceAll(',', '')),
                                ),
                              );
                            } else {
                              AppBloc.classBloc.add(
                                CreateClass(
                                  context: context,
                                  name: _name,
                                  intro: _intro,
                                  topic: _topic,
                                  price: double.parse(_price.replaceAll(',', '')),
                                ),
                              );
                            }
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
                              widget.classModel != null ? 'Lưu thông tin' : 'Tạo lớp học',
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
            } else {
              _price = val.trim();
            }
          });
        },
        inputFormatters: title == Constants.price
            ? [
                FilteringTextInputFormatter.digitsOnly,
                TextInputFormatter.withFunction((oldValue, newValue) {
                  if (newValue.text.isEmpty) {
                    return newValue.copyWith(text: '');
                  } else if (newValue.text.compareTo(oldValue.text) != 0) {
                    final int selectionIndexFromTheRight =
                        newValue.text.length - newValue.selection.end;
                    final f = NumberFormat("#,###");
                    final number = int.parse(newValue.text.replaceAll(f.symbols.GROUP_SEP, ''));
                    final newString = f.format(number);
                    return TextEditingValue(
                      text: newString,
                      selection: TextSelection.collapsed(
                        offset: newString.length - selectionIndexFromTheRight,
                      ),
                    );
                  } else {
                    return newValue;
                  }
                }),
              ]
            : [
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
