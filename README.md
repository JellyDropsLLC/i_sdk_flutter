# i_sdk_flutter

iSDK flutter Version

# Introduction
    With the launch of the latest NLP (Natural Language Processing) models, the interaction between humans and machines has undergone a revolution, as these models directly capture human expectations and needs of machines. Although this advanced technology has not yet been widely applied in personal computers, mobile devices, or embedded applications, the most typical use case currently is chatbots, making the expansion of NLP in traditional software development a hot topic of research and development in the industry.

Coeus's iSDK is one of the solutions that utilize NLP and other AI models for human-machine interaction. This solution employs AI to recognize user intents and converts them into standard formats like JSON that applications can understand, injecting new vitality into traditional software development. With iSDK, traditional development teams no longer need to spend extra time and effort selecting different AI models and platforms; instead, they can focus on business logic and innovative UI design. iSDK empowers developers to create dynamic, novel interactive application interfaces, allowing users to interact with machines through natural language, text, or even lip and gesture, paving the way for the use of cutting-edge interaction technologies.


# Initialize SDK

```dart
Future<bool> init({required String key, required String secret})
```

<table border="1">
  <thead>
    <tr>
      <th>Parameter</th>
      <th>Type</th>
      <th>Required</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>key</td>
      <td>String</td>
      <td>YES</td>
    </tr>
    <tr>
      <td>secret</td>
      <td>String</td>
      <td>YES</td>
    </tr>
  </tbody>
</table>

# Establish Session

```dart
Future<Conversation> createConversation() 
```

<table border="1">
  <thead>
    <tr>
      <th>Parameter</th>
      <th>Type</th>
      <th>Required</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>None</td>
    </tr>

  </tbody>
</table>

# Send Message


```dart
Future sendMessage(String conversationId, String message, {bool addToConversation = true})
```

<table border="1">
  <thead>
    <tr>
      <th>Parameter</th>
      <th>Type</th>
      <th>Required</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>conversationId</td>
      <td>String</td>
      <td>YES</td>
    </tr>
    <tr>
      <td>content</td>
      <td>String</td>
      <td>YES</td>
    </tr>
  </tbody>
</table>

# Subscribe to Session Message Changes

```dart
ISDK.instance.conversationChangedStream.listen((conversation) {});
```


# Read Session Messages (TBD)
# Clear Session Messages (TBD)
