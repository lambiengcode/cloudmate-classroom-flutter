import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/utils/blurhash.dart';
import 'package:flutter/material.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class StackAvatar extends StatefulWidget {
  final List<String> images;
  final List<String> blueHash;
  final double size;
  StackAvatar({required this.images, required this.blueHash, this.size = 25});
  @override
  State<StatefulWidget> createState() => _StackAvatarState();
}

class _StackAvatarState extends State<StackAvatar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          _buildAvatar(context, 0),
          widget.images.length >= 2 ? _buildAvatar(context, 1) : Container(),
          widget.images.length >= 3 ? _buildAvatar(context, 2) : Container(),
        ],
      ),
    );
  }

  Widget _buildAvatar(context, index) {
    return Container(
      height: widget.size,
      width: widget.size,
      margin: EdgeInsets.only(left: index * 12.sp),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).scaffoldBackgroundColor,
          width: 1.15.sp,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(1000.sp),
        child: BlurHash(
          hash: widget.blueHash[index],
          image: widget.images[index],
          imageFit: BoxFit.cover,
          color: colorPrimary,
        ),
      ),
    );
  }
}
