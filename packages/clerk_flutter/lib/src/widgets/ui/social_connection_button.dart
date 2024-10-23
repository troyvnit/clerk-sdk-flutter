import 'package:clerk_auth/clerk_api/clerk_api.dart' as Clerk;
import 'package:clerk_flutter/src/common.dart';
import 'package:clerk_flutter/src/widgets/ui/style/colors.dart';
import 'package:clerk_flutter/src/widgets/ui/style/text_style.dart';
import 'package:flutter/material.dart';

/// The [SocialConnectionButton] is to be used with the authentication flow when working with
/// a an oAuth provider. When there is sufficient space, an [Icon] and [Text] description of
/// the provider. Else, just the [Icon].
///

@immutable
class SocialConnectionButton extends StatelessWidget {
  /// Constructs a new [SocialConnectionButton].
  const SocialConnectionButton({
    super.key,
    required this.connection,
    required this.onClicked,
  });

  /// The oAuth provider this button represents.
  final Clerk.SocialConnection connection;

  /// Callback for when button clicked
  final ValueChanged<Clerk.Strategy> onClicked;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.0,
      child: MaterialButton(
        onPressed: () => onClicked(connection.strategy),
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
                        connection.name.characters.first.toUpperCase(),
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
