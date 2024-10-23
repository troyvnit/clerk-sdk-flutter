import 'dart:convert';

import 'package:clerk_auth/clerk_api/clerk_api.dart';
import 'package:common/common.dart';
import 'package:dart_dotenv/dart_dotenv.dart';
import 'package:test/test.dart';

import '../../test_helpers.dart';

void main() {
  late final Api api;

  final env = TestEnv();

  setUpAll(() async {
    final dotEnv = DotEnv(filePath: '.env.test');
    final values = dotEnv.getDotEnv();
    env.addAll(values);

    api = Api(publicKey: env.publicKey, publishableKey: env.publishableKey);

    await setUpLogging(printer: TestLogPrinter());
  });

  group('Environment:', () {
    test('can fetch', () async {
      await runWithLogging(() async {
        final data = await api.environment();
        print(jsonEncode(data.toJson()));
        expect(data.isEmpty, false);
      });
    });
  });
}
