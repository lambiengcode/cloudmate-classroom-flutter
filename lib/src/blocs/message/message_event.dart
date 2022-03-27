part of 'message_bloc.dart';

@immutable
abstract class MessageEvent {}

class OnMessageEvent extends MessageEvent {
  final ConversationModel conversation;
  OnMessageEvent({required this.conversation});
}

class GetMessageEvent extends MessageEvent {}

class SendMessageEvent extends MessageEvent {
  final String message;
  SendMessageEvent({required this.message});
}

class InsertMessageEvent extends MessageEvent {
  final MessageModel message;
  InsertMessageEvent({required this.message});
}
