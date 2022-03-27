import 'package:bloc/bloc.dart';
import 'package:cloudmate/src/models/conversation_model.dart';
import 'package:cloudmate/src/models/message_model.dart';
import 'package:cloudmate/src/resources/remote/conversation_repository.dart';
import 'package:meta/meta.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  ConversationBloc() : super(ConversationInitial());

  List<ConversationModel> conversations = [];
  bool isOver = false;

  @override
  Stream<ConversationState> mapEventToState(ConversationEvent event) async* {
    if (event is OnConversationEvent) {
      conversations.clear();
      if (conversations.isEmpty) {
        yield ConversationInitial();
        await _getConversations();
      }
      yield _getDoneConversation;
    }

    if (event is GetConversationEvent) {
      if (!isOver) {
        yield _gettingConversation;
        await _getConversations();
        yield _getDoneConversation;
      }
    }

    if (event is UpdateLatestMessageEvent) {
      int indexOfConversation =
          conversations.indexWhere((element) => element.idClass.id == event.message.idClass);

      if (indexOfConversation != -1) {
        conversations[indexOfConversation].latestMessage =
            LatestMessage.fromMessageModel(event.message);

        yield _getDoneConversation;
      }
    }
  }

  // MARK: Private methods
  GettingConversation get _gettingConversation => GettingConversation(conversations: conversations);
  GetDoneConversation get _getDoneConversation => GetDoneConversation(conversations: conversations);

  Future<void> _getConversations() async {
    List<ConversationModel> _conversations = await ConversationRepository().getListClasses(
      skip: conversations.length,
    );

    if (_conversations.length < 10) {
      isOver = true;
    }

    conversations.addAll(_conversations);
  }
}
