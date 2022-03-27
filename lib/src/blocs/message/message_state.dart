part of 'message_bloc.dart';

@immutable
abstract class MessageState {
  List get props => [];
}

class MessageInitial extends MessageState {}

class GettingMessage extends MessageState {
  final List<MessageModel> messages;
  GettingMessage({required this.messages});

  @override
  List get props => [messages];
}

class GetDoneMessage extends MessageState {
  final List<MessageModel> messages;
  GetDoneMessage({required this.messages});

  @override
  List get props => [messages];
}
