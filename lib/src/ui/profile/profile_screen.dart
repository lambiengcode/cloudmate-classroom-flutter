import 'dart:io';
import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/blocs/authentication/bloc.dart';
import 'package:cloudmate/src/blocs/bloc/transaction_bloc.dart';
import 'package:cloudmate/src/configs/application.dart';
import 'package:cloudmate/src/helpers/picker/custom_image_picker.dart';
import 'package:cloudmate/src/models/slide_mode.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/routes/app_routes.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:cloudmate/src/ui/classes/blocs/class/class_bloc.dart';
import 'package:cloudmate/src/ui/classes/widgets/recommend_class_card.dart';
import 'package:cloudmate/src/ui/classes/widgets/transaction_card.dart';
import 'package:cloudmate/src/ui/common/dialogs/dialog_loading.dart';
import 'package:cloudmate/src/ui/common/screens/loading_screen.dart';
import 'package:cloudmate/src/utils/blurhash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (!Application.isProductionMode) {
      AppBloc.transactionBloc.add(GetTransactionEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (_, auth) {
      if (auth is AuthenticationSuccess) {
        if (auth.userModel == null) {
          return LoadingScreen();
        }
        return Scaffold(
          appBar: AppBar(
            systemOverlayStyle: ThemeService.systemBrightness,
            backgroundColor: Colors.transparent,
            elevation: .0,
            centerTitle: true,
            leading: IconButton(
              splashColor: colorPrimary,
              splashRadius: 5.0,
              icon: Icon(
                PhosphorIcons.slidersHorizontal,
                size: 22.5.sp,
              ),
              onPressed: () {
                AppNavigator.push(
                  AppRoutes.EDIT_INFO_USER,
                  arguments: {
                    'slide': SlideMode.left,
                  },
                );
              },
            ),
            actions: [
              IconButton(
                splashRadius: 10.0,
                icon: Icon(
                  PhosphorIcons.signOutBold,
                  size: 20.sp,
                  color: colorHigh,
                ),
                onPressed: () => AppBloc.authBloc.add(LogOutEvent()),
              ),
            ],
          ),
          body: Container(
            height: 100.h,
            width: 100.w,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    CustomImagePicker().openImagePicker(
                      context: context,
                      handleFinish: (File image) async {
                        showDialogLoading(context);
                        AppBloc.authBloc.add(
                          UpdateAvatarUser(avatar: image),
                        );
                      },
                    );
                  },
                  child: Container(
                    width: 100.w,
                    alignment: Alignment.center,
                    child: Container(
                      height: 105.sp,
                      width: 105.sp,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorPrimary,
                          width: 3.sp,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Container(
                        height: 95.sp,
                        width: 95.sp,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(1000.sp),
                          child: BlurHash(
                            hash: auth.userModel!.blurHash!,
                            image: auth.userModel!.image!,
                            imageFit: BoxFit.cover,
                            color: colorPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.sp),
                Text(
                  auth.userModel!.displayName!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: FontFamily.lato,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6.sp),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  alignment: Alignment.center,
                  child: Text(
                    auth.userModel!.intro == '' ? '☃ Chưa cập nhật ☃' : auth.userModel!.intro!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400,
                      color: colorPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 16.sp),
                _buildTitle(
                  'Lịch sử',
                  PhosphorIcons.clockClockwiseBold,
                  Colors.amberAccent.shade700,
                ),
                SizedBox(height: 4.sp),
                Application.isProductionMode
                    ? BlocBuilder<ClassBloc, ClassState>(
                        builder: (context, state) {
                          return Expanded(
                            child: NotificationListener<OverscrollIndicatorNotification>(
                              onNotification: (overscroll) {
                                return true;
                              },
                              child: state.props[0].isEmpty
                                  ? LoadingScreen(
                                      isShowText: false,
                                    )
                                  : ListView.builder(
                                      controller: scrollController,
                                      padding: EdgeInsets.only(bottom: 12.sp),
                                      physics: ClampingScrollPhysics(),
                                      itemCount: state.props[0].length,
                                      itemBuilder: (context, index) {
                                        return RecommendClassCard(
                                          classModel: state.props[0][index],
                                        );
                                      },
                                    ),
                            ),
                          );
                        },
                      )
                    : BlocBuilder<TransactionBloc, TransactionState>(
                        builder: (context, state) {
                          return Expanded(
                            child: state is GetDoneTransaction
                                ? ListView.builder(
                                    controller: scrollController,
                                    padding: EdgeInsets.only(bottom: 12.sp),
                                    physics: ClampingScrollPhysics(),
                                    itemCount: state.transactions.length,
                                    itemBuilder: (context, index) {
                                      return TransactionCard(
                                        transactionModel: state.transactions[index],
                                      );
                                    },
                                  )
                                : Center(
                                    child: CupertinoActivityIndicator(),
                                  ),
                          );
                        },
                      ),
              ],
            ),
          ),
        );
      }

      return Scaffold();
    });
  }

  _buildTitle(title, icon, color) {
    return Container(
      padding: EdgeInsets.only(left: 12.sp, right: 4.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 16.sp,
                color: color,
              ),
              SizedBox(width: 6.sp),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: FontFamily.lato,
                  color: color,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () => null,
            icon: Icon(
              null,
              size: 18.sp,
            ),
          ),
        ],
      ),
    );
  }
}
