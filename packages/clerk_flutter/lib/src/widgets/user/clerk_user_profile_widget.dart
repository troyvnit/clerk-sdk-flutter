import 'package:clerk_flutter/assets.dart';
import 'package:clerk_flutter/src/common.dart';
import 'package:clerk_flutter/src/widgets/clerk_icon.dart';
import 'package:clerk_flutter/src/widgets/clerk_two_panel_view.dart';
import 'package:clerk_flutter/src/widgets/random_avatar.dart';
import 'package:clerk_flutter/style/colors.dart';
import 'package:clerk_flutter/style/text_style.dart';
import 'package:flutter/material.dart';

/// The [ClerkUserProfileWidget] component is used to render a beautiful, full-featured
/// account management UI that allows users to manage their profile and security settings.
///
@immutable
class ClerkUserProfileWidget extends StatelessWidget {
  /// Constructs a const [ClerkUserProfileWidget].
  const ClerkUserProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ClerkTwoPanelView(
      firstChild: _FirstChild(),
      secondChild: _SecondChild(),
    );
  }
}

@immutable
class _FirstChild extends StatelessWidget {
  const _FirstChild();

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          verticalMargin32,
          Padding(
            padding: horizontalPadding24,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Account',
                textAlign: TextAlign.center,
                maxLines: 1,
                style: ClerkTextStyle.title,
              ),
            ),
          ),
          Padding(
            padding: horizontalPadding24,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Manage your account info.',
                textAlign: TextAlign.center,
                maxLines: 1,
                style: ClerkTextStyle.subtitle,
              ),
            ),
          ),
          verticalMargin24,
          Padding(
            padding: horizontalPadding24,
            child: _ProfileNavTile(
              icon: ClerkIcon(ClerkAssets.profileIcon),
              title: 'Profile',
              selected: true,
            ),
          ),
          Padding(
            padding: horizontalPadding24,
            child: _ProfileNavTile(
              icon: ClerkIcon(ClerkAssets.securityIconLight),
              title: 'Security',
              selected: false,
            ),
          ),
        ],
      ),
    );
  }
}

@immutable
class _ProfileNavTile extends StatelessWidget {
  const _ProfileNavTile({
    required this.icon,
    required this.title,
    required this.selected,
  });

  final Widget icon;

  final String title;

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: borderRadius12,
      clipBehavior: Clip.antiAlias,
      color: selected ? ClerkColors.dawnPink : Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: horizontalPadding14 + verticalPadding16,
          child: Row(
            children: [
              icon,
              horizontalMargin8,
              Text(
                title,
                style: selected
                    ? ClerkTextStyle.subtitle.copyWith(color: ClerkColors.darkJungleGreen)
                    : ClerkTextStyle.subtitle,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

@immutable
class _SecondChild extends StatelessWidget {
  const _SecondChild();

  static const _firstColumnWidth = 215.0;
  static const _secondColumnWidth = 280.0;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: ClerkTextStyle.subtitleDark.copyWith(height: 1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          verticalMargin32,
          const Padding(
            padding: horizontalPadding32,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Profile details',
                maxLines: 1,
                style: ClerkTextStyle.title,
              ),
            ),
          ),
          verticalMargin20,
          const Padding(
            padding: horizontalPadding32,
            child: divider,
          ),
          verticalMargin20,
          const Padding(
            padding: horizontalPadding32,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: _firstColumnWidth,
                  child: Text('Profile', maxLines: 1),
                ),
                // FIXME(drexel-ue): replace wth real data.
                SizedBox(
                  width: _secondColumnWidth,
                  child: Row(
                    children: [
                      RandomAvatar(
                        seed: 'Jaylon Dias',
                        size: 48.0,
                      ),
                      horizontalMargin16,
                      Text('Jaylon Dias', maxLines: 1),
                    ],
                  ),
                ),
                spacer,
                Text(
                  'Edit Profile',
                  maxLines: 1,
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ),
          verticalMargin24,
          const Padding(
            padding: horizontalPadding32,
            child: divider,
          ),
          verticalMargin24,
          Padding(
            padding: horizontalPadding32,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: _firstColumnWidth,
                  child: Text('Email addresses', maxLines: 1),
                ),
                SizedBox(
                  width: _secondColumnWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          const Text('example@clerk.dev', maxLines: 1),
                          horizontalMargin8,
                          DecoratedBox(
                            decoration: insetBoxShadowDecoration.copyWith(
                              color: ClerkColors.whiteSmoke,
                              borderRadius: borderRadius8,
                            ),
                            child: const Text('Primary', maxLines: 1),
                          ),
                        ],
                      ),
                      const Text('example@personal.com', maxLines: 1),
                      const Text('example@work.com', maxLines: 1),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
