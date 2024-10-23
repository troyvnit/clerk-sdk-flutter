import 'package:clerk_auth/clerk_auth.dart' as Clerk;
import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// The [ClerkSignInWidget] renders a UI for signing in users.
///
/// The functionality of the [ClerkSignInWidget] is controlled by the instance settings you
/// specify in your Clerk Dashboard, such as sign-in and sign-ip options and social
/// connections. You can further customize you [ClerkSignInWidget] by passing additional
/// properties.

class ClerkSignInWidget extends StatefulWidget {
  const ClerkSignInWidget();

  @override
  State<ClerkSignInWidget> createState() => _ClerkSignInWidgetState();
}

class _ClerkSignInWidgetState extends State<ClerkSignInWidget> {
  static const _errorDisplayDuration = Duration(seconds: 3);

  Clerk.Strategy _strategy = Clerk.Strategy.password;
  String _identifier = '';
  String _password = '';
  String _code = '';
  Clerk.AuthError? _error;

  bool get _hasIdentifier => _identifier.isNotEmpty;
  bool get _hasPassword => _password.isNotEmpty;

  void _setError(Clerk.AuthError error) {
    setState(() => _error = error);
    Future.delayed(_errorDisplayDuration, () => setState(() => _error = null));
  }

  Future<T?> _callAuth<T>(Future<T> Function() fn) async {
    T? result;
    try {
      Overlay.of(context).insert(_holdingPattern);
      result = await fn.call();
    } on Clerk.AuthError catch (error) {
      _code = '';
      _strategy = Clerk.Strategy.password;
      _setError(error);
    } finally {
      _holdingPattern.remove();
    }
    return result;
  }

  Future<void> _oauth(Clerk.Auth auth, Clerk.Strategy strategy) async {
    final client = await _callAuth(() => auth.oauthSignIn(strategy: strategy));
    final url = client?.signIn?.firstFactorVerification?.providerUrl;
    if (url case String url) {
      late final OverlayEntry overlay;
      overlay = OverlayEntry(
        builder: (context) {
          final controller = WebViewController()
            ..setUserAgent('Clerk Flutter SDK v${Clerk.Auth.jsVersion}')
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setNavigationDelegate(
              NavigationDelegate(
                onNavigationRequest: (request) async {
                  if (request.url.startsWith(Clerk.Auth.oauthRedirect)) {
                    overlay.remove();
                    print('REQUEST: ${request.url}');
                    return NavigationDecision.prevent;
                  }
                  return NavigationDecision.navigate;
                },
              ),
            )
            ..loadRequest(Uri.parse(url));
          return Scaffold(
            appBar: AppBar(title: Text(auth.env.display.applicationName)),
            body: WebViewWidget(controller: controller),
          );
        },
      );
      Overlay.of(context).insert(overlay);
    }
  }

  Future<void> _continue(Clerk.Auth auth, {Clerk.Strategy? strategy, String? code}) async {
    if (_hasIdentifier) {
      final newStrategy = _hasPassword ? Clerk.Strategy.password : strategy ?? _strategy;
      final newCode = code ?? _code;
      if (_strategy != newStrategy || _code != newCode) {
        setState(() {
          _strategy = newStrategy;
          _code = newCode;
        });
      }

      await _callAuth(
        () => auth.attemptSignIn(
          strategy: newStrategy,
          identifier: _identifier,
          password: _password.orNullIfEmpty,
          code: newCode.orNullIfEmpty,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final translator = ClerkAuth.translatorOf(context);
    final auth = ClerkAuth.of(context);
    final env = auth.env;
    final oauthStrategies = env.auth.firstFactors.where((f) => f.isOauth);
    final otherStrategies = env.auth.firstFactors.where((f) => f.isOtherStrategy);
    final hasPasswordStrategy = env.auth.firstFactors.contains(Clerk.Strategy.password);
    final identifiers =
        env.auth.identificationStrategies.where((i) => i.isOauth == false).map((i) => i.title);
    final socialConnections = env.user.socialSettings.values.where(
      (s) => oauthStrategies.contains(s.strategy),
    );
    final factor =
        auth.client.signIn?.supportedFirstFactors.firstWhereOrNull((f) => f.strategy == _strategy);
    final safeIdentifier = factor?.safeIdentifier;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: horizontalPadding32,
          child: Text(
            translator.translate('Welcome back! Please sign in to continue'),
            textAlign: TextAlign.center,
            maxLines: 2,
            style: ClerkTextStyle.subtitle,
          ),
        ),
        verticalMargin24,
        Padding(
          padding: horizontalPadding32 + bottomPadding24,
          child: Row(
            children: [
              for (final connection in socialConnections)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: SocialConnectionButton(
                      key: ValueKey<Clerk.SocialConnection>(connection),
                      connection: connection,
                      onClicked: (strategy) => _oauth(auth, strategy),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const Padding(
          padding: horizontalPadding32,
          child: OrDivider(),
        ),
        verticalMargin24,
        Padding(
          padding: horizontalPadding32 + bottomPadding8,
          child: ClerkTextFormField(
            key: const Key('identifier'),
            label: translator.alternates(identifiers.toList()),
            onChanged: (text) {
              if (text.isEmpty != _identifier.isEmpty) {
                // only rebuild if we need the password box to animate
                // i.e. when going from '' -> '<a character>' or vice versa
                setState(() => _identifier = text);
              } else {
                _identifier = text;
              }
            },
          ),
        ),
        Closeable(
          key: const Key('emailLinkMessage'),
          open: _strategy == Clerk.Strategy.emailLink,
          child: Padding(
            padding: horizontalPadding32,
            child: Text(
              translator.translate(
                'Click on the link that‘s been sent to ### and then check back here',
                substitution: _identifier,
              ),
              maxLines: 2,
              style: ClerkTextStyle.inputLabel,
            ),
          ),
        ),
        Closeable(
          key: const Key('code'),
          open: _strategy.requiresCode,
          child: Padding(
            padding: horizontalPadding32 + verticalPadding8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: bottomPadding4,
                  child: Text(
                    safeIdentifier is String
                        ? translator.translate(
                            'Enter code sent to ###',
                            substitution: safeIdentifier,
                          )
                        : translator.translate('Enter code'),
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    style: ClerkTextStyle.inputLabel,
                  ),
                ),
                MultiDigitCodeInput(
                  onSubmit: (code) async {
                    await _continue(auth, code: code);
                    return false;
                  },
                ),
              ],
            ),
          ),
        ),
        Closeable(
          open: _strategy == Clerk.Strategy.password && _hasIdentifier,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (hasPasswordStrategy)
                Padding(
                  padding: horizontalPadding32 + verticalPadding8,
                  child: ClerkTextFormField(
                    label: translator.translate('Password'),
                    obscureText: true,
                    onChanged: (password) => _password = password,
                    onSubmit: (_) => _continue(auth),
                  ),
                ),
              if (otherStrategies.isNotEmpty) ...[
                if (hasPasswordStrategy)
                  const Padding(
                    padding: horizontalPadding32,
                    child: OrDivider(),
                  ),
                for (final strategy in otherStrategies)
                  if (StrategyButton.supports(strategy))
                    Padding(
                      padding: topPadding4 + horizontalPadding32,
                      child: StrategyButton(
                          key: ValueKey<Clerk.Strategy>(strategy),
                          strategy: strategy,
                          onClick: () => _continue(auth, strategy: strategy)),
                    ),
                Padding(
                  padding: horizontalPadding32 + bottomPadding32 + topPadding16,
                  child: ClerkMaterialButton(
                    onPressed: () => _continue(auth),
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(child: Text(translator.translate('Continue'))),
                        horizontalMargin4,
                        const Icon(Icons.arrow_right_sharp),
                      ],
                    ),
                  ),
                ),
              ],
              verticalMargin8,
            ],
          ),
        ),
        ErrorMessage(error: _error),
        verticalMargin16,
      ],
    );
  }
}

final _holdingPattern = OverlayEntry(
  builder: (context) => const SizedBox(
    width: double.infinity,
    height: double.infinity,
    child: ColoredBox(
      color: Colors.black26,
      child: Center(child: CircularProgressIndicator()),
    ),
  ),
);

extension _NullExtension on String {
  String? get orNullIfEmpty => isEmpty ? null : this;
}
