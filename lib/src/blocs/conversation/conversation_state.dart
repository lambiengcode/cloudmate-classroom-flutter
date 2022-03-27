part of 'conversation_bloc.dart';

@immutable
abstract class ConversationState {
  List get props => [];
}

class ConversationInitial extends ConversationState {}

class GettingConversation extends ConversationState {
  final List<ConversationModel> conversations;
  GettingConversation({required this.conversations});

  @override
  List get props => [conversations];
}

class GetDoneConversation extends ConversationState {
  final List<ConversationModel> conversations;
  GetDoneConversation({required this.conversations});

  @override
  List get props => [conversations];
}
