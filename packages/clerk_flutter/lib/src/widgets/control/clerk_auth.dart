import 'dart:async';

import 'package:clerk_auth/clerk_auth.dart' as Clerk;
import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Control widget initialising Clerk Auth system
class ClerkAuth extends StatefulWidget {
  /// Clerk public key from dashboard
  final String? publicKey;

  /// Clerk publishable key from dashboard
  final String? publishableKey;

  /// Persistence service for caching tokens
  final Clerk.Persistor? persistor;

  /// Injectable translations for strings
  final ClerkTranslator translator;

  /// child widget tree
  final Widget child;

  /// Loading widget
  final Widget? loading;

  /// auth instance from elsewhere
  final ClerkAuthProvider? auth;

  /// Constructor that constructs a construct constructingly
  const ClerkAuth({
    super.key,
    required this.child,
    this.publicKey,
    this.publishableKey,
    this.auth,
    this.translator = const DefaultClerkTranslator(),
    this.persistor,
    this.loading,
  })  : assert(
          (publicKey is String) != (auth is ClerkAuthProvider),
          'Either publicKey or an auth instance must be provided, but not both',
        ),
        assert(
          (publicKey is String) == (publishableKey is String),
          'Both publicKey and publishableKey must be provided, or neither',
        );

  @override
  State<ClerkAuth> createState() => _ClerkAuthState();

  static ClerkAuthProvider of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<_ClerkAuthData>();
    assert(result != null, 'No Clerk `Auth` found in context');
    return result!.auth;
  }

  static Clerk.User? userOf(BuildContext context) => of(context).user;
  static Clerk.Session? sessionOf(BuildContext context) => of(context).session;

  static ClerkAuthProvider nonDependentOf(BuildContext context) {
    final result = context.findAncestorWidgetOfExactType<_ClerkAuthData>();
    assert(result != null, 'No Clerk `Auth` found in context');
    return result!.auth;
  }

  static ClerkTranslator translatorOf(BuildContext context) => nonDependentOf(context).translator;
  static Clerk.DisplayConfig displayConfigOf(BuildContext context) =>
      nonDependentOf(context).env.display;
  static Stream<Clerk.AuthError> errorStreamOf(BuildContext context) =>
      nonDependentOf(context).errorStream;
}

class _ClerkAuthState extends State<ClerkAuth> {
  late ClerkAuthProvider _auth;
  late Future<ClerkAuthProvider> _authFuture;

  void _update() => setState(() {});

  @override
  void initState() {
    super.initState();
    _auth = widget.auth ??
        ClerkAuthProvider(
          publishableKey: widget.publishableKey!,
          publicKey: widget.publicKey!,
          persistor: widget.persistor,
          translator: widget.translator,
          loading: widget.loading,
        );
    _auth.addListener(_update);
    _authFuture = _auth.init().then((_) => _auth);
  }

  @override
  void dispose() {
    if (widget.auth is ClerkAuthProvider) {
      _auth.removeListener(_update);
    } else {
      _auth.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _authFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _ClerkAuthData(child: widget.child, auth: snapshot.data!);
        }
        return widget.loading ?? emptyWidget;
      },
    );
  }
}

/// Data class holding the auth object
class _ClerkAuthData extends InheritedWidget {
  /// Clerk auth object
  final ClerkAuthProvider auth;
  final Clerk.Client client;
  final Clerk.Environment env;

  _ClerkAuthData({
    required super.child,
    required this.auth,
  })  : this.client = auth.client,
        this.env = auth.env;

  @override
  bool updateShouldNotify(_ClerkAuthData old) => old.client != client || old.env != env;
}

class ClerkAuthProvider extends Clerk.Auth with ChangeNotifier {
  static const _kRotatingTokenNonce = 'rotating_token_nonce';
  static final _lowerCaseRE = RegExp(r'[a-z]');
  static final _upperCaseRE = RegExp(r'[A-Z]');
  static final _numberRE = RegExp(r'[0-9]');

  final ClerkTranslator translator;
  final _errors = StreamController<Clerk.AuthError>();
  late final errorStream = _errors.stream.asBroadcastStream();
  final OverlayEntry loadingOverlay;

  ClerkAuthProvider({
    required super.publicKey,
    required super.publishableKey,
    this.translator = const DefaultClerkTranslator(),
    Widget? loading,
    super.persistor,
  }) : this.loadingOverlay = OverlayEntry(builder: (context) => loading ?? defaultLoadingWidget);

  @override
  void update() => notifyListeners();

  /// Performs SSO authentication according to the `strategy`
  Future<void> sso(
    BuildContext context,
    Clerk.Strategy strategy, {
    void Function(Clerk.AuthError)? onError,
  }) async {
    final auth = ClerkAuth.of(context);
    final client =
        await call(context, () => auth.oauthSignIn(strategy: strategy), onError: onError);
    final url = client?.signIn?.firstFactorVerification?.providerUrl;
    if (url case String url) {
      OverlayEntry? overlay;
      overlay = OverlayEntry(
        builder: (context) {
          final controller = WebViewController()
            ..setUserAgent('Clerk Flutter SDK v${Clerk.Auth.jsVersion}')
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setNavigationDelegate(
              NavigationDelegate(
                onNavigationRequest: (request) async {
                  if (request.url.startsWith(Clerk.Auth.oauthRedirect)) {
                    if (overlay is OverlayEntry) {
                      final uri = Uri.parse(request.url);
                      final token = uri.queryParameters[_kRotatingTokenNonce];
                      if (token case String token) {
                        await call(
                          context,
                          () => auth.attemptSignIn(strategy: strategy, token: token),
                          onError: onError,
                        );
                      } else {
                        await auth.refreshClient();
                        await call(context, () => auth.transfer(), onError: onError);
                      }
                      overlay?.remove();
                      overlay = null;
                    }
                    return NavigationDecision.prevent;
                  }
                  return NavigationDecision.navigate;
                },
              ),
            )
            ..loadRequest(Uri.parse(url));
          return Scaffold(body: WebViewWidget(controller: controller));
        },
      );
      Overlay.of(context).insert(overlay!);
    }
  }

  /// Convenience method to make an auth call to the backend via ClerkAuth
  /// with error handling
  Future<T?> call<T>(
    BuildContext context,
    Future<T> Function() fn, {
    void Function(Clerk.AuthError)? onError,
  }) async {
    T? result;
    try {
      Overlay.of(context).insert(loadingOverlay);
      result = await fn.call();
    } on Clerk.AuthError catch (error) {
      _errors.add(error);
      onError?.call(error);
    } finally {
      loadingOverlay.remove();
    }
    return result;
  }

  /// Returns a boolean regarding whether or not a password has been supplied,
  /// matches a confirmation string and meets the criteria required by `env`
  bool passwordIsValid(String? password, String? confirmation) {
    if (password case String password when password.isNotEmpty) {
      if (password != confirmation) return false;

      final criteria = env.user.passwordSettings;

      if (criteria.requireLowercase && _lowerCaseRE.hasMatch(password) == false) return false;

      if (criteria.requireUppercase && _upperCaseRE.hasMatch(password) == false) return false;

      if (criteria.requireNumbers && _numberRE.hasMatch(password) == false) return false;

      if (criteria.requireSpecialChar) {
        final pRunes = password.runes.toSet();
        final scRunes = criteria.allowedSpecialCharacters.runes.toSet();
        final lacksSpecialChar = pRunes.intersection(scRunes).isEmpty;
        if (lacksSpecialChar) return false;
      }

      return true;
    }

    return false;
  }

  /// Checks the password according to the criteria required by the `env`
  /// Note that password and confirmation must match, but that includes
  /// not having been supplied (i.e. null or empty). These are valid for parsing
  /// but may still not be acceptable to the back end
  String? checkPassword(String? password, String? confirmation) {
    if (password != confirmation) {
      return translator.translate('Password and password confirmation must match');
    }

    if (password case String password when password.isNotEmpty) {
      final criteria = env.user.passwordSettings;
      final missing = <String>[];

      if (criteria.requireLowercase && _lowerCaseRE.hasMatch(password) == false) {
        missing.add('a LOWERCASE letter');
      }

      if (criteria.requireUppercase && _upperCaseRE.hasMatch(password) == false) {
        missing.add('an UPPERCASE letter');
      }

      if (criteria.requireNumbers && _numberRE.hasMatch(password) == false) {
        missing.add('a NUMBER');
      }

      if (criteria.requireSpecialChar) {
        final pRunes = password.runes.toSet();
        final scRunes = criteria.allowedSpecialCharacters.runes.toSet();
        final lacksSpecialChar = pRunes.intersection(scRunes).isEmpty;
        if (lacksSpecialChar) missing.add('a SPECIAL CHARACTER (###)');
      }

      if (missing.isNotEmpty) {
        final value =
            translator.alternatives(missing, connector: 'and', prefix: 'Password requires');
        return value.replaceFirst('###', criteria.allowedSpecialCharacters);
      }
    }

    return null;
  }

  void addError(String message) => _errors.add(Clerk.AuthError(message: message));
}
