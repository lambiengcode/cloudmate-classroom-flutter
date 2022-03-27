import 'dart:ui';
import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/blocs/conversation/conversation_bloc.dart';
import 'package:cloudmate/src/models/class_model.dart';
import 'package:cloudmate/src/models/conversation_model.dart';
import 'package:cloudmate/src/resources/local/user_local.dart';
import 'package:cloudmate/src/routes/app_pages.dart';
import 'package:cloudmate/src/routes/app_routes.dart';
import 'package:cloudmate/src/themes/theme_service.dart';
import 'package:cloudmate/src/ui/common/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:cloudmate/src/resources/hard/hard_chat.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/ui/chats/widgets/message_card.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    AppBloc.conversationBloc.add(OnConversationEvent());
    print(UserLocal().getAccessToken());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: ThemeService.systemBrightness,
        elevation: .0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text(
          'Message',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1!.color,
            fontFamily: FontFamily.lato,
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => null,
            icon: Icon(
              PhosphorIcons.magnifyingGlass,
              color: Theme.of(context).textTheme.bodyText1!.color,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 2.sp),
          IconButton(
            onPressed: () => null,
            icon: Icon(
              PhosphorIcons.videoCamera,
              color: Theme.of(context).textTheme.bodyText1!.color,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 2.sp),
          IconButton(
            onPressed: () => null,
            icon: Icon(
              Feather.plus_square,
              color: colorPrimary,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 2.sp),
        ],
      ),
      body: Container(
        height: 100.h,
        width: 100.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2.sp),
            Divider(
              height: .35,
              thickness: .35,
            ),
            SizedBox(height: 8.sp),
            Expanded(
              child: BlocBuilder<ConversationBloc, ConversationState>(
                builder: (context, state) {
                  if (state is ConversationInitial) {
                    return LoadingScreen();
                  }

                  List<ConversationModel> conversations = (state.props[0] as List).cast();

                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 12.sp),
                    itemCount: conversations.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              AppNavigator.push(
                                AppRoutes.CONVERSATION,
                                arguments: {
                                  'conversationModel': conversations[index],
                                },
                              );
                            },
                            child: MessageCard(
                              conversation: conversations[index],
                              isLast: index == chats.length,
                            ),
                          )
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildActiveFriend(context) {
  //   final _size = MediaQuery.of(context).size;
  //   return Container(
  //     height: _size.width * .22,
  //     width: _size.width,
  //     child: ListView.builder(
  //       physics: BouncingScrollPhysics(),
  //       padding: EdgeInsets.only(left: 12.sp, right: 8.sp),
  //       scrollDirection: Axis.horizontal,
  //       itemCount: chats.length - 1,
  //       itemBuilder: (context, index) {
  //         return ActiveFriendCard(
  //           urlToImage: chats[index + 1].image,
  //           fullName: chats[index + 1].fullName,
  //           blurHash: chats[index + 1].blurHash,
  //         );
  //       },
  //     ),
  //   );
  // }
}
