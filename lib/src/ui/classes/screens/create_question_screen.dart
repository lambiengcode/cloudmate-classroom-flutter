import 'dart:io';

import 'package:cloudmate/src/helpers/picker/custom_image_picker.dart';
import 'package:cloudmate/src/models/question_mode.dart';
import 'package:cloudmate/src/models/question_type_enum.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/app_decorations.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:cloudmate/src/ui/classes/blocs/question/question_bloc.dart';
import 'package:cloudmate/src/ui/classes/widgets/character_counter.dart';
import 'package:cloudmate/src/ui/classes/widgets/dialog_add_answer.dart';
import 'package:cloudmate/src/ui/classes/widgets/dialog_add_dad.dart';
import 'package:cloudmate/src/ui/common/dialogs/dialog_loading.dart';
import 'package:cloudmate/src/ui/common/widgets/get_snack_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';
import 'package:cloudmate/src/helpers/string.dart';

class CreateQuestionScreen extends StatefulWidget {
  final QuestionBloc questionBloc;
  final QuestionModel? questionModel;
  final String examId;
  const CreateQuestionScreen({
    required this.questionBloc,
    required this.examId,
    this.questionModel,
  });
  @override
  _CreateQuestionScreenState createState() => _CreateQuestionScreenState();
}

class _CreateQuestionScreenState extends State<CreateQuestionScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  File? _audio;
  QuestionType _questionType = QuestionType.singleChoise;
  TextEditingController _questionController = TextEditingController();
  TextEditingController _durationController = TextEditingController();
  TextEditingController _scoreController = TextEditingController();
  FocusNode textFieldFocus = FocusNode();
  List<String> _answers = [];
  List<String> _answersTrueFalse = ['Đúng', 'Sai'];
  List<String> _corrects = [];
  String _trueOrFalse = 'Đúng';
  String _question = '';
  String _duration = '';
  String _score = '';
  List<Map<String, String>> dragAndDrops = [];

  @override
  void initState() {
    super.initState();
    if (widget.questionModel != null) {
      QuestionModel _questionModel = widget.questionModel!;
      _questionController.text = _questionModel.question;
      _durationController.text = _questionModel.duration.toString();
      _scoreController.text = _questionModel.score.toString();
      _score = _questionModel.score.toString();
      _question = _questionModel.question;
      _duration = _questionModel.duration.toString();

      _questionType = widget.questionModel!.type;

      if (_questionType != QuestionType.dragAndDrop) {
        _answers = _questionModel.answers;
        _questionModel.corrects.forEach((index) {
          if (index <= _answers.length) {
            _corrects.add(_answers[index].toString());
          }
        });
      } else {
        _questionModel.answers.asMap().forEach((index, answer) {
          if (index < (_questionModel.answers.length / 2)) {
            dragAndDrops.add({
              'key': answer,
            });
          } else {
            dragAndDrops[index - (_questionModel.answers.length ~/ 2)]['value'] = answer;
          }
        });
      }
    }
  }

  bool _checkIsCorrect(String answer) {
    if (_questionType == QuestionType.trueFalse) {
      return _trueOrFalse == answer;
    } else {
      return _corrects.contains(answer);
    }
  }

  _handleAddAnswer(String answer) {
    setState(() {
      _answers.add(answer);
    });
  }

  _handleRemoveAnswer(String answer) {
    setState(() {
      int index = _answers.indexOf(answer);
      if (index != -1) {
        int indexOfCorrect = _corrects.indexOf(answer);
        if (indexOfCorrect != -1) {
          _corrects.removeAt(indexOfCorrect);
        }
        _answers.removeAt(index);
      }
    });
  }

  _handleToggleAnswer(String answer) {
    int index = _corrects.indexOf(answer);
    setState(() {
      if (index != -1) {
        _corrects.removeAt(index);
      } else {
        _corrects.add(answer);
      }
    });
  }

  _handlePressedAddQuestion() async {
    await dialogAnimationWrapper(
      context: context,
      dismissible: true,
      slideFrom: 'bottom',
      child: _questionType == QuestionType.dragAndDrop
          ? DialogAddDad(handleFinish: (key, val) {
              setState(() {
                dragAndDrops.add({
                  'key': key,
                  'value': val,
                });
              });
            })
          : DialogInput(
              handleFinish: _handleAddAnswer,
              title: 'Nhập câu trả lời',
              buttonTitle: 'Thêm câu trả lời',
            ),
    );
  }

  Future<void> pickFileAudio() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['mp3'],
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _audio = File(result.paths.first!);
        });
      }
    } catch (err) {
      print(err);
    }
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
          widget.questionModel == null ? 'Tạo câu hỏi' : 'Sửa câu hỏi',
          style: TextStyle(
            fontSize: 15.sp,
            fontFamily: FontFamily.lato,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (_questionType != QuestionType.trueFalse &&
                  _questionType != QuestionType.dragAndDrop) {
                if (_corrects.length == 0) {
                  GetSnackBar getSnackBar = GetSnackBar(
                    title: 'Tạo câu hỏi thất bại!',
                    subTitle: 'Chưa có câu trả lời đúng cho câu hỏi này.',
                  );
                  getSnackBar.show();
                  return;
                }
              }

              if (_formKey.currentState!.validate()) {
                showDialogLoading(context);
                List<int> _formatListCorrect = [];
                _corrects.forEach((item) {
                  int index = _answers.indexOf(item);
                  if (index != -1) {
                    _formatListCorrect.add(index);
                  }
                });

                List<String> _answerOfDaD = [];
                List<int> _correctofDaD = [];

                if (_questionType == QuestionType.dragAndDrop) {
                  List<String> _keys = dragAndDrops.map((e) => e['key'].toString()).toList();
                  List<String> _values = dragAndDrops.map((e) => e['value'].toString()).toList();

                  dragAndDrops.asMap().forEach((key, value) {
                    _correctofDaD.add(_keys.indexOf(value['key'].toString()) + 1);
                    _correctofDaD
                        .add(_values.indexOf(value['value'].toString()) + 1 + _keys.length);
                  });

                  _answerOfDaD = _keys + _values;
                }

                if (widget.questionModel == null) {
                  widget.questionBloc.add(
                    CreateQuestionEvent(
                      answers: _questionType == QuestionType.dragAndDrop
                          ? _answerOfDaD
                          : _questionType == QuestionType.trueFalse
                              ? _answersTrueFalse
                              : _answers,
                      context: context,
                      corrects: _questionType == QuestionType.dragAndDrop
                          ? _correctofDaD
                          : _questionType == QuestionType.trueFalse
                              ? [_answersTrueFalse.indexOf(_trueOrFalse)]
                              : _formatListCorrect,
                      duration: int.parse(_duration),
                      examId: widget.examId,
                      question: _question,
                      score: int.parse(_score),
                      banner: _image,
                      audio: _audio,
                      type: _questionType,
                    ),
                  );
                } else {
                  widget.questionBloc.add(
                    UpdateQuestionEvent(
                      answers: _questionType == QuestionType.dragAndDrop
                          ? _answerOfDaD
                          : _questionType == QuestionType.trueFalse
                              ? _answersTrueFalse
                              : _answers,
                      context: context,
                      corrects: _questionType == QuestionType.dragAndDrop
                          ? _correctofDaD
                          : _questionType == QuestionType.trueFalse
                              ? [_answersTrueFalse.indexOf(_trueOrFalse)]
                              : _formatListCorrect,
                      duration: int.parse(_duration),
                      questionId: widget.questionModel!.id,
                      question: _question,
                      score: int.parse(_score),
                      banner: _image,
                    ),
                  );
                }
              }
            },
            icon: Icon(
              PhosphorIcons.checkBold,
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
                  SizedBox(height: 12.sp),
                  _buildTitle(context: context, title: 'Kiểu câu hỏi', isShowSuffix: false),
                  SizedBox(height: 4.sp),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 22.sp),
                    padding: EdgeInsets.only(right: 6.0),
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
                          null,
                          size: 18.sp,
                          color: colorTitle,
                        ),
                        iconEnabledColor: Colors.grey.shade800,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        value: _questionType,
                        items: QuestionType.values.map((state) {
                          return DropdownMenuItem(
                            value: state,
                            child: Text(
                              state.getTileByEnum(),
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: colorTitle,
                                fontWeight: FontWeight.w500,
                                fontFamily: FontFamily.lato,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (QuestionType? val) {
                          if (val == QuestionType.singleChoise) {
                            _corrects.clear();
                          }
                          setState(() {
                            _questionType = val!;
                          });
                        },
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 12.0),
                            _buildLineInfo(
                              context,
                              'Nhập câu hỏi',
                              'Hãy nhập tên bài kiểm tra',
                              _questionController,
                            ),
                            _buildDivider(context),
                            _buildLineInfo(
                              context,
                              'Đặt thời gian trả lời (giây)',
                              'Hãy đặt thời gian trả lời cho câu hỏi',
                              _durationController,
                            ),
                            _buildDivider(context),
                            _buildLineInfo(
                              context,
                              'Điểm cho câu trả lời đúng',
                              'Hãy đặt điểm cho câu trả lời đúng',
                              _scoreController,
                            ),
                            _buildDivider(context),
                            _questionType == QuestionType.dragAndDrop
                                ? SizedBox()
                                : SizedBox(height: 16.sp),
                            _questionType == QuestionType.dragAndDrop
                                ? SizedBox()
                                : _buildTitle(
                                    context: context,
                                    title: 'Âm thanh kèm theo',
                                    isShowSuffix: false),
                            _questionType == QuestionType.dragAndDrop
                                ? SizedBox()
                                : SizedBox(height: 16.sp),
                            // Here is container for pick audio file
                            GestureDetector(
                              onTap: () async {},
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 22.sp),
                                height: 42.sp,
                                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                                decoration: AppDecoration.buttonActionBorderActive(context, 8.sp)
                                    .decoration,
                                child: Row(
                                  children: [
                                    SizedBox(width: 6.sp),
                                    Expanded(
                                      child: Text(
                                        _audio == null
                                            ? (widget.questionModel?.audio == null
                                                ? 'Chọn âm thanh'
                                                : widget.questionModel!.audio!)
                                            : _audio!.path,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: FontFamily.lato,
                                          fontSize: 11.5.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .color!
                                              .withOpacity(.8),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 12.sp),
                                    GestureDetector(
                                      onTap: () async {
                                        showDialogLoading(context);
                                        await pickFileAudio();
                                        AppNavigator.pop();
                                      },
                                      child: Container(
                                        height: 28.sp,
                                        width: 28.sp,
                                        decoration: BoxDecoration(
                                          color: colorPrimary,
                                          borderRadius: BorderRadius.circular(8.sp),
                                        ),
                                        alignment: Alignment.center,
                                        child: Icon(
                                          PhosphorIcons.folderNotchOpenFill,
                                          size: 15.sp,
                                          color: mC,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            _questionType == QuestionType.dragAndDrop
                                ? SizedBox()
                                : SizedBox(height: 16.sp),
                            _questionType == QuestionType.dragAndDrop
                                ? SizedBox()
                                : _buildTitle(
                                    context: context,
                                    title: 'Hình ảnh kèm theo',
                                    isShowSuffix: false),
                            _questionType == QuestionType.dragAndDrop
                                ? SizedBox()
                                : SizedBox(height: 16.sp),
                            _questionType == QuestionType.dragAndDrop
                                ? SizedBox()
                                : GestureDetector(
                                    onTap: () {
                                      CustomImagePicker().openImagePicker(
                                        context: context,
                                        handleFinish: (File image) async {
                                          setState(() {
                                            _image = image;
                                          });
                                        },
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(horizontal: 22.sp),
                                      height: 48.sp,
                                      width: 48.sp,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: colorPrimary,
                                          width: 1.5.sp,
                                        ),
                                        borderRadius: BorderRadius.circular(6.sp),
                                        image: _image == null &&
                                                widget.questionModel?.banner == null
                                            ? null
                                            : DecorationImage(
                                                image: _image != null
                                                    ? FileImage(_image!)
                                                    : NetworkImage(widget.questionModel!.banner!)
                                                        as ImageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                      alignment: Alignment.center,
                                      child: Icon(
                                        PhosphorIcons.plusCircle,
                                        color: colorPrimary,
                                        size: 18.sp,
                                      ),
                                    ),
                                  ),
                            SizedBox(height: 12.sp),
                            _buildTitle(
                              context: context,
                              title: 'Câu trả lời',
                              isShowSuffix: _questionType != QuestionType.trueFalse,
                            ),
                            SizedBox(height: 4.sp),
                            _questionType == QuestionType.dragAndDrop
                                ? _buildLayoutForDaD()
                                : Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(horizontal: 22.sp - 5),
                                    child: Wrap(
                                      spacing: 5,
                                      runSpacing: 10,
                                      children: (_questionType == QuestionType.trueFalse
                                              ? _answersTrueFalse
                                              : _answers)
                                          .map((answer) {
                                        return GestureDetector(
                                          onTap: () {
                                            switch (_questionType) {
                                              case QuestionType.multipleChoise:
                                                _handleToggleAnswer(answer);
                                                break;
                                              case QuestionType.singleChoise:
                                                _corrects.clear();
                                                _handleToggleAnswer(answer);
                                                break;
                                              case QuestionType.trueFalse:
                                                setState(() {
                                                  _trueOrFalse = answer;
                                                });
                                                break;
                                              default:
                                                break;
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 6.sp,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                30.sp,
                                              ),
                                              color: _checkIsCorrect(answer)
                                                  ? Theme.of(context).primaryColor
                                                  : Colors.grey,
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(width: 6.sp),
                                                _questionType == QuestionType.trueFalse
                                                    ? SizedBox()
                                                    : GestureDetector(
                                                        onTap: () {
                                                          _handleRemoveAnswer(answer);
                                                        },
                                                        child: Icon(
                                                          PhosphorIcons.xCircleFill,
                                                          size: 20.sp,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                SizedBox(width: 10.sp),
                                                Text(
                                                  answer.limitLength(30),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(width: 18.sp),
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  )
                          ],
                        ),
                      ),
                      SizedBox(height: 24.sp),
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

  Widget _buildLayoutForDaD() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.sp),
      child: Row(
        children: [
          _buildColumnLayoutDaD(dragAndDrops.map((e) => e['key'].toString()).toList(), true),
          _buildColumnLayoutDaD(dragAndDrops.map((e) => e['value'].toString()).toList(), false),
        ],
      ),
    );
  }

  Widget _buildColumnLayoutDaD(List<String> values, bool isKey) {
    return Expanded(
      child: Column(
        children: values
            .map((e) => Container(
                  width: 45.w,
                  decoration: BoxDecoration(
                    color: colorDarkGrey,
                    borderRadius: BorderRadius.circular(4.sp),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 8.sp),
                  padding: EdgeInsets.symmetric(vertical: 12.sp),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      SizedBox(width: 4.sp),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            dragAndDrops.removeWhere(
                              (dad) => isKey ? dad['key'] == e : dad['value'] == e,
                            );
                          });
                        },
                        child: Icon(
                          PhosphorIcons.xCircleFill,
                          size: 20.sp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 4.sp),
                      Expanded(
                        child: Text(
                          e,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildLineInfo(context, title, valid, controller) {
    final _size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.fromLTRB(14.0, 18.0, 12.0, 4.0),
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
          if (title == 'Nhập câu hỏi') {
            if (val!.length == 0) {
              return valid;
            } else if (val.length > 60) {
              return 'Câu hỏi không được vượt quá 60 ký tự';
            }
          } else if (title == 'Đặt thời gian trả lời (giây)') {
            int duration = int.tryParse(val?.trim() ?? '') ?? 0;
            if (duration < 10) {
              return 'Thời gian tối thiểu phải là 10 giây';
            }
          } else if (title == 'Điểm cho câu trả lời đúng') {
            int score = int.tryParse(val?.trim() ?? '') ?? 0;
            if (score < 1) {
              return 'Điểm tối thiểu phải là 1 điểm';
            }
          }
          return val!.length == 0 ? valid : null;
        },
        onChanged: (val) {
          setState(() {
            if (title == 'Nhập câu hỏi') {
              _question = val.trim();
            } else if (title == 'Đặt thời gian trả lời (giây)') {
              _duration = val.trim();
            } else {
              _score = val.trim();
            }
          });
        },
        inputFormatters: title != 'Nhập câu hỏi'
            ? [FilteringTextInputFormatter.digitsOnly]
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
            fontSize: _size.width / 26.0,
            fontWeight: FontWeight.w600,
          ),
          suffixIcon:
              title == 'Nhập câu hỏi' ? CharacterCounter(min: 60, value: _question.length) : null,
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

  Widget _buildTitle({context, title, isShowSuffix = false}) {
    return Padding(
      padding: EdgeInsets.only(left: 22.sp, right: 10.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              fontFamily: FontFamily.lato,
              color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.72),
            ),
          ),
          !isShowSuffix
              ? SizedBox()
              : IconButton(
                  onPressed: () => _handlePressedAddQuestion(),
                  icon: Icon(
                    PhosphorIcons.plusCircleBold,
                    color: colorPrimary,
                    size: 20.sp,
                  ),
                ),
        ],
      ),
    );
  }
}
