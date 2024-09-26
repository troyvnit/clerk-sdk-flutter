import 'package:clerk_flutter/assets.dart';
import 'package:clerk_flutter/src/common.dart';
import 'package:clerk_flutter/src/enums/social_connection.dart';
import 'package:clerk_flutter/src/widgets/authentication/clerk_vertical_card.dart';
import 'package:clerk_flutter/src/widgets/authentication/or_divider.dart';
import 'package:clerk_flutter/src/widgets/authentication/social_connection_button.dart';
import 'package:clerk_flutter/src/widgets/clerk_material_button.dart';
import 'package:clerk_flutter/src/widgets/clerk_phone_number_form_field.dart';
import 'package:clerk_flutter/src/widgets/clerk_text_form_field.dart';
import 'package:clerk_flutter/style/colors.dart';
import 'package:clerk_flutter/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// The [ClerkSignUpWidget] renders a UI for signing up users. The functionality of the
/// [ClerkSignUpWidget] is controlled by the instance settings you specify in your Clerk
/// Dashboard, such as sign-in and social connections. You can further customize your
/// [ClerSignUpWidget] by passing additional properties
///
/// https://clerk.com/docs/components/authentication/sign-up
///
///
@immutable
class ClerkSignUpWidget extends StatelessWidget {
  /// Constructs a new [ClerkSignUpWidget].
  const ClerkSignUpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ClerkVerticalCard(
      topPortion: _TopPortion(),
      bottomPortion: _BottomPortion(),
    );
  }
}

@immutable
class _TopPortion extends StatelessWidget {
  const _TopPortion();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        verticalMargin32,
        Center(
          child: SizedBox.square(
            dimension: 32.0,
            child: SvgPicture.asset(ClerkAssets.defaultOrganizationLogo),
          ),
        ),
        verticalMargin16,
        const Padding(
          padding: horizontalPadding32,
          child: Text(
            'Create your account',
            textAlign: TextAlign.center,
            maxLines: 1,
            style: ClerkTextStyle.title,
          ),
        ),
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
        Padding(
          padding: horizontalPadding32,
          child: Row(
            children: [
              for (final connection in [
                SocialConnection.google,
                SocialConnection.github
              ]) ...[
                Expanded(
                  child: SocialConnectionButton(
                    key: ValueKey<SocialConnection>(connection),
                    connection: connection,
                  ),
                ),
                if (connection != SocialConnection.values.last) //
                  horizontalMargin8,
              ]
            ],
          ),
        ),
        verticalMargin24,
        const OrDivider(),
        verticalMargin24,
        const Padding(
          padding: horizontalPadding32,
          child: Row(
            children: [
              Expanded(
                child: ClerkTextFormField(
                  label: 'First name',
                  optional: true,
                ),
              ),
              horizontalMargin8,
              Expanded(
                child: ClerkTextFormField(
                  label: 'Last name',
                  optional: true,
                ),
              ),
            ],
          ),
        ),
        verticalMargin24,
        const Padding(
          padding: horizontalPadding32,
          child: ClerkTextFormField(label: 'Username'),
        ),
        verticalMargin24,
        const Padding(
          padding: horizontalPadding32,
          child: ClerkTextFormField(label: 'Email address'),
        ),
        verticalMargin24,
        const Padding(
          padding: horizontalPadding32,
          child: ClerkPhoneNumberFormField(),
        ),
        verticalMargin24,
        const Padding(
          padding: horizontalPadding32,
          child: ClerkTextFormField(label: 'Password'),
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

@immutable
class _BottomPortion extends StatelessWidget {
  const _BottomPortion();

  @override
  Widget build(BuildContext context) {
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
                const TextSpan(
                  text: 'Already have an account? ',
                  style: ClerkTextStyle.subtitle,
                ),
                TextSpan(
                  text: 'Sign in',
                  style: ClerkTextStyle.subtitle.copyWith(
                    color: ClerkColors.darkJungleGreen,
                  ),
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
