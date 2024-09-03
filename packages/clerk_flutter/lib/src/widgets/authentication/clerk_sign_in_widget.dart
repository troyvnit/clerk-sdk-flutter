import 'package:clerk_flutter/assets.dart';
import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:clerk_flutter/style/colors.dart';
import 'package:clerk_flutter/src/common.dart';
import 'package:clerk_flutter/src/widgets/authentication/clerk_vertical_card.dart';
import 'package:clerk_flutter/src/widgets/authentication/or_divider.dart';
import 'package:clerk_flutter/src/widgets/authentication/social_connection_button.dart';
import 'package:clerk_flutter/src/widgets/clerk_material_button.dart';
import 'package:clerk_flutter/src/widgets/clerk_text_form_field.dart';
import 'package:clerk_flutter/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// The [ClerkSignInWidget] renders a UI for signing in users.
/// The functionality of the [ClerkSignInWidget] is controlled by the
/// instance settings you specify in your Clerk Dashboard, such as
/// sign-in and sign-ip options and social conntections. You can
/// further customize you [ClersSignInWidget] by passing additional
/// properties.
///
/// https://clerk.com/docs/components/authentication/sign-in
///
///
@immutable
class ClerkSignInWidget extends StatelessWidget {
  /// Constructs a new [ClerSignInWidget].
  const ClerkSignInWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 530.0),
      child: const ClerkVerticalCard(
        topPortion: _TopPortion(),
        bottomPortion: _BottomPortion(),
      ),
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
        verticalMargin24,
        const Padding(
          padding: horizontalPadding32,
          child: Text(
            'Sign in to Acme Co',
            textAlign: TextAlign.center,
            maxLines: 1,
            style: ClerkTextStyle.title,
          ),
        ),
        const Padding(
          padding: horizontalPadding32,
          child: Text(
            'Welcome back! Please sign in to continue',
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
              for (final connection in SocialConnection.values) ...[
                Expanded(
                  child: SocialConnectionButton(
                    key: ValueKey<SocialConnection>(connection),
                    connection: connection,
                  ),
                ),
                if (connection != SocialConnection.values.last) //
                  horizontalMargin8,
              ],
            ],
          ),
        ),
        verticalMargin24,
        const Padding(
          padding: horizontalPadding32,
          child: OrDivider(),
        ),
        verticalMargin24,
        const Padding(
          padding: horizontalPadding32,
          child: ClerkTextFormField(label: 'Email address'),
        ),
        verticalMargin24,
        Padding(
          padding: horizontalPadding32,
          child: ClerkMaterialButton(
            onPressed: () {},
            label: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // FIXME(drexel-ue): fix hacked algnment.
                Center(child: Text('Continue')),
                horizontalMargin4,
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
                  text: 'Dont have an account? ',
                  style: ClerkTextStyle.subtitle,
                ),
                TextSpan(
                  text: 'Sign up',
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
