import 'package:ezanimation/ezanimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_mobile_2school/src/themes/app_colors.dart';
import 'package:flutter_mobile_2school/src/themes/theme_service.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

class NewPost extends StatefulWidget {
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  EzAnimation? _bottomButtonColorAnimation;
  EzAnimation? _charsCounterOpacityAnimation;

  final _tweetFieldFocusNode = FocusNode();
  final _tweetTextController = TextEditingController();

  @override
  void initState() {
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
    return Container(
      padding: EdgeInsets.only(bottom: 15.sp),
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
            padding: EdgeInsets.only(left: 13.25.sp, right: 10.sp),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 4.sp),
                Container(
                  height: 25.sp,
                  width: 25.sp,
                  margin: EdgeInsets.only(top: 3.25.sp),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://avatars.githubusercontent.com/u/60530946?v=4',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 12.sp),
                Flexible(
                  child: TextFormField(
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1!.color,
                      fontSize: 12.sp,
                    ),
                    focusNode: _tweetFieldFocusNode,
                    controller: _tweetTextController,
                    maxLines: null,
                    decoration: InputDecoration(
                      fillColor: Theme.of(context).scaffoldBackgroundColor,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 5.sp,
                      ),
                      labelText: 'Whats going on?',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelStyle: TextStyle(
                        color: themeService.isSavedDarkMode()
                            ? Colors.white.withOpacity(.75)
                            : null,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.sp, top: 4.sp),
                  child: Icon(
                    PhosphorIcons.telegramLogo,
                    size: 20.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.sp),
          Row(
            children: [
              _buildAction(Feather.video, color: colorPrimary),
              _buildAction(Feather.image),
              _buildAction(Feather.bar_chart_2),
              _buildAction(Feather.star),
              _buildAction(Feather.calendar),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAction(icon, {color}) {
    return Expanded(
      child: Icon(
        icon,
        color: color ??
            Theme.of(context).textTheme.bodyText2!.color!.withOpacity(.7),
        size: 18.sp,
      ),
    );
  }
}