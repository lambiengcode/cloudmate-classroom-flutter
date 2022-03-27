import 'package:bloc/bloc.dart';
import 'package:cloudmate/src/blocs/app_bloc.dart';
import 'package:cloudmate/src/blocs/conversation/conversation_bloc.dart';
import 'package:cloudmate/src/models/conversation_model.dart';
import 'package:cloudmate/src/models/message_model.dart';
import 'package:cloudmate/src/resources/remote/message_repository.dart';
import 'package:cloudmate/src/services/socket/socket_emit.dart';
import 'package:meta/meta.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc() : super(MessageInitial());

  ConversationModel? currentConversation;
  List<MessageModel> messages = [];
  bool isOver = false;

  @override
  Stream<MessageState> mapEventToState(MessageEvent event) async* {
    if (event is OnMessageEvent) {
      yield MessageInitial();
      isOver = false;
      messages = [];
      currentConversation = event.conversation;
      SocketEmit().joinRoomChat(idConversation: event.conversation.idClass.id);
      await _getMessage();
      yield _getDoneMessage;
    }

    if (event is GetMessageEvent) {
      if (!isOver) {
        yield _gettingMessage;
        await _getMessage();
        yield _getDoneMessage;
      }
    }

    if (event is SendMessageEvent) {
      await _sendMessage(event);
      yield _getDoneMessage;
    }

    if (event is InsertMessageEvent) {
      if (event.message.idClass == currentConversation?.idClass.id &&
          event.message.sender.id != AppBloc.authBloc.userModel!.id) {
        int indexOfMessage = messages.indexWhere((msg) => msg.id == event.message.id);

        if (indexOfMessage == -1) {
          messages.insert(0, event.message);
          AppBloc.conversationBloc.add(UpdateLatestMessageEvent(message: event.message));
          yield _getDoneMessage;
        }
      } else {
        // Show notification
      }
    }
  }

  // MARK: Private methods
  GettingMessage get _gettingMessage => GettingMessage(messages: messages);
  GetDoneMessage get _getDoneMessage => GetDoneMessage(messages: messages);

  Future<void> _getMessage() async {
    List<MessageModel> _messages = await MessageRepository().getMessages(
      classId: currentConversation!.idClass.id,
      skip: messages.length,
    );

    if (_messages.length < 15) {
      isOver = true;
    }

    messages.addAll(_messages);
  }

  Future<void> _sendMessage(SendMessageEvent event) async {
    MessageModel? message = await MessageRepository().createMessage(
      idClass: currentConversation!.idClass.id,
      message: event.message,
    );

    if (message != null) {
      messages.insert(0, message);
      SocketEmit().sendMessage(
        conversationId: currentConversation!.idClass.id,
        messageId: message.id,
      );

      AppBloc.conversationBloc.add(UpdateLatestMessageEvent(message: message));
    }
  }
}
