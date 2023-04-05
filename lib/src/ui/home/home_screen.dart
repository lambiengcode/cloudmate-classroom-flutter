import 'package:cloudmate/src/blocs/post_home/post_home_bloc.dart';
import 'package:cloudmate/src/blocs/share_exam/share_exam_bloc.dart';
import 'package:cloudmate/src/models/post_model.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/routes/app_routes.dart';
import 'package:cloudmate/src/ui/classes/blocs/class/class_bloc.dart';
import 'package:cloudmate/src/ui/classes/blocs/do_exam/do_exam_bloc.dart';
import 'package:cloudmate/src/ui/classes/widgets/dialog_add_answer.dart';
import 'package:cloudmate/src/ui/common/dialogs/dialog_loading.dart';
import 'package:cloudmate/src/ui/home/widgets/post_shimmer_list.dart';
import 'package:flutter/material.dart';
import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/blocs/theme/theme_event.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:cloudmate/src/ui/home/widgets/new_post.dart';
import 'package:cloudmate/src/ui/home/widgets/post_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _handlePressedEnterPin() async {
    await dialogAnimationWrapper(
      context: context,
      dismissible: true,
      slideFrom: 'bottom',
      child: DialogInput(
        handleFinish: (input) {
          AppBloc.doExamBloc
              .add(JoinQuizEvent(roomId: input.toString().trim()));
        },
        title: 'Nhập mã PIN',
        buttonTitle: 'Vào phòng',
        hideInputField: 'Nhập mã PIN để vào phòng kiểm tra ngay...',
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    AppBloc.postHomeBloc.add(OnPostHomeEvent());
    AppBloc.classBloc.add(TransitionToClassScreen());
    AppBloc.shareExamBloc.add(GetShareExamEvent());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (FocusScope.of(context).hasFocus) {
          FocusScope.of(context).unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: ThemeService.systemBrightness,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              AppBloc.themeBloc.add(
                OnChangeTheme(
                  themeMode: ThemeService.currentTheme == ThemeMode.dark
                      ? ThemeMode.light
                      : ThemeMode.dark,
                ),
              );
            },
            icon: Icon(
              ThemeService.currentTheme == ThemeMode.dark
                  ? PhosphorIcons.sunFill
                  : PhosphorIcons.moonFill,
              size: 22.sp,
              color: Colors.amber,
            ),
          ),
          title: RichText(
              text: TextSpan(
            children: [
              TextSpan(
                text: 'Cloud',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: FontFamily.dancing,
                  color: colorPrimary,
                ),
              ),
              TextSpan(
                text: 'mate',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: FontFamily.dancing,
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
              ),
            ],
          )),
          actions: [
            IconButton(
              onPressed: _handlePressedEnterPin,
              icon: Icon(
                PhosphorIcons.qrCode,
                size: 24.sp,
              ),
            ),
            IconButton(
              onPressed: () {
                AppNavigator.push(AppRoutes.NOTIFICATION);
              },
              icon: Icon(
                PhosphorIcons.bellSimple,
                size: 22.sp,
              ),
            ),
          ],
        ),
        body: Container(
          height: 100.h,
          width: 100.w,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.5.sp),
                Divider(
                  height: .25,
                  thickness: .25,
                ),
                Expanded(
                  child: BlocBuilder<PostHomeBloc, PostHomeState>(
                    builder: (context, state) {
                      if (state is PostHomeInitial) {
                        return PostShimmerList();
                      }

                      List<PostModel> posts = (state.props[0] as List).cast();
                      return ListView.builder(
                        padding: EdgeInsets.only(top: 12.sp, bottom: 20.sp),
                        physics: BouncingScrollPhysics(),
                        itemCount: posts.length + 1,
                        itemBuilder: (context, index) {
                          return index == 0
                              ? NewPost()
                              : PostCard(
                                  post: posts[index - 1],
                                  isLast: index == posts.length,
                                );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildSearchBar() {
  //   return Container(
  //     height: 42.sp,
  //     decoration: AppDecoration.inputChatDecoration(context).decoration,
  //     padding: EdgeInsets.only(left: 16.sp),
  //     margin: EdgeInsets.symmetric(horizontal: 8.sp),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: [
  //         Icon(
  //           PhosphorIcons.magnifyingGlassBold,
  //           size: 13.5.sp,
  //           color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(
  //                 ThemeService().isSavedDarkMode() ? .7 : .65,
  //               ),
  //         ),
  //         SizedBox(width: 12.sp),
  //         Text(
  //           'Find your class...',
  //           style: TextStyle(
  //             color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(
  //                   ThemeService().isSavedDarkMode() ? .9 : .65,
  //                 ),
  //             fontSize: 11.5.sp,
  //             fontWeight: FontWeight.w400,
  //             fontFamily: FontFamily.lato,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
