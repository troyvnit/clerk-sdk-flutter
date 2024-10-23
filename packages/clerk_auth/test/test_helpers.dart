import 'dart:async';

import 'package:common/common.dart';

class TestEnv {
  final _map = <String, String>{};

  void addAll(Map<String, String> map) => _map.addAll(map);

  String get email => _map['email'] ?? '';
  String get phoneNumber => _map['phone_number'] ?? '';
  String get password => _map['password'] ?? '';
  String get code => _map['code'] ?? '';
  String get publicKey => _map['public_key']?.replaceAll('\\n', '\n') ?? '';
  String get publishableKey => _map['publishable_key'] ?? '';
}

class TestLogPrinter extends Printer {
  @override
  void print(String output) {
    Zone.root.print(output);
  }
}
