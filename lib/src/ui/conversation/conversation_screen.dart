import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/blocs/message/message_bloc.dart';
import 'package:cloudmate/src/helpers/date_time_helper.dart';
import 'package:cloudmate/src/models/conversation_model.dart';
import 'package:cloudmate/src/models/message_model.dart';
import 'package:cloudmate/src/services/socket/socket_emit.dart';
import 'package:cloudmate/src/themes/app_colors.dart';
import 'package:cloudmate/src/themes/font_family.dart';
import 'package:cloudmate/src/ui/common/screens/loading_screen.dart';
import 'package:cloudmate/src/ui/conversation/widgets/input_message.dart';
import 'package:cloudmate/src/ui/conversation/widgets/message_conversation_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:cloudmate/src/utils/sizer_custom/sizer.dart';

class ConversationScreen extends StatefulWidget {
  final ConversationModel conversation;
  ConversationScreen({
    required this.conversation,
  });
  @override
  State<StatefulWidget> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    AppBloc.messageBloc.add(OnMessageEvent(conversation: widget.conversation));

    _scrollController.addListener(
      () {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 2.sp) {
          AppBloc.messageBloc.add(GetMessageEvent());
        }
      },
    );
  }

  @override
  void dispose() {
    SocketEmit().leaveRoomChat(idConversation: widget.conversation.id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => true,
      child: GestureDetector(
        onTap: () {},
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: mC,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarBrightness: Theme.of(context).brightness,
            ),
            toolbarHeight: _size.width * .16,
            elevation: 2.0,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                PhosphorIcons.caretLeft,
                size: _size.width / 15.0,
                color: Colors.black,
              ),
            ),
            title: Row(
              children: [
                Container(
                  height: _size.width * .1,
                  width: _size.width * .1,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(widget.conversation.idClass.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.conversation.idClass.name,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: FontFamily.lato,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                      SizedBox(height: 2.5),
                      Text(
                        widget.conversation.idClass.intro,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: _size.width / 30.0,
                              fontWeight: FontWeight.w400,
                              fontFamily: FontFamily.lato,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: GestureDetector(
            onTap: () {
              if (FocusScope.of(context).hasFocus) {
                FocusScope.of(context).unfocus();
              }
            },
            child: Container(
              child: Column(
                children: [
                  Expanded(
                    child: BlocBuilder<MessageBloc, MessageState>(
                      builder: (context, state) {
                        if (state is MessageInitial) {
                          return LoadingScreen();
                        }

                        List<MessageModel> messages = (state.props[0] as List).cast();

                        return ListView.builder(
                          controller: _scrollController,
                          reverse: true,
                          shrinkWrap: true,
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            return MessageConversationCard(
                              messageModel: messages[index],
                              conversationModel: widget.conversation,
                              isShowAvatar: index == messages.length - 1 ||
                                  (!messages[index].isMe &&
                                      (messages[index + 1].isMe ||
                                          isShowTime(
                                              messages[index].createdAt,
                                              (index < messages.length - 1
                                                      ? messages[index + 1]
                                                      : null)!
                                                  .createdAt))),
                              prevModel: index < messages.length - 1 ? messages[index + 1] : null,
                              nextModel: index > 0 ? messages[index - 1] : null,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  // Chat Input Below Here
                  Divider(
                    height: .25,
                    thickness: .25,
                    color: colorDarkGrey,
                  ),
                  InputMessage(conversationId: widget.conversation.id),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
