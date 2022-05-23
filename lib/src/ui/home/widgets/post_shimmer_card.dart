import 'package:cloudmate/src/ui/common/widgets/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class PostShimmerCard extends StatelessWidget {
  final bool isLast;
  const PostShimmerCard({required this.isLast});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 12.sp,
        bottom: 4.sp,
      ),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(
                  width: .3,
                  color: Colors.grey.shade300,
                ),
              ),
      ),
      child: Column(
        children: [
          _buildHeader(context),
          _buildBody(context),
          _buildBottom(context),
        ],
      ),
    );
  }

  Widget _buildHeader(context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.sp, right: 4.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildInfoWritter(context),
        ],
      ),
    );
  }

  Widget _buildBody(context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.sp),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4.sp),
                  FadeShimmer(
                    height: 12.sp,
                    width: 100.w,
                    fadeTheme: FadeTheme.lightReverse,
                  ),
                  SizedBox(height: 4.sp),
                  FadeShimmer(
                    height: 12.sp,
                    width: 100.w,
                    fadeTheme: FadeTheme.lightReverse,
                  ),
                  SizedBox(height: 4.sp),
                  FadeShimmer(
                    height: 12.sp,
                    width: 100.w,
                    fadeTheme: FadeTheme.lightReverse,
                  ),
                  SizedBox(height: 4.sp),
                  FadeShimmer(
                    height: 12.sp,
                    width: 100.sp,
                    fadeTheme: FadeTheme.lightReverse,
                  ),
                  SizedBox(height: 6.sp),
                ],
              ),
            ),
            SizedBox(height: 2.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildBottom(context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(width: 6.sp),
                  FadeShimmer(
                    height: 18.sp,
                    width: 18.sp,
                    fadeTheme: FadeTheme.lightReverse,
                  ),
                  SizedBox(width: 16.0),
                  FadeShimmer(
                    height: 18.sp,
                    width: 18.sp,
                    fadeTheme: FadeTheme.lightReverse,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.sp),
          // _buildLineFavouritePost(context),
        ],
      ),
    );
  }

  Widget _buildInfoWritter(context) {
    return Row(
      children: [
        Container(
          height: 28.sp,
          width: 28.sp,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6.sp),
            child: FadeShimmer(
              height: 28.sp,
              width: 28.sp,
              fadeTheme: FadeTheme.lightReverse,
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeShimmer(
              height: 12.5.sp,
              width: 80.sp,
              fadeTheme: FadeTheme.lightReverse,
            ),
            SizedBox(height: 2.15.sp),
            FadeShimmer(
              height: 12.5.sp,
              width: 40.sp,
              fadeTheme: FadeTheme.lightReverse,
            ),
          ],
        ),
      ],
    );
  }
}
