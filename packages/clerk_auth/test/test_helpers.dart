// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';

import 'package:clerk_auth/src/clerk_auth/http_service.dart';
import 'package:clerk_auth/src/utils/logging.dart';
import 'package:dart_dotenv/dart_dotenv.dart';
import 'package:http/http.dart' show ByteStream, Response;

class TestEnv {
  TestEnv._(this._map);

  factory TestEnv(String filename) {
    final dotEnv = DotEnv(filePath: filename);
    return TestEnv._(dotEnv.getDotEnv());
  }

  final Map<String, String> _map;

  String get email => _map['email'] ?? '';

  String get phoneNumber => _map['phone_number'] ?? '';

  String get password => _map['password'] ?? '';

  String get code => _map['code'] ?? '';

  String get publishableKey => _map['publishable_key'] ?? '';
}

class TestLogPrinter extends Printer {
  @override
  void print(String output) {
    Zone.root.print(output);
  }
}

class TestHttpService implements HttpService {
  final _expectations = <String, List<Response>>{};

  void reset() => _expectations.clear();

  @override
  Future<void> initialize() async {}

  @override
  void terminate() {}

  @override
  Future<bool> ping(Uri _, {required Duration timeout}) => Future.value(true);

  @override
  Future<Response> send(
    HttpMethod method,
    Uri uri, {
    Map<String, String>? headers,
    Map<String, dynamic>? params,
    String? body,
  }) async {
    final key = _key(method, uri, headers, params);

    if (_expectations[key] case List<Response> resps when resps.isNotEmpty) {
      final resp = resps.removeAt(0);
      return Future.value(resp);
    }
    print('\x1B[31mNO RESPONSE AVAILABLE FOR: $key\x1B[0m');
    throw TestHttpServiceError(message: 'No response available for $key');
  }

  void expect(String key, int status, String body) {
    _expectations[key] ??= [];
    _expectations[key]!.add(Response(body, status));
  }

  bool get isCompleted {
    final remaining =
        _expectations.entries.where((e) => e.value.isNotEmpty).toList();
    for (final exp in remaining) {
      print('\x1B[31mUNUSED CALL: ${exp.value.length} x ${exp.key}\x1B[0m');
    }
    return remaining.isEmpty;
  }

  String _key(
    HttpMethod method,
    Uri uri,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  ) {
    final hdrs = {...?headers}
      ..remove(HttpHeaders.acceptHeader)
      ..remove(HttpHeaders.acceptLanguageHeader)
      ..remove(HttpHeaders.contentTypeHeader)
      ..remove(HttpHeaders.authorizationHeader)
      ..remove('clerk-api-version')
      ..remove('x-flutter-sdk-version')
      ..remove('x-native-device-id')
      ..remove('x-clerk-client-id')
      ..remove('x-mobile');

    final queryParams = {
      ...uri.queryParameters,
      if (uri.queryParameters.containsKey('_clerk_session_id')) //
        '_clerk_session_id': 'SESSION_ID',
    }
      ..remove('_is_native')
      ..remove('_clerk_js_version');

    final path = Uri(
      path: uri.path,
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
    ).toString();

    return [
      method,
      path,
      if (hdrs.isNotEmpty) //
        _mapToString(hdrs),
      if (body?.isNotEmpty == true) //
        _mapToString(body!),
    ].join(' ');
  }

  String _mapToString(Map map) =>
      map.entries.map((me) => '${me.key}=${me.value}').join('&');

  @override
  Future<Response> sendByteStream(
    HttpMethod method,
    Uri uri,
    ByteStream stream,
    int length,
    Map<String, String> headers,
  ) {
    // TODO: add tests for sendFile
    throw UnimplementedError();
  }
}

class TestHttpServiceError extends Error {
  TestHttpServiceError({required this.message});

  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

List<String> testLocalesLookup() => <String>['en'];

const noneHttpService = NoneHttpService();

class NoneHttpService implements HttpService {
  const NoneHttpService();

  @override
  Future<void> initialize() async {}

  @override
  void terminate() {}

  @override
  Future<bool> ping(Uri uri, {required Duration timeout}) => Future.value(true);

  @override
  Future<Response> send(
    HttpMethod method,
    Uri uri, {
    Map<String, String>? headers,
    Map<String, dynamic>? params,
    String? body,
  }) {
    return Future.value(Response('', 200));
  }

  @override
  Future<Response> sendByteStream(
    HttpMethod method,
    Uri uri,
    ByteStream byteStream,
    int length,
    Map<String, String> headers,
  ) {
    return Future.value(Response('', 200));
  }
}
