import 'package:cloudmate/src/models/road_map_content_model.dart';
import 'package:cloudmate/src/models/road_map_content_type.dart';
import 'package:cloudmate/src/public/constants.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:cloudmate/src/ui/classes/blocs/road_map_content/road_map_content_bloc.dart';
import 'package:cloudmate/src/ui/common/dialogs/dialog_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class CreateRoadmapContentScreen extends StatefulWidget {
  final RoadMapContentBloc roadMapContentBloc;
  final String classId;
  final String roadMapId;
  final RoadMapContentModel? roadMapContentModel;
  const CreateRoadmapContentScreen({
    required this.roadMapContentBloc,
    required this.classId,
    required this.roadMapId,
    this.roadMapContentModel,
  });
  @override
  _CreateRoadmapContentScreenState createState() => _CreateRoadmapContentScreenState();
}

class _CreateRoadmapContentScreenState extends State<CreateRoadmapContentScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _endTimeController = TextEditingController();
  FocusNode textFieldFocus = FocusNode();
  String _name = '';
  DateTime _startTime = DateTime.now();
  DateTime _endTime = DateTime.now().add(Duration(days: 3));
  RoadMapContentType _roadMapContentType = RoadMapContentType.assignment;
  List<String> fileExtensions = [];

  @override
  void initState() {
    super.initState();
    _updateTextTimeController();

    if (widget.roadMapContentModel?.fileExtensions != null) {
      fileExtensions = widget.roadMapContentModel!.fileExtensions!;
    }
  }

  void _updateTextTimeController() {
    _startTimeController.text = DateFormat('HH:mm - dd/MM/yyyy').format(_startTime);
    _endTimeController.text = DateFormat('HH:mm - dd/MM/yyyy').format(_endTime);
  }

  void _handlePickDate(
    context,
    DateTime initialDate,
    DateTime? minTime,
    DateTime? maxTime,
    Function onConfirm,
  ) async {
    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      minTime: minTime,
      maxTime: maxTime,
      onConfirm: (date) {
        onConfirm(date);
      },
      currentTime: initialDate,
      locale: LocaleType.vi,
    );
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
          'Tạo ${_roadMapContentType.value.toLowerCase()}',
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
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 2.5.sp),
                  Divider(
                    height: .25,
                    thickness: .25,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20.sp, right: 6.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      border: Border(
                        bottom: BorderSide(
                          color: Theme.of(context).dividerColor,
                          width: .25,
                        ),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField(
                        icon: Icon(
                          _roadMapContentType.icon,
                          size: 18.sp,
                          color: colorTitle,
                        ),
                        iconEnabledColor: Colors.grey.shade800,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        value: _roadMapContentType,
                        items: _roadMapContentType.getListRoadMap.map((state) {
                          return DropdownMenuItem(
                            value: state,
                            child: Text(
                              state.value,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: colorTitle,
                                fontWeight: FontWeight.w500,
                                fontFamily: FontFamily.lato,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (RoadMapContentType? val) {
                          setState(() {
                            _roadMapContentType = val!;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 12.0),
                            _buildLineInfo(
                              context,
                              'Tiêu đề cho ${_roadMapContentType.value.toLowerCase()}',
                              'Hãy nhập tiêu đề cho ${_roadMapContentType.value.toLowerCase()}',
                              _nameController,
                            ),
                            _buildDivider(context),
                            _buildLineInfo(
                              context,
                              'Thời gian bắt đầu',
                              'Đặt thời gian bắt đầu cho ${_roadMapContentType.value.toLowerCase()}',
                              _startTimeController,
                            ),
                            _buildDivider(context),
                            _buildLineInfo(
                              context,
                              'Thời gian kết thúc',
                              'Đặt thời gian kết thúc cho ${_roadMapContentType.value.toLowerCase()}',
                              _endTimeController,
                            ),
                            _buildDivider(context),
                            SizedBox(height: 20.sp),
                            Visibility(
                              visible: _roadMapContentType == RoadMapContentType.assignment,
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 22.sp),
                                child: Wrap(
                                  spacing: 5,
                                  runSpacing: 10,
                                  children: Constants.filesSupported.map((extensions) {
                                    int indexOfExtensions = fileExtensions.indexOf(extensions);
                                    bool isPicked = indexOfExtensions != -1;
                                    return GestureDetector(
                                      onTap: () {
                                        if (!isPicked) {
                                          setState(() {
                                            fileExtensions.add(extensions);
                                          });
                                        } else {
                                          setState(() {
                                            fileExtensions.removeAt(indexOfExtensions);
                                          });
                                        }
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
                                              extensions,
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
                              ),
                            ),
                            SizedBox(height: 8.0),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.sp),
                      GestureDetector(
                        onTap: () async {
                          if (fileExtensions.isEmpty &&
                              _roadMapContentType == RoadMapContentType.assignment) {
                            return;
                          }
                          if (_formKey.currentState!.validate()) {
                            showDialogLoading(context);
                            widget.roadMapContentBloc.add(
                              CreateRoadMapContentEvent(
                                classId: widget.classId,
                                roadMapId: widget.roadMapId,
                                name: _name,
                                startTime: _startTime,
                                endTime: _endTime,
                                context: context,
                                type: _roadMapContentType,
                                fileExtensions: fileExtensions,
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
                              'Lưu lại',
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
    return GestureDetector(
      onTap: () {
        if (title.contains('Thời gian')) {
          DateTime initialDate = title.contains('bắt đầu') ? _startTime : _endTime;
          DateTime? minDate = title.contains('bắt đầu') ? null : _startTime;
          DateTime? maxDate = title.contains('kết thúc') ? null : _endTime;
          _handlePickDate(context, initialDate, minDate, maxDate, (date) {
            if (title.contains('bắt đầu')) {
              if (_startTime.isBefore(_endTime)) {
                _startTime = date;
              }
            } else {
              if (_endTime.isAfter(_startTime)) {
                _endTime = date;
              }
            }
            setState(() {
              _updateTextTimeController();
            });
          });
        }
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(14.0, 18.0, 18.0, 4.0),
        child: TextFormField(
          enabled: !title.contains('Thời gian'),
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
              if (title.contains('Tiêu đề')) {
                _name = val.trim();
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
              color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.8),
              fontSize: _size.width / 26.0,
              fontWeight: FontWeight.w600,
            ),
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
