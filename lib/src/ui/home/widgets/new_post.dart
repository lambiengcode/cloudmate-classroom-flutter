import 'package:cloudmate/src/blocs/authentication/bloc.dart';
import 'package:cloudmate/src/public/constants.dart';
import 'package:cloudmate/src/ui/home/widgets/bottom_sheet_pick_class.dart';
import 'package:cloudmate/src/utils/blurhash.dart';
import 'package:ezanimation/ezanimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class NewPost extends StatefulWidget {
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  EzAnimation? _bottomButtonColorAnimation;
  EzAnimation? _charsCounterOpacityAnimation;
  bool _canPost = false;

  final _tweetFieldFocusNode = FocusNode();
  final _tweetTextController = TextEditingController();

  @override
  void initState() {
    _tweetTextController.addListener(() {
      if (_tweetTextController.text.isEmpty) {
        if (_canPost) {
          setState(() {
            _canPost = false;
          });
        }
      } else {
        if (!_canPost) {
          setState(() {
            _canPost = true;
          });
        }
      }
    });

    _charsCounterOpacityAnimation = EzAnimation(
      0.0,
      1.0,
      Duration(milliseconds: 300),
    );

    _bottomButtonColorAnimation = EzAnimation.tween(
      ColorTween(
        begin: Colors.grey,
        end: colorPrimary,
      ),
      Duration(milliseconds: 300),
    );

    _tweetTextController.addListener(() {
      setState(() {
        if (_tweetTextController.text.isNotEmpty) {
          _charsCounterOpacityAnimation!.start();
        } else {
          _charsCounterOpacityAnimation!.reverse();
        }
      });
    });

    _charsCounterOpacityAnimation!.addListener(() {
      setState(() {});
    });

    _bottomButtonColorAnimation!.addListener(() {
      setState(() {});
    });

    _tweetFieldFocusNode.addListener(() {
      if (_tweetFieldFocusNode.hasFocus) {
        _bottomButtonColorAnimation!.start();
      } else {
        _bottomButtonColorAnimation!.reverse();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.only(bottom: 6.sp),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor,
                width: .25,
              ),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 8.sp, right: 10.sp),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 4.sp),
                    Container(
                      margin: EdgeInsets.only(top: 4.sp),
                      height: 25.sp,
                      width: 25.sp,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.5.sp),
                        child: BlurHash(
                          hash: state is AuthenticationSuccess
                              ? (state.userModel?.blurHash ?? '')
                              : '',
                          image: state is AuthenticationSuccess
                              ? (state.userModel?.image ?? Constants.urlImageDefault)
                              : Constants.urlImageDefault,
                          imageFit: BoxFit.cover,
                          color: colorPrimary,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.sp),
                    Flexible(
                      child: TextFormField(
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          fontSize: 11.sp,
                        ),
                        focusNode: _tweetFieldFocusNode,
                        controller: _tweetTextController,
                        maxLines: null,
                        decoration: InputDecoration(
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 5.sp,
                            vertical: 10.sp,
                          ),
                          labelText: 'Bạn có thắc mắc cần trao đổi?',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelStyle: TextStyle(
                            color: ThemeService.currentTheme == ThemeMode.dark
                                ? Colors.white.withOpacity(.75)
                                : colorDarkGrey,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      // padding: EdgeInsets.only(right: 10.sp, top: 4.sp),
                      onPressed: () {
                        if (_canPost) {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => BottomSheetPickClass(
                              content: _tweetTextController.text,
                              handleFinished: () {
                                _tweetTextController.text = '';
                                _tweetFieldFocusNode.unfocus();
                              },
                            ),
                          );
                        }
                      },
                      icon: Icon(
                        PhosphorIcons.telegramLogo,
                        size: 20.sp,
                        color: _canPost ? colorPrimary : null,
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 10.sp),
              // Row(
              //   children: [
              //     _buildAction(Feather.video, color: colorPrimary),
              //     _buildAction(Feather.image),
              //     _buildAction(Feather.bar_chart_2),
              //     _buildAction(Feather.star),
              //     _buildAction(Feather.calendar),
              //   ],
              // ),
            ],
          ),
        );
      },
    );
  }

  // Widget _buildAction(icon, {color}) {
  //   return Expanded(
  //     child: Icon(
  //       icon,
  //       color: color ?? Theme.of(context).textTheme.bodyText2!.color!.withOpacity(.7),
  //       size: 18.sp,
  //     ),
  //   );
  // }
}
