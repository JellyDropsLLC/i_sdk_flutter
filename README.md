# i_sdk_flutter

iSDK flutter Version

# Introduction

**Project Name:**
Intent-Driven Software Development Kit

**Project Description:**
Initially in any document or presentation, write: "Intent-Driven Software Development Kit (iSDK)," and then just refer to it as "iSDK" throughout the rest of the text. iSDK is an open-source, innovative software development kit advocated by Jelly Drops LLC. Its core technology leverages AI to facilitate interaction between humans and machines, driving the invocation of foundational components in target application software projects through understanding human intentions. This approach enhances effective human-machine interaction. This groundbreaking software development framework depends entirely on the kit’s public runtime methods and libraries, along with open strategies for third-party custom intent, thereby enhancing its versatility. The intent-driven development paradigm holds the potential to transform the current software development industry.


**Feature Highlights:**

iSDK empowers existing application development enterprises to seamlessly integrate AI technology and AI-based intent-interaction models into their current software development practices. This integration includes, but is not limited to, direct communication with users via text and voice, enabling interactions with software or hardware that are as natural as human-to-human conversations. iSDK offers the following interaction modalities:

**Human-like Communication Capabilities:** iSDK leverages advanced AI technology to facilitate information exchanges between humans and software or hardware devices, adding new layers to traditional human-computer interaction methods such as keyboards, mice, and touchscreens. This makes the interaction between humans and machines simpler and more intuitive.

**Intent Understanding:** At the core of our SDK is the capability to communicate with humans through AI to decipher human intentions. These intentions are translated into software code or hardware device commands, coordinating components to fulfill user needs, thereby bridging the gap between humans and machines. This enhancement shortens the communicative distance between humans and machines, warming up what traditionally has been a cold interaction.

**Automated Component Invocation:** Once AI understands human intentions, it can express or orchestrate the working modes of existing software or device components in multiple ways. If a third party prefers traditional interaction modes, iSDK can facilitate this through direct traditional function calls to execute software functions. For those leaning towards automation, iSDK enhances efficiency and accuracy by automatically invoking the fundamental execution modules of the software or hardware, fulfilling user requirements.

**Modular Development Support:** iSDK supports the construction of modular applications through common runtime methods and libraries, making the development process more flexible and scalable.

**Custom Intent by Third Parties:** Our open strategy allows third-party enterprises to customize intents, theoretically enabling iSDK to meet the development needs of software or devices across all industries.


**Tech Stack and Implementation Guide:**

This project is developed using the Flutter technology stack, enabling cross-platform collaboration to ensure efficient and consistent mobile development. The integration and compilation processes are streamlined and straightforward.

Usage Examples:
The following code snippet should be added to your package's pubspec.yaml file to include the i_sdk_flutter dependency, which automatically triggers an implicit flutter pub get:

```yaml
dependencies:
  i_sdk_flutter:
    git:
      url: https://github.com/JellyDropsLLC/i_sdk_flutter.git
      ref: main
```

Alternatively, your editor might support flutter pub get directly. Check the documentation for your editor to learn more.

Now in your Dart code, you can use:

```dart
import 'package:i_sdk_flutter/i_sdk_flutter.dart';
```


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

We warmly welcome personal software developers to actively participate in the expansion of iSDK and join us in pushing the boundaries of technological advancement. Currently, we are especially seeking to expand our development support for the following platforms:
- Windows
- Linux
- macOS
- Java
- Node.js
- JavaScript

Please email us at: aicreator@jellydropsllc.com

Join our community:
Twitter: Follow our Twitter account to stay updated with the latest tech news. [Follow us on Twitter](https://twitter.com/JellyDropsLLC)

