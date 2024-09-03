import 'package:clerk_flutter/assets.dart';
import 'package:clerk_flutter/style/colors.dart';
import 'package:clerk_flutter/src/common.dart';
import 'package:clerk_flutter/src/enums/social_connection.dart';
import 'package:clerk_flutter/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  });

  /// The oAuth provider this button represents.
  final SocialConnection connection;

  static const _assets = [
    ClerkAssets.googleLogo,
    ClerkAssets.facebookLogo,
    ClerkAssets.githubLogo,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.0,
      child: MaterialButton(
        onPressed: () {},
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
                child: SvgPicture.asset(_assets[connection.index]),
              );
              if (constraints.maxWidth < 100.0) {
                return logo;
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  logo,
                  horizontalMargin8,
                  Text(
                    connection.value,
                    maxLines: 1,
                    style: ClerkTextStyle.subtitle.copyWith(
                      fontSize: 12.0,
                      color: ClerkColors.brightGrey,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
