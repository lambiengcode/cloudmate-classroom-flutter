import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class StackAvatar extends StatefulWidget {
  final List<String>? images;
  StackAvatar({this.images});
  @override
  State<StatefulWidget> createState() => _StackAvatarState();
}

class _StackAvatarState extends State<StackAvatar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          _buildAvatar(context, 0),
          _buildAvatar(context, 1),
          _buildAvatar(context, 2),
        ],
      ),
    );
  }

  Widget _buildAvatar(context, index) {
    return Container(
      height: 22.5.sp,
      width: 22.5.sp,
      margin: EdgeInsets.only(left: (2 - index) * 12.sp),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).scaffoldBackgroundColor,
          width: 2.sp,
        ),
        image: DecorationImage(
          image: NetworkImage(widget.images![index]),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
