import 'i_sdk.dart';
import 'intent.dart';

class Conversation {
  late String id;
  late DateTime createTime;
  final List<Intent> _intents = [];
  List<Intent> get intents => _intents;
  // Conversation({required this.id});
  Conversation._(this.id) {
    createTime = DateTime.now();
  }
  static final Map<String, Conversation> _cache = {};
  factory Conversation(String id) {
    Conversation? conversation = _cache[id];
    if (conversation != null) return conversation;
    conversation = Conversation._(id);
    _cache[id] = conversation;
    return conversation;
  }
  Intent? get lastIntent => _intents.isNotEmpty ? _intents.last : null;
  Intent? get lastStreamReceivingIntent {
    if (_intents.isEmpty) return null;
    for (int i = _intents.length - 1; i >= 0; i--) {
      Intent intent = _intents[i];
      if (intent.type == Intent.INTENT_TYPE_TEXT && intent.streamStatus == Intent.STREAM_STATUS_START) {
        return intent;
      }
    }
    return null;
  }

  Intent? get firstStreamReceivingIntent {
    if (_intents.isEmpty) return null;
    for (int i = 0; i < _intents.length; i++) {
      Intent intent = _intents[i];
      if (intent.type == Intent.INTENT_TYPE_TEXT && intent.streamStatus == Intent.STREAM_STATUS_START) {
        return intent;
      }
    }
    return null;
  }

  Intent addIntent(Intent intent, bool waiting) {
    _intents.add(intent);
    if (waiting) {
      _intents.add(Intent.waiting(conversationId: id));
    } else {
      _intents.removeWhere((element) => element.messageId == Intent.INTENT_MESSAGE_ID_WAITING);
    }
    ISDK.instance.conversationChangedController.sink.add(this);
    return intent;
  }

  Intent addUserIntent(String content) => addIntent(Intent.user(conversationId: id, user: content), true);
  Intent addAssistantIntent(String content) => addIntent(Intent.assistant(conversationId: id, assistant: content), false);
  Intent addResponseIntent(String content, {dynamic data}) => addIntent(Intent.response(conversationId: id, response: content, data: data), false);
}
