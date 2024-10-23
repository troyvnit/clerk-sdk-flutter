import 'package:clerk_auth/clerk_auth.dart' as Clerk;
import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';

/// The [ClerkSignUpWidget] renders a UI for signing up users.
///
/// The functionality of the [ClerkSignUpWidget] is controlled by the instance settings
/// you specify in your Clerk Dashboard, such as sign-in and social connections. You can
/// further customize your [ClerkSignUpWidget] by passing additional properties.
///
/// https://clerk.com/docs/components/authentication/sign-up
///
///
@immutable
class ClerkSignUpWidget extends StatelessWidget {
  const ClerkSignUpWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: horizontalPadding32,
          child: Text(
            'Welcome! Please fill in the details to get started.',
            textAlign: TextAlign.center,
            maxLines: 1,
            style: ClerkTextStyle.subtitle,
          ),
        ),
        verticalMargin24,
        ClerkAuthBuilder(builder: (context, auth) {
          final env = auth.env;
          final oauthStrategies = env.auth.identificationStrategies.where((i) => i.isOauth);
          final socialConnections = env.user.socialSettings.values.where(
            (s) => oauthStrategies.contains(s.strategy),
          );
          return Padding(
            padding: horizontalPadding32,
            child: Row(
              children: [
                for (final connection in socialConnections) //
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: SocialConnectionButton(
                        key: ValueKey<Clerk.SocialConnection>(connection),
                        connection: connection,
                        onClicked: (_) => null,
                      ),
                    ),
                  ),
              ],
            ),
          );
        }),
        verticalMargin24,
        const OrDivider(),
        verticalMargin24,
        Padding(
          padding: horizontalPadding32,
          child: Row(
            children: [
              Expanded(
                child: ClerkTextFormField(
                  label: 'First name',
                  optional: true,
                  onChanged: (_) => null,
                ),
              ),
              horizontalMargin8,
              Expanded(
                child: ClerkTextFormField(
                  label: 'Last name',
                  optional: true,
                  onChanged: (_) => null,
                ),
              ),
            ],
          ),
        ),
        verticalMargin24,
        Padding(
          padding: horizontalPadding32,
          child: ClerkTextFormField(
            label: 'Username',
            onChanged: (_) => null,
          ),
        ),
        verticalMargin24,
        Padding(
          padding: horizontalPadding32,
          child: ClerkTextFormField(
            label: 'Email address',
            onChanged: (_) => null,
          ),
        ),
        verticalMargin24,
        const Padding(
          padding: horizontalPadding32,
          child: ClerkPhoneNumberFormField(),
        ),
        verticalMargin24,
        Padding(
          padding: horizontalPadding32,
          child: ClerkTextFormField(
            label: 'Password',
            onChanged: (_) => null,
          ),
        ),
        verticalMargin24,
        const Padding(
          padding: horizontalPadding32,
          child: ClerkMaterialButton(
            label: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Continue'),
                Icon(Icons.arrow_right_sharp),
              ],
            ),
          ),
        ),
        verticalMargin32,
      ],
    );
  }
}
