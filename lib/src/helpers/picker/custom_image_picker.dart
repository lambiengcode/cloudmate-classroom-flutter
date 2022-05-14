import 'dart:io';

import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class CustomImagePicker {
  final _picker = ImagePicker();

  Widget _buildImageModalButton({context, index, icon, text, source, Function? handleFinish}) {
    return TextButton(
      onPressed: () async {
        XFile? image = await getImage(
          context: context,
          source: source,
          maxWidthImage: 600,
        );
        AppNavigator.pop();
        if (image != null && handleFinish != null) {
          handleFinish(File(image.path));
        }
      },
      style: ButtonStyle(
          animationDuration: Duration(milliseconds: 0),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.black.withOpacity(0.5);
              }
              return Colors.black; // Use the component's default.
            },
          ),
          overlayColor: MaterialStateProperty.all<Color>(Colors.transparent)),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6.sp),
        child: Row(
          children: [
            Icon(
              icon,
              size: 21.25.sp,
            ),
            SizedBox(
              width: 15.sp,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Future getImage({context, source = ImageSource.gallery, maxWidthImage, imageQualityImage}) async {
    return await _picker.pickImage(
      source: source,
      imageQuality: 80,
      maxWidth: 1000,
    );
  }

  Future openImagePicker({
    @required context,
    text = 'Chọn ảnh đại diện',
    Function? handleFinish,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: 210.sp,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  color: Colors.white,
                ),
                height: 170.sp,
                width: double.infinity,
                padding: EdgeInsets.only(left: 18.sp, right: 18.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25.sp,
                    ),
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    _buildImageModalButton(
                      context: context,
                      index: 0,
                      icon: PhosphorIcons.instagramLogo,
                      text: 'Chọn ảnh có sẵn',
                      source: ImageSource.gallery,
                      handleFinish: handleFinish,
                    ),
                    Divider(
                      height: 1,
                      thickness: 0.5,
                      color: Color(0xffe5e5e5),
                    ),
                    _buildImageModalButton(
                      context: context,
                      index: 1,
                      icon: PhosphorIcons.camera,
                      text: 'Chụp ảnh mới',
                      source: ImageSource.camera,
                      handleFinish: handleFinish,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
