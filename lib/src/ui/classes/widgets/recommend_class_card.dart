import 'package:cloudmate/src/models/class_model.dart';
import 'package:cloudmate/src/utils/blurhash.dart';
import 'package:flutter/material.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/app_decorations.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/utils/stack_avatar.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class RecommendClassCard extends StatefulWidget {
  final ClassModel classModel;
  RecommendClassCard({
    required this.classModel,
  });
  @override
  State<StatefulWidget> createState() => _RecommendClassCardState();
}

class _RecommendClassCardState extends State<RecommendClassCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82.sp,
      margin: EdgeInsets.only(left: 10.5.sp, right: 10.5.sp, bottom: 10.sp),
      decoration: AppDecoration.buttonActionBorder(context, 16.sp).decoration,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 15.sp, right: 10.sp),
              child: Row(
                children: [
                  Container(
                    height: 46.sp,
                    width: 46.sp,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1000.sp),
                      child: BlurHash(
                        hash: widget.classModel.blurHash,
                        image: widget.classModel.image,
                        imageFit: BoxFit.cover,
                        color: colorPrimary,
                      ),
                    ),
                  ),
                  SizedBox(width: 14.sp),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.classModel.name,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: FontFamily.lato,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4.sp),
                        _buildTileInfo(
                          '4.5 / 5.0',
                          PhosphorIcons.starFill,
                          Colors.amberAccent.shade700,
                        ),
                        SizedBox(height: 4.sp),
                        _buildTileInfo(
                          widget.classModel.createdBy?.displayName,
                          PhosphorIcons.graduationCapFill,
                          Colors.pinkAccent.shade100,
                        ),
                        SizedBox(height: 4.sp),
                        Row(
                          children: [
                            widget.classModel.members.isEmpty
                                ? Container()
                                : StackAvatar(
                                    size: 18.25.sp,
                                    images: widget.classModel.members
                                        .map((item) => item.image!)
                                        .toList(),
                                    blueHash: widget.classModel.members
                                        .map((item) => item.blurHash!)
                                        .toList(),
                                  ),
                            SizedBox(width: 6.sp),
                            Text(
                              widget.classModel.members.isEmpty
                                  ? 'Chưa có học viên'
                                  : '${widget.classModel.members.length} học viên',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontFamily: FontFamily.lato,
                                fontWeight: FontWeight.w600,
                                color:
                                    Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 38.sp,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(
                right: Radius.circular(16.sp),
              ),
              gradient: LinearGradient(
                colors: [
                  Color(0xFF22BFC3),
                  colorPrimary,
                  Colors.blueAccent.shade200,
                  Colors.blueAccent.shade400,
                ],
                stops: [
                  .05,
                  .5,
                  .9,
                  1.0,
                ],
                tileMode: TileMode.repeated,
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
            child: RotatedBox(
              quarterTurns: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 6.sp),
                  Text(
                    'Tham gia',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontFamily: FontFamily.lato,
                      fontWeight: FontWeight.w600,
                      color: mC,
                    ),
                  ),
                  SizedBox(width: 2.sp),
                  Padding(
                    padding: EdgeInsets.only(top: 2.sp),
                    child: Icon(
                      PhosphorIcons.caretRightBold,
                      size: 12.sp,
                      color: mC,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildTileInfo(title, icon, color) {
    return Container(
      width: 120.sp,
      padding: EdgeInsets.only(right: 4.sp),
      child: Row(
        children: [
          Icon(
            icon,
            size: 12.5.sp,
            color: color,
          ),
          SizedBox(width: 6.sp),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10.sp,
              fontFamily: FontFamily.lato,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.75),
            ),
          ),
        ],
      ),
    );
  }
}
