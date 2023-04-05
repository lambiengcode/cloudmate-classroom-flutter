import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/helpers/members_helpers.dart';
import 'package:cloudmate/src/models/class_model.dart';
import 'package:cloudmate/src/models/user.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:cloudmate/src/ui/classes/blocs/class/class_bloc.dart';
import 'package:cloudmate/src/ui/classes/widgets/user_request_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class MembersScreen extends StatefulWidget {
  final ClassModel classModel;
  MembersScreen({required this.classModel});
  @override
  State<StatefulWidget> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  @override
  void initState() {
    super.initState();
    AppBloc.classBloc.add(GetMemberClass(classId: widget.classModel.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        systemOverlayStyle: ThemeService.systemBrightness,
        centerTitle: true,
        elevation: .0,
        leading: IconButton(
          onPressed: () => AppNavigator.pop(),
          icon: Icon(
            PhosphorIcons.caretLeft,
            size: 20.sp,
          ),
        ),
        title: Text(
          'Thành viên',
          style: TextStyle(
            fontSize: 15.sp,
            fontFamily: FontFamily.lato,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
      ),
      body: BlocBuilder<ClassBloc, ClassState>(
        builder: (context, state) {
          List<ClassModel> listClass = state.props[0];
          int indexMyClass = listClass.indexWhere((element) => element.id == widget.classModel.id);
          List<UserModel> members = MembersHelper().getMembers(listClass[indexMyClass].members);

          return Container(
            child: Column(
              children: [
                SizedBox(height: 2.5.sp),
                Divider(
                  height: .25,
                  thickness: .25,
                ),
                SizedBox(height: 6.sp),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(bottom: 16.sp),
                    physics: BouncingScrollPhysics(),
                    itemCount: members.length,
                    itemBuilder: (context, index) {
                      return UserRequestCard(
                        user: members[index],
                        isLast: index == members.length - 1,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
