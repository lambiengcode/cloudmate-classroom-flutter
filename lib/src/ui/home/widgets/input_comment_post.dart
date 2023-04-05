import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/models/post_model.dart';
import 'package:cloudmate/src/public/constants.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class BottomInputCommentInPost extends StatefulWidget {
  final PostModel postModel;
  const BottomInputCommentInPost({required this.postModel});
  @override
  State<StatefulWidget> createState() => _BottomInputCommentInPostState();
}

class _BottomInputCommentInPostState extends State<BottomInputCommentInPost> {
  TextEditingController _commentController = TextEditingController();

  _handleSendComment() async {
    if (_commentController.text.trim().isNotEmpty) {
      String text = _commentController.text.trim();
      await FirebaseFirestore.instance.collection('comments').add({
        'postId': widget.postModel.id,
        'userId': AppBloc.authBloc.userModel?.id,
        'content': text,
        'createdBy': Timestamp.fromDate(DateTime.now()),
      });
      _commentController.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.sp),
      child: Column(
        children: [
          SizedBox(height: 2.sp),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 5.sp),
              Container(
                height: 24.sp,
                width: 24.sp,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                      AppBloc.authBloc.userModel?.image ?? Constants.urlImageDefault,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 2.sp),
              Expanded(
                child: TextField(
                  onTap: () => _handleSendComment(),
                  controller: _commentController,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    fontSize: 12.sp,
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 1,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                      left: 6.sp,
                      bottom: 3.sp,
                      top: 3.sp,
                      right: 10.sp,
                    ),
                    hintText: 'Type a comment...',
                    hintStyle: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(
                            ThemeService().isSavedDarkMode() ? .85 : .65,
                          ),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: FontFamily.lato,
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (mes) {},
                ),
              ),
              GestureDetector(
                onTap: () => _handleSendComment(),
                child: Icon(
                  PhosphorIcons.telegramLogoFill,
                  color: colorPrimary,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 8.sp),
            ],
          ),
        ],
      ),
    );
  }
}
