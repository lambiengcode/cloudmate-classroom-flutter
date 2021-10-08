import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/lang/language_service.dart';
import 'package:cloudmate/src/lang/localization.dart';
import 'package:cloudmate/src/models/class_model.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/ui/classes/blocs/class/class_bloc.dart';
import 'package:cloudmate/src/ui/common/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:cloudmate/src/models/slide_mode.dart';
import 'package:cloudmate/src/routes/app_routes.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:cloudmate/src/ui/classes/widgets/class_card.dart';
import 'package:cloudmate/src/ui/classes/widgets/recommend_class_card.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

class ClassesScreen extends StatefulWidget {
  @override
  _ClassesScreenState createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  @override
  void initState() {
    super.initState();
    AppBloc.classBloc.add(TransitionToClassScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassBloc, ClassState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            systemOverlayStyle: ThemeService.systemBrightness,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                AppNavigator.push(AppRoutes.DO_EXAM);
              },
              icon: Icon(
                PhosphorIcons.slidersHorizontal,
                size: 22.sp,
              ),
            ),
            title: Text(
              classTitle.i18n,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                fontFamily: FontFamily.lato,
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  LanguageService().switchLanguage(context);
                },
                icon: Icon(
                  PhosphorIcons.magnifyingGlassBold,
                  size: 20.sp,
                ),
              ),
              IconButton(
                onPressed: () {
                  AppNavigator.push(
                    AppRoutes.CREATE_CLASS,
                    arguments: {
                      'slide': SlideMode.bot,
                    },
                  );
                },
                icon: Icon(
                  Feather.plus_square,
                  size: 20.sp,
                  color: colorPrimary,
                ),
              ),
            ],
          ),
          body: Container(
            height: 100.h,
            width: 100.w,
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 2.5.sp),
                  Divider(
                    height: .25,
                    thickness: .25,
                  ),
                  state is ClassInitial
                      ? Expanded(
                          child: LoadingScreen(),
                        )
                      : _buildClassesBody(context, state),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildClassesBody(context, ClassState state) {
    return Expanded(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: 8.sp, bottom: 16.sp),
        itemCount: state.props[1].length + (state.props[0].length == 0 ? 0 : 1),
        itemBuilder: (context, index) {
          ClassModel? _classModel;
          if (!(index == 0 && state.props[0].length > 0)) {
            _classModel = state.props[1][index - (state.props[1].length == 0 ? 0 : 1)];
          }
          return index == 0 && state.props[0].length > 0
              ? _buildCurrentClasses(context, state)
              : GestureDetector(
                  onTap: () {
                    AppNavigator.push(
                      AppRoutes.DETAILS_CLASS,
                      arguments: {
                        'slide': SlideMode.bot,
                        'classModel': _classModel,
                        'hasJoinedClass': false,
                      },
                    );
                  },
                  child: RecommendClassCard(
                    classModel: _classModel!,
                  ),
                );
        },
      ),
    );
  }

  _buildCurrentClasses(context, ClassState state) {
    return Container(
      padding: EdgeInsets.only(left: 10.sp),
      child: Column(
        children: [
          _buildTitle(
            yourClass.i18n,
            PhosphorIcons.chalkboardSimpleBold,
            themeService.isSavedDarkMode() ? colorAttendance : colorActive,
          ),
          Container(
            height: 164.sp,
            width: 100.w,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: state.props[0].length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    AppNavigator.push(
                      AppRoutes.DETAILS_CLASS,
                      arguments: {
                        'slide': SlideMode.bot,
                        'classModel': state.props[0][index],
                        'hasJoinedClass': true,
                      },
                    );
                  },
                  child: ClassCard(
                    classModel: state.props[0][index],
                  ),
                );
              },
            ),
          ),
          _buildTitle(
            recommendClass.i18n,
            PhosphorIcons.presentationChartBold,
            colorPrimary,
          ),
        ],
      ),
    );
  }

  _buildTitle(title, icon, color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 18.sp,
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
            PhosphorIcons.squaresFour,
            size: 20.sp,
          ),
        ),
      ],
    );
  }
}
