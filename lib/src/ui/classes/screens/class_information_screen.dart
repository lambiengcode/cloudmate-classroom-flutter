import 'dart:io';
import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/blocs/post_class/post_class_bloc.dart';
import 'package:cloudmate/src/configs/application.dart';
import 'package:cloudmate/src/helpers/members_helpers.dart';
import 'package:cloudmate/src/helpers/picker/custom_image_picker.dart';
import 'package:cloudmate/src/helpers/role_helper.dart';
import 'package:cloudmate/src/models/class_model.dart';
import 'package:cloudmate/src/models/post_model.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/services/payment/momo_payment.dart';
import 'package:cloudmate/src/ui/classes/blocs/class/class_bloc.dart';
import 'package:cloudmate/src/ui/classes/widgets/drawer_option.dart';
import 'package:cloudmate/src/ui/common/dialogs/dialog_confirm.dart';
import 'package:cloudmate/src/ui/common/dialogs/dialog_loading.dart';
import 'package:cloudmate/src/ui/common/widgets/animated_fade.dart';
import 'package:cloudmate/src/ui/common/widgets/get_snack_bar.dart';
import 'package:cloudmate/src/ui/home/widgets/post_shimmer_list.dart';
import 'package:cloudmate/src/utils/blurhash.dart';
import 'package:flutter/material.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/app_decorations.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/ui/home/widgets/post_card.dart';
import 'package:cloudmate/src/utils/stack_avatar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momo_vn/momo_vn.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';
import 'package:cloudmate/src/helpers/string.dart';

class ClassInformationScreen extends StatefulWidget {
  final ClassModel classModel;
  final bool hasJoinedClass;
  const ClassInformationScreen({
    required this.classModel,
    this.hasJoinedClass = false,
  });
  @override
  State<StatefulWidget> createState() => _ClassInformationScreenState();
}

class _ClassInformationScreenState extends State<ClassInformationScreen>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _imageController;
  late AnimationController _heightController;
  late ClassModel _classModel;
  ScrollController _scrollController = ScrollController();
  double _heightOfClassImage = 34.h;
  bool _hasJoinedClass = false;

  @override
  void initState() {
    super.initState();
    AppBloc.postClassBloc.add(GetPostClassEvent(classId: widget.classModel.id));
    _classModel = widget.classModel;
    _hasJoinedClass = widget.hasJoinedClass;
    _imageController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _heightController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _scrollController.addListener(() {
      if (_scrollController.offset <= 0) {
        _imageController.value = 0.0;
      } else {
        _imageController.value = _scrollController.offset / (_heightOfClassImage * 1.15);
      }
      _heightController.value = _scrollController.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ClassBloc, ClassState>(
      listener: (context, state) {
        if (state is GetClassesDone) {
          int index = (state.props[0] as List<ClassModel>).indexWhere(
            (item) => item.id == widget.classModel.id,
          );
          if (index != -1) {
            setState(() {
              _hasJoinedClass = true;
              _classModel = state.props[0][index];
            });
          }
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        endDrawer: Container(
          width: 60.w,
          child: Drawer(
            child: DrawerOption(
              classModel: _classModel,
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              height: 100.h,
              width: 100.w,
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        AnimatedFade(
                          animation: Tween(begin: 1.0, end: 0.0).animate(_imageController),
                          child: Container(
                            height: _heightOfClassImage,
                            width: 100.w,
                            child: BlurHash(
                              hash: _classModel.blurHash,
                              image: _classModel.image,
                              imageFit: BoxFit.cover,
                              color: colorPrimary,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 35.sp,
                          left: 0,
                          right: 0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  AppNavigator.pop();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(9.25.sp),
                                  margin: EdgeInsets.only(left: 10.sp),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(.15),
                                    borderRadius: BorderRadius.circular(8.sp),
                                  ),
                                  child: Icon(
                                    PhosphorIcons.arrowLeftBold,
                                    size: 18.sp,
                                    color: mC,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (widget.classModel.status != 1) {
                                    GetSnackBar getSnackBar = GetSnackBar(
                                      title: 'Không thể xem các lựa chọn',
                                      subTitle: 'Lớp chưa được hệ thống phê duyệt để hoạt động!',
                                    );
                                    getSnackBar.show();
                                    return;
                                  }
                                  if (RoleHelper().canShowDrawerClass(
                                    widget.classModel.members,
                                    widget.classModel.createdBy!.id,
                                  )) {
                                    _scaffoldKey.currentState!.openEndDrawer();
                                  } else {
                                    GetSnackBar getSnackBar = GetSnackBar(
                                      title: 'Không thể xem các lựa chọn',
                                      subTitle: 'Hãy tham gia lớp học, để có thể xem chi tiết',
                                    );
                                    getSnackBar.show();
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(9.25.sp),
                                  margin: EdgeInsets.only(right: 10.sp),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(.15),
                                    borderRadius: BorderRadius.circular(8.sp),
                                  ),
                                  child: Icon(
                                    PhosphorIcons.slidersHorizontal,
                                    size: 18.sp,
                                    color: mC,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.sp),
                    Container(
                      padding: EdgeInsets.only(left: 10.sp, right: 12.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (widget.classModel.createdBy!.id ==
                                  AppBloc.authBloc.userModel!.id) {
                                CustomImagePicker().openImagePicker(
                                  context: context,
                                  text: "Chọn ảnh cho lớp học",
                                  handleFinish: (File image) async {
                                    showDialogLoading(context);
                                    AppBloc.classBloc.add(
                                      UpdateImageClass(
                                        image: image,
                                        id: widget.classModel.id,
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                            child: Container(
                              height: 45.sp,
                              width: 45.sp,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(1000.sp),
                                child: BlurHash(
                                  hash: _classModel.blurHash,
                                  image: _classModel.image,
                                  imageFit: BoxFit.cover,
                                  color: colorPrimary,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 6.sp),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _classModel.name,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontFamily: FontFamily.lato,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 3.sp),
                                Row(
                                  children: [
                                    MembersHelper().getMembers(widget.classModel.members).length ==
                                            0
                                        ? Container()
                                        : StackAvatar(
                                            size: 22.sp,
                                            images: MembersHelper()
                                                .getMembers(widget.classModel.members)
                                                .map((item) => item.image!)
                                                .toList(),
                                            blueHash: MembersHelper()
                                                .getMembers(widget.classModel.members)
                                                .map((item) => item.blurHash!)
                                                .toList(),
                                          ),
                                    SizedBox(
                                      width: _classModel.members.isEmpty ? 2.sp : 6.sp,
                                    ),
                                    Text(
                                      _classModel.members.isEmpty
                                          ? 'Chưa có học viên'
                                          : '${MembersHelper().getMembers(widget.classModel.members).length} học viên',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontFamily: FontFamily.lato,
                                        fontWeight: FontWeight.w400,
                                        color: _classModel.members.isEmpty
                                            ? Theme.of(context).primaryColor
                                            : Theme.of(context).textTheme.bodyLarge!.color!,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: !Application.isProductionMode && !_hasJoinedClass,
                            child: Text(
                              _classModel.price == 0
                                  ? '\$ Free'
                                  : _classModel.price.toInt().toString().formatMoney() + 'đ',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontFamily: FontFamily.lato,
                                fontWeight: FontWeight.w600,
                                color: colorPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.sp),
                    Container(
                      padding: EdgeInsets.only(left: 10.sp, right: 12.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Giới thiệu',
                            style: TextStyle(
                              fontSize: 15.sp,
                              // fontFamily: FontFamily.lato,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10.sp),
                          Text(
                            widget.classModel.intro,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: FontFamily.lato,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.sp),
                    Container(
                      padding: EdgeInsets.only(left: 10.sp, right: 12.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hoạt động',
                            style: TextStyle(
                              fontSize: 15.sp,
                              // fontFamily: FontFamily.lato,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    BlocBuilder<PostClassBloc, PostClassState>(
                      builder: (context, state) {
                        if (state is PostClassInitial) {
                          return PostShimmerList(
                            isShowNewPost: false,
                          );
                        }

                        List<PostModel> posts = (state.props[0] as List).cast();
                        return ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.only(
                            bottom: 80.sp,
                          ),
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: posts.length,
                          itemBuilder: (context, index) {
                            return PostCard(
                              post: posts[index],
                              isLast: index == posts.length,
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            _hasJoinedClass ? Container() : _buildBottomBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: AppDecoration.containerOnlyShadowTop(context).decoration,
        padding: EdgeInsets.only(bottom: 18.sp, top: 8.sp),
        child: GestureDetector(
          onTap: () {
            dialogAnimationWrapper(
              context: context,
              slideFrom: 'top',
              child: DialogConfirm(
                handleConfirm: () {
                  showDialogLoading(context);
                  if (Application.isProductionMode || _classModel.price == 0) {
                    AppBloc.classBloc.add(
                      JoinClass(
                        classId: widget.classModel.id,
                        context: context,
                        senderPhone: '0000',
                        amount: _classModel.price,
                      ),
                    );
                  } else {
                    MomoAppPayment().handlePaymentMomo(
                      amount: _classModel.price.toInt(),
                      handleFinished: (PaymentResponse response) {
                        AppBloc.classBloc.add(
                          JoinClass(
                            classId: widget.classModel.id,
                            context: context,
                            senderPhone: response.phoneNumber ?? '0000',
                            amount: _classModel.price,
                          ),
                        );
                      },
                    );
                  }
                },
                subTitle: 'Sau khi tham gia, bạn sẽ trở thành học viên của lớp học này.',
                title: 'Tham gia lớp học',
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.sp),
            height: 42.sp,
            decoration: BoxDecoration(
              color: colorPrimary,
              borderRadius: BorderRadius.circular(8.sp),
            ),
            alignment: Alignment.center,
            child: Text(
              'Tham gia ngay',
              style: TextStyle(
                color: mC,
                fontFamily: FontFamily.lato,
                fontSize: 12.75.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
