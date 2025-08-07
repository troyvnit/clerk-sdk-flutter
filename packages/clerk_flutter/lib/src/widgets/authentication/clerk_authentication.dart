import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:clerk_flutter/src/utils/clerk_telemetry.dart';
import 'package:clerk_flutter/src/widgets/authentication/clerk_sign_in_panel.dart';
import 'package:clerk_flutter/src/widgets/authentication/clerk_sign_up_panel.dart';
import 'package:clerk_flutter/src/widgets/authentication/clerk_sso_panel.dart';
import 'package:clerk_flutter/src/widgets/ui/clerk_panel_header.dart';
import 'package:clerk_flutter/src/widgets/ui/clerk_vertical_card.dart';
import 'package:clerk_flutter/src/widgets/ui/closeable.dart';
import 'package:clerk_flutter/src/widgets/ui/common.dart';
import 'package:clerk_flutter/src/widgets/ui/or_divider.dart';
import 'package:clerk_flutter/src/widgets/ui/style/colors.dart';
import 'package:clerk_flutter/src/widgets/ui/style/text_style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

enum _AuthState {
  signingIn,
  signingUp;

  bool get isSigningIn => this == signingIn;

  bool get isSigningUp => this == signingUp;

  _AuthState get nextState => values[(index + 1) % values.length];
}

/// The [ClerkAuthentication] renders a UI for signing users or up.
///
/// The functionality of the [ClerkAuthentication] is controlled by the instance settings you
/// specify in your Clerk Dashboard, such as sign-in and sign-ip options and social
/// connections. You can further customize you [ClerkAuthentication] by passing additional
/// properties.
///
@immutable
class ClerkAuthentication extends StatefulWidget {
  /// Constructs a new [ClerkAuthentication].
  const ClerkAuthentication({super.key});

  @override
  State<ClerkAuthentication> createState() => _ClerkAuthenticationState();
}

class _ClerkAuthenticationState extends State<ClerkAuthentication>
    with ClerkTelemetryStateMixin {
  _AuthState _state = _AuthState.signingIn;

  void _toggle() => setState(() => _state = _state.nextState);

  @override
  Widget build(BuildContext context) {
    return ClerkVerticalCard(
      topPortion: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _TopPortion(state: _state),
          ClerkAuthBuilder(
            builder: (context, authState) {
              final env = authState.env;
              return Padding(
                padding: horizontalPadding32,
                child: Column(
                  children: [
                    if (env.hasOauthStrategies) //
                      Closeable(
                        closed: authState.isSigningIn || authState.isSigningUp,
                        child: ClerkSSOPanel(
                          onStrategyChosen: (strategy) =>
                              authState.ssoSignIn(context, strategy),
                        ),
                      ),
                    if (env.hasIdentificationStrategies) ...[
                      if (env.hasOauthStrategies) //
                        const Padding(
                          padding: verticalPadding24,
                          child: OrDivider(),
                        ),
                      Closeable(
                        closed: _state.isSigningIn == false,
                        child: ClerkSignInPanel(isActive: _state.isSigningIn),
                      ),
                      Closeable(
                        closed: _state.isSigningUp == false,
                        child: ClerkSignUpPanel(isActive: _state.isSigningUp),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ],
      ),
      bottomPortion: _BottomPortion(
        state: _state,
        onChange: _toggle,
      ),
    );
  }
}

@immutable
class _TopPortion extends StatelessWidget {
  const _TopPortion({required this.state});

  final _AuthState state;

  @override
  Widget build(BuildContext context) {
    final display = ClerkAuth.displayConfigOf(context);
    final localizations = ClerkAuth.localizationsOf(context);

    return ClerkPanelHeader(
      title: state.isSigningIn
          ? localizations.signInTo(display.applicationName)
          : localizations.signUpTo(display.applicationName),
      subtitle: state.isSigningIn
          ? localizations.welcomeBackPleaseSignInToContinue
          : localizations.welcomePleaseFillInTheDetailsToGetStarted,
    );
  }
}

@immutable
class _BottomPortion extends StatelessWidget {
  const _BottomPortion({required this.onChange, required this.state});

  final VoidCallback onChange;
  final _AuthState state;

  @override
  Widget build(BuildContext context) {
    final localizations = ClerkAuth.localizationsOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        verticalMargin12,
        Padding(
          padding: horizontalPadding32,
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: state.isSigningIn
                      ? localizations.dontHaveAnAccount
                      : localizations.alreadyHaveAnAccount,
                  style: ClerkTextStyle.subtitle,
                ),
                const WidgetSpan(child: SizedBox(width: 6)),
                TextSpan(
                  text: state.isSigningIn
                      ? localizations.signUp
                      : localizations.signIn,
                  style: ClerkTextStyle.subtitle
                      .copyWith(color: ClerkColors.darkJungleGreen),
                  recognizer: TapGestureRecognizer()..onTap = onChange,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
        verticalMargin12,
      ],
    );
  }
}
