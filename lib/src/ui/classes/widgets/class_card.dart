import 'package:flutter/material.dart';
import 'package:flutter_mobile_2school/src/themes/app_colors.dart';
import 'package:flutter_mobile_2school/src/themes/app_decorations.dart';
import 'package:flutter_mobile_2school/src/themes/font_family.dart';
import 'package:flutter_mobile_2school/src/utils/blurhash.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

class ClassCard extends StatefulWidget {
  final String? blurHash;
  final String imageClass;
  final String className;
  final String teacher;
  ClassCard({
    required this.className,
    required this.imageClass,
    this.blurHash,
    required this.teacher,
  });
  @override
  State<StatefulWidget> createState() => _ClassCardState();
}

class _ClassCardState extends State<ClassCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 120.sp,
          decoration:
              AppDecoration.buttonActionBorder(context, 15.0).decoration,
          margin: EdgeInsets.only(
            right: 8.sp,
            bottom: 12.sp,
            top: 4.sp,
          ),
          padding: EdgeInsets.only(bottom: 9.25.sp),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 53.5.sp,
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16.0),
                      ),
                      child: BlurHash(
                        hash: widget.blurHash ?? '',
                        image: widget.imageClass,
                        imageFit: BoxFit.cover,
                        color: colorPrimary,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => print('follow'),
                    child: Container(
                      width: 120.sp,
                      alignment: Alignment.center,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.sp,
                          vertical: 4.sp,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          boxShadow: [
                            BoxShadow(
                              color: mCD,
                              offset: Offset(4, 4),
                              blurRadius: 4,
                            ),
                          ],
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF22BFC3),
                              colorPrimary,
                              Colors.blueAccent.shade200,
                              Colors.blueAccent.shade400,
                            ],
                            stops: [
                              .05,
                              .15,
                              .7,
                              1.0,
                            ],
                            tileMode: TileMode.repeated,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Text(
                          'Xem',
                          style: TextStyle(
                            color: mCL,
                            fontSize: 8.5.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: FontFamily.lato,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 30.sp,
                left: 0,
                child: Column(
                  children: [
                    Container(
                      width: 120.sp,
                      alignment: Alignment.center,
                      child: Container(
                        height: 38.sp,
                        width: 38.sp,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        alignment: Alignment.center,
                        child: Container(
                          height: 34.sp,
                          width: 34.sp,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(1000.0),
                            child: BlurHash(
                              hash: widget.blurHash ?? '',
                              image: widget.imageClass,
                              imageFit: BoxFit.cover,
                              color: colorPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 4.sp),
                    Text(
                      widget.className,
                      style: TextStyle(
                        fontSize: 9.5.sp,
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
                    SizedBox(height: 2.5.sp),
                    _buildTileInfo(
                      widget.teacher,
                      PhosphorIcons.graduationCapFill,
                      Colors.pinkAccent.shade100,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildTileInfo(title, icon, color) {
    return Container(
      width: 120.sp,
      padding: EdgeInsets.only(left: 10.sp, right: 4.sp),
      child: Row(
        children: [
          Icon(
            icon,
            size: 11.5.sp,
            color: color,
          ),
          SizedBox(width: 6.sp),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 9.sp,
              fontFamily: FontFamily.lato,
              fontWeight: FontWeight.w600,
              color: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .color!
                  .withOpacity(.75),
            ),
          ),
        ],
      ),
    );
  }
}
