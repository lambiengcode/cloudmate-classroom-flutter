part of 'conversation_bloc.dart';

@immutable
abstract class ConversationEvent {}

class OnConversationEvent extends ConversationEvent {}

class GetConversationEvent extends ConversationEvent {}

class UpdateLatestMessageEvent extends ConversationEvent {
  final MessageModel message;
  UpdateLatestMessageEvent({required this.message});
}
