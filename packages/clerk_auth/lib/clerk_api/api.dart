import 'dart:async';
import 'dart:convert';
import 'dart:io' show HttpStatus, HttpHeaders;

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'models/models.dart';
import 'token_cache.dart';

enum HttpMethod {
  get,
  post,
  put,
  patch,
  delete;

  bool get isGet => this == get;
  bool get isNotGet => isGet == false;

  @override
  String toString() => name.toUpperCase();
}

class Api {
  Api._({required this.tokenCache, required this.domain});

  factory Api({
    required String publishableKey,
    required String publicKey,
  }) =>
      _instance ??= Api._(
        tokenCache: TokenCache(publicKey),
        domain: deriveDomainFrom(publishableKey),
      );

  final TokenCache tokenCache;
  final String domain;

  final logger = Logger();

  static final _client = http.Client();
  static Api? _instance;

  static const _apiVersion = 'v1';
  static const _scheme = 'https';
  static const _kJwtKey = 'jwt';
  static const _kIsNative = '_is_native';
  static const _kClerkJsVersion = '_clerk_js_version';
  static const _vClerkJsVersion = '4.70.0';

  // Sign out

  Future<void> signOut() async {
    await _fetchApiResponse('/client', method: HttpMethod.delete);
    tokenCache.clear();
  }

  // Sign Up API

  Future<ApiResponse> createSignUp() async => _fetchApiResponse('/client/sign_ups');

  // Sign In API

  Future<ApiResponse> createSignIn({
    required String identifier,
  }) async =>
      _fetchApiResponse(
        '/client/sign_ins',
        params: {'identifier': identifier},
      );

  Future<ApiResponse> prepareVerification({
    required String id,
    required FactorStage stage,
    required Strategy strategy,
    String? emailAddressId,
    String? phoneNumberId,
  }) async {
    return _fetchApiResponse(
      '/client/sign_ins/$id/prepare_${stage}_factor',
      params: {
        'strategy': strategy,
        if (emailAddressId?.isNotEmpty == true) 'email_address_id': emailAddressId,
        if (phoneNumberId?.isNotEmpty == true) 'phone_number_id': phoneNumberId,
      },
    );
  }

  Future<ApiResponse> attemptVerification({
    required String id,
    required FactorStage stage,
    required Strategy strategy,
    String? code,
    String? password,
  }) async {
    return _fetchApiResponse(
      '/client/sign_ins/$id/attempt_${stage}_factor',
      params: {
        'strategy': strategy,
        if (code is String) 'code': code,
        if (password is String) 'password': password,
      },
    );
  }

  // Session

  Future<String> sessionToken() async {
    if (tokenCache.sessionToken.isEmpty && tokenCache.canRefreshSessionToken) {
      final resp = await _fetch(url: '/client/sessions/${tokenCache.sessionId}/tokens');
      if (resp.statusCode == HttpStatus.ok) {
        final body = jsonDecode(resp.body) as Map<String, dynamic>;
        tokenCache.sessionToken = body[_kJwtKey] as String;
      }
    }
    return tokenCache.sessionToken;
  }

  // Internal

  Future<ApiResponse> _fetchApiResponse(
    String url, {
    HttpMethod method = HttpMethod.post,
    Map<String, String> headers = const {},
    Map<String, dynamic> params = const {},
  }) async {
    try {
      final resp = await _fetch(
        method: method,
        url: url,
        params: params,
        headers: headers,
      );

      final body = json.decode(resp.body) as Map<String, dynamic>;
      if (body['client'] case Map<String, dynamic> clientJson) {
        switch (resp.statusCode) {
          case 200:
            final client = Client.fromJson(clientJson);
            final response = ApiResponse(client: client, status: resp.statusCode);
            tokenCache.updateFrom(resp, client.activeSession);
            return response;

          case 422: // Clerk-handled error
            logger.e(body.toString());
            final client = Client.fromJson(clientJson);
            return ApiResponse(client: client, status: resp.statusCode);

          default:
            logger.e(body.toString());
            return ApiResponse(status: resp.statusCode);
        }
      } else {
        logger.e('No client json received');
        logger.e(body);
        return ApiResponse(status: HttpStatus.noContent, errorDetail: 'No data received');
      }
    } catch (error, stacktrace) {
      logger.e('$error', stackTrace: stacktrace);
      return ApiResponse(status: HttpStatus.internalServerError, errorDetail: error.toString());
    }
  }

  Future<http.Response> _fetch({
    required String url,
    HttpMethod method = HttpMethod.post,
    Map<String, String> headers = const {},
    Map<String, dynamic> params = const {},
  }) async {
    final query = _queryStringFrom({
      _kIsNative: 'true',
      _kClerkJsVersion: _vClerkJsVersion,
      if (method.isGet) ...params,
    });
    final body = method.isNotGet ? _queryStringFrom(params) : '';
    final authHeaders = _headersFrom(method, headers);
    final uri = Uri(scheme: _scheme, host: domain, path: '$_apiVersion$url', query: query);
    return await _client.sendHttpRequest(method, uri, body: body, headers: authHeaders);
  }

  String _queryStringFrom(Map<String, dynamic> params) =>
      params.entries.map((e) => '${e.key}=${Uri.encodeComponent(e.value.toString())}').join('&');

  Map<String, String> _headersFrom(HttpMethod method, Map<String, String> headers) => {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader:
            method.isGet ? 'application/json' : 'application/x-www-form-urlencoded',
        if (tokenCache.clientToken.isNotEmpty) //
          HttpHeaders.authorizationHeader: tokenCache.clientToken,
        ...headers,
      };

  static String deriveDomainFrom(String key) {
    final underscoreIndex = key.lastIndexOf('_') + 1;
    if (underscoreIndex < 1) {
      throw FormatException('Public key not in correct format');
    }

    final paddingIndex = key.indexOf('=', underscoreIndex);
    String encodedPart = key.substring(underscoreIndex, paddingIndex > 0 ? paddingIndex : null);
    final overBy = encodedPart.length % 4;
    if (overBy > 0) {
      encodedPart = encodedPart.padRight(encodedPart.length + 4 - overBy, '=');
    }
    final encodedDomain = utf8.decode(base64.decode(encodedPart));
    return encodedDomain.split('\$').first;
  }
}

extension SendExtension on http.Client {
  Future<http.Response> sendHttpRequest(
    HttpMethod method,
    Uri uri, {
    Map<String, String> headers = const {},
    String? body,
  }) async {
    final request = http.Request(method.toString(), uri)
      ..headers.addAll(headers)
      ..body = body ?? '';
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    return response;
  }
}
