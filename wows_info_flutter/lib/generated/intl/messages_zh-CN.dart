// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_CN locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh_CN';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "api_server": MessageLookupByLibrary.simpleMessage("游戏服务器"),
        "api_server_asia": MessageLookupByLibrary.simpleMessage("亚服"),
        "api_server_eu": MessageLookupByLibrary.simpleMessage("欧服"),
        "api_server_na": MessageLookupByLibrary.simpleMessage("美服"),
        "api_server_ru": MessageLookupByLibrary.simpleMessage("毛服"),
        "app_title": MessageLookupByLibrary.simpleMessage("WOWS Flutter")
      };
}
