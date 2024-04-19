// ignore_for_file: constant_identifier_names
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart' hide Intent;
import 'package:qm_net/qm_net.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'conversation.dart';
import 'intent.dart';

class ISDK {
  ISDK._();
  static ISDK? _instance;
  static ISDK get instance {
    _instance ??= ISDK._();
    return _instance!;
  }

  factory ISDK() => instance;

  late final StreamController<Conversation> conversationChangedController = StreamController.broadcast();
  Stream<Conversation> get conversationChangedStream => conversationChangedController.stream.asBroadcastStream();
  late final StreamController<Conversation> conversationCreatedController = StreamController.broadcast();
  Stream<Conversation> get conversationCreatedStream => conversationCreatedController.stream.asBroadcastStream();

  String _key = "", _secret = "", _token = "";
  WebSocketChannel? _messageChannel;
  List<String> _customIntents = [];
  set customIntents(val) {
    _customIntents = val;
  }

  List<String> get customIntents => _customIntents;

  ///
  Future<bool> init({required String key, required String secret}) async {
    _key = key;
    _secret = secret;
    Resp resp = await Net.post("http://116.213.39.234:8088/", params: {
      "messageId": Intent.INTENT_MESSAGE_ID_INIT,
      "key": key,
      "secret": secret,
    });
    _token = resp.data?["token"] ?? "";
    debugPrint("resp:${resp.data}");
    debugPrint("resp:${resp.data?["token"]}");
    return _token.isNotEmpty;
  }

  final Map<String, Conversation> _conversationCache = {};
  final List<Conversation> _conversationList = [];
  List<Conversation> get conversations => _conversationList;

  ///
  Future<Conversation> createConversation() async {
    Completer<Conversation> completer = Completer();
    String wsPath = 'ws://116.213.39.234:8088/ws/$_token';
    debugPrint("wsPath:$wsPath");
    _messageChannel = WebSocketChannel.connect(Uri.parse(wsPath));
    await _messageChannel?.ready;
    _messageChannel?.stream.listen((event) {
      try {
        debugPrint("message:$event");
        Map msgInfo = json.decode(event);
        String conversationId = msgInfo["conversationId"] ?? "";
        String messageId = msgInfo["messageId"] ?? "";
        if (messageId == Intent.INTENT_MESSAGE_ID_CREATE_CONVERSATION) {
          Conversation conversation = Conversation(conversationId);
          _conversationCache[wsPath] = conversation;
          _conversationList.add(conversation);
          conversationCreatedController.sink.add(conversation);
          completer.complete(conversation);
        }
        if (messageId == Intent.INTENT_MESSAGE_ID_SENG_MESSAGE) {
          Conversation conversation = Conversation(conversationId);
          Intent intent = Intent.fromMap(msgInfo);
          if (intent.type == Intent.INTENT_TYPE_FUNCTION) {
            conversation.addIntent(intent, false);
          }
          if (intent.type == Intent.INTENT_TYPE_TEXT) {
            if (intent.streamStatus == Intent.STREAM_STATUS_START) {
              conversation.addIntent(intent, false);
            }
            if (intent.streamStatus == Intent.STREAM_STATUS_END) {
              conversation.firstStreamReceivingIntent?.streamStatus = Intent.STREAM_STATUS_END;
              ISDK.instance.conversationChangedController.sink.add(conversation);
            }
          }
        }
      } catch (e) {
        Conversation? conversation = _conversationCache[wsPath];
        if (conversation != null && conversation.firstStreamReceivingIntent?.streamStatus == Intent.STREAM_STATUS_START) {
          conversation.firstStreamReceivingIntent?.assistant = "${conversation.firstStreamReceivingIntent!.assistant ?? ''}$event";
          ISDK.instance.conversationChangedController.sink.add(conversation);
        } else {
          debugPrint("didGetMessage ERROR:$e");
        }
      }
    });

    var params = {
      "messageId": Intent.INTENT_MESSAGE_ID_CREATE_CONVERSATION,
      "key": _key,
    };
    String msg = json.encode(params);
    debugPrint("MSG:$msg");
    _messageChannel?.sink.add(msg);
    return completer.future;
  }

  ///
  Future sendMessage(
    String conversationId,
    String message, {
    bool addToConversation = true,
    String messageId = Intent.INTENT_MESSAGE_ID_SENG_MESSAGE,
  }) async {
    var params = {
      "conversationId": conversationId,
      "messageId": messageId,
      "content": message,
      "key": _key,
    };
    debugPrint("sendMessage:$params");
    if (addToConversation) {
      Intent intent = Intent.user(conversationId: conversationId, user: message);
      Conversation conversation = Conversation(conversationId);
      conversation.addIntent(intent, true);
    }
    _messageChannel?.sink.add(json.encode(params));
  }
}
