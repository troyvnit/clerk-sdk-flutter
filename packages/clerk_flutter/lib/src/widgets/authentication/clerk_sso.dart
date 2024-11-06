import 'package:clerk_auth/clerk_auth.dart' as Clerk;
import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';

class ClerkSSO extends StatefulWidget {
  const ClerkSSO({super.key});

  @override
  State<ClerkSSO> createState() => _ClerkSSOState();
}

class _ClerkSSOState extends State<ClerkSSO> {
  static const _errorDisplayDuration = Duration(seconds: 3);

  @override
  Widget build(BuildContext context) {
    final auth = ClerkAuth.of(context);
    final env = auth.env;
    final oauthStrategies = env.auth.identificationStrategies.where((i) => i.isOauth);
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
