import 'package:clerk_auth/clerk_auth.dart' as Clerk;
import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';

class ClerkSSOPanel extends StatefulWidget {
  const ClerkSSOPanel({super.key});

  @override
  State<ClerkSSOPanel> createState() => _ClerkSSOPanelState();
}

class _ClerkSSOPanelState extends State<ClerkSSOPanel> {
  static const _errorDisplayDuration = Duration(seconds: 3);

  @override
  Widget build(BuildContext context) {
    final auth = ClerkAuth.of(context);
    final env = auth.env;
    final oauthStrategies = env.config.identificationStrategies.where((i) => i.isOauth);
    final socialConnections = env.user.socialSettings.values.where(
      (s) => oauthStrategies.contains(s.strategy),
    );
    return Column(
      children: [
        Padding(
          padding: horizontalPadding32 + bottomPadding24,
          child: Row(
            children: [
              for (final connection in socialConnections) //
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: SocialConnectionButton(
                      key: ValueKey<Clerk.SocialConnection>(connection),
                      connection: connection,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const OrDivider(),
        verticalMargin24,
      ],
    );
  }
}
