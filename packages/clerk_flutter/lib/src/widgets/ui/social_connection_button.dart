import 'package:clerk_auth/clerk_auth.dart' as Clerk;
import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// The [SocialConnectionButton] is to be used with the authentication flow when working with
/// a an oAuth provider. When there is sufficient space, an [Icon] and [Text] description of
/// the provider. Else, just the [Icon].
///

@immutable
class SocialConnectionButton extends StatelessWidget {
  static const _kRotatingTokenNonce = 'rotating_token_nonce';

  /// Constructs a new [SocialConnectionButton].
  const SocialConnectionButton({
    super.key,
    required this.connection,
    required this.callAuth,
  });

  /// The oAuth provider this button represents.
  final Clerk.SocialConnection connection;

  /// Callback for when button clicked
  final FutureCallback callAuth;

  Future<void> _oauth(BuildContext context, Clerk.Strategy strategy) async {
    final auth = ClerkAuth.of(context);
    final client = await callAuth(() => auth.oauthSignIn(strategy: strategy));
    final url = client?.signIn?.firstFactorVerification?.providerUrl;
    if (url case String url) {
      late final OverlayEntry? overlay;
      overlay = OverlayEntry(
        builder: (context) {
          final controller = WebViewController()
            ..setUserAgent('Clerk Flutter SDK v${Clerk.Auth.jsVersion}')
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setNavigationDelegate(
              NavigationDelegate(
                onNavigationRequest: (request) async {
                  if (request.url.startsWith(Clerk.Auth.oauthRedirect)) {
                    if (overlay is OverlayEntry && auth.client.user is! Clerk.User) {
                      final uri = Uri.parse(request.url);
                      final token = uri.queryParameters[_kRotatingTokenNonce];
                      if (token case String token) {
                        await callAuth(() => auth.attemptSignIn(strategy: strategy, token: token));
                      } else {
                        await auth.refreshClient();
                        await callAuth(() => auth.transfer());
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
          return Scaffold(
            appBar: AppBar(title: Text(auth.env.display.applicationName)),
            body: WebViewWidget(controller: controller),
          );
        },
      );
      Overlay.of(context).insert(overlay!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.0,
      child: MaterialButton(
        onPressed: () => _oauth(context, connection.strategy),
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius4,
          side: const BorderSide(color: ClerkColors.dawnPink),
        ),
        textColor: ClerkColors.brightGrey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final logo = SizedBox.square(
                dimension: 16.0,
                child: connection.logoUrl.isNotEmpty
                    ? Image.network(connection.logoUrl)
                    : Text(
                        connection.name[0].toUpperCase(),
                        textAlign: TextAlign.center,
                        style: ClerkTextStyle.title.copyWith(height: .95),
                      ),
              );
              if (constraints.maxWidth < 100.0) {
                return logo;
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  logo,
                  horizontalMargin8,
                  Text(connection.name, maxLines: 1, style: ClerkTextStyle.buttonTitle),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
