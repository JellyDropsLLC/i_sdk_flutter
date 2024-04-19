// ignore_for_file: constant_identifier_names
import 'i_sdk.dart';

class Intent {
  static const String INTENT_MESSAGE_ID_INIT = "init";
  static const String INTENT_MESSAGE_ID_CREATE_CONVERSATION = "createConversation";
  static const String INTENT_MESSAGE_ID_SENG_MESSAGE = "sendMessage";
  static const String INTENT_MESSAGE_ID_CALL_RESULT = "toolCallsResult";
  static const String INTENT_MESSAGE_ID_WAITING = "waiting";
  static const String INTENT_MESSAGE_ID_RESPONSE = "response";

  static const String INTENT_TYPE_TEXT = "text";
  static const String INTENT_TYPE_FUNCTION = "function";

  static const STATUS_INIT = "init";
  static const STATUS_DOING = "doing";
  static const STATUS_DONE = "done";

  static const STREAM_STATUS_END = "end";
  static const STREAM_STATUS_START = "start";

  late String conversationId;
  String? messageId;
  String? assistant;
  String? response;
  String? user;
  String functionName = "";
  String functionArgs = "";
  dynamic data;
  String status = STATUS_INIT;
  String streamStatus = "";
  String type = "";
  late IntentResult result;
  late DateTime createTime;
  Intent.fromMap(Map info) {
    createTime = DateTime.now();
    messageId = info['messageId'];
    conversationId = "${info['conversationId'] ?? ""}";
    assistant = info['assistant'];
    response = info['response'];
    user = info['user'];
    type = info["type"] ?? "";
    streamStatus = "${info['streamStatus'] ?? ""}";
    functionName = "${info['functionName'] ?? ''}";
    if (functionName.isEmpty) {
      for (var e in ISDK.instance.customIntents) {
        if (assistant?.contains(e) == true) {
          functionName = e;
          break;
        }
      }
    }
    functionArgs = "${info['functionArgs'] ?? ''}";
  }
  Intent.user({required this.conversationId, required this.user}) {
    createTime = DateTime.now();
  }
  Intent.assistant({required this.conversationId, required this.assistant}) {
    messageId = INTENT_MESSAGE_ID_SENG_MESSAGE;
    createTime = DateTime.now();
  }
  Intent.waiting({required this.conversationId}) {
    messageId = INTENT_MESSAGE_ID_WAITING;
    createTime = DateTime.now();
  }
  Intent.response({required this.conversationId, required this.response, this.data}) {
    messageId = INTENT_MESSAGE_ID_RESPONSE;
    createTime = DateTime.now();
  }
  void doing() => status = Intent.STATUS_DOING;
  void done({IntentResult result = const IntentResult(data: null, isSuccess: true)}) {
    status = Intent.STATUS_DONE;
    this.result = result;
    ISDK.instance.sendMessage(
      conversationId,
      "Completed",
      addToConversation: false,
      messageId: Intent.INTENT_MESSAGE_ID_CALL_RESULT,
    );
  }

  void success<T>({T? result}) => done(result: IntentResult(data: result, isSuccess: true));
  void fail<T>({T? result}) => done(result: IntentResult(data: result, isSuccess: false));

  @override
  String toString() {
    return "Intent:[messageId:$messageId,conversationId:$conversationId,assistant:$assistant,user:$user,functionName:$functionName]";
  }
}

class IntentResult<T> {
  final T data;
  final bool isSuccess;

  const IntentResult({required this.data, required this.isSuccess});
}
