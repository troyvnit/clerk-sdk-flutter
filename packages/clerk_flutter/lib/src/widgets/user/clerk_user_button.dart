import 'package:clerk_flutter/assets.dart';
import 'package:clerk_flutter/src/common.dart';
import 'package:clerk_flutter/src/widgets/ui/clerk_icon.dart';
import 'package:clerk_flutter/src/widgets/ui/clerk_material_button.dart';
import 'package:clerk_flutter/src/widgets/ui/clerk_vertical_card.dart';
import 'package:clerk_flutter/src/widgets/ui/style/colors.dart';
import 'package:clerk_flutter/src/widgets/ui/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// The [ClerkUserButton] is used to render the familiar user button UI popularized by
/// Google.
///
/// Clerk is the only provider with multi-session support, allowing users to sign into
/// multiple accounts at once and switch between them. For multi-session apps, the
/// [ClerkUserButton] automatically supports instant account switching, without the need of
/// a full page reload. For more information you can check out the Multi-session
/// applications guide.
///
/// https://clerk.com/docs/components/user/user-button
///
@immutable
class ClerkUserButton extends StatefulWidget {
  /// Constructs a new [ClerkUserButton].
  const ClerkUserButton({
    super.key,
    this.avatar,
  });

  /// The user's avatar.
  final Widget? avatar;

  @override
  State<ClerkUserButton> createState() => _ClerkUserButtonState();
}

class _ClerkUserButtonState extends State<ClerkUserButton> {
  static int _selectedUserIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      alignmentOffset: const Offset(0.0, 8.0),
      style: MenuStyle(
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
      ),
      menuChildren: [
        ClerkVerticalCard(
          topPortion: _UserSelector(selectedUserIndex: _selectedUserIndex),
          bottomPortion: const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              verticalMargin12,
              Padding(
                padding: horizontalPadding32,
                child: Row(
                  children: [
                    ClerkIcon(ClerkAssets.signOutIconLight),
                    horizontalMargin12,
                    Text(
                      'Sign out of all accounts',
                      maxLines: 1,
                      style: ClerkTextStyle.userButtonTitle,
                    ),
                  ],
                ),
              ),
              verticalMargin12,
            ],
          ),
        ),
      ],
      builder: (BuildContext context, MenuController controller, Widget? child) {
        return GestureDetector(
          onTap: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          child: child,
        );
      },
      child: CircleAvatar(
        backgroundColor: ClerkColors.brightGrey,
        radius: 28.0 / 2.0,
        child: ClipRRect(
          borderRadius: borderRadius28,
          child: widget.avatar,
        ),
      ),
    );
  }
}

@immutable
class _User {
  const _User({
    required this.name,
    required this.email,
  });

  final String name;
  final String email;
}

@immutable
class _UserSelector extends StatelessWidget {
  const _UserSelector({
    required this.selectedUserIndex,
  });

  static const _users = [
    _User(
      name: 'Cameron Walker',
      email: 'cameron.j.r.walkder@gmail.com',
    ),
    _User(
      name: 'Cameron Walker',
      email: 'cameron@walker.com',
    ),
    _User(
      name: 'Cameron Walker',
      email: 'walker@personal.com',
    ),
  ];

  final int selectedUserIndex;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final user in _users) ...[
            Padding(
              padding: horizontalPadding20 + verticalPadding16,
              child: _UserTile(
                user: user,
                selected: selectedUserIndex == _users.indexOf(user),
              ),
            ),
            Divider(
              height: 1.0,
              thickness: 1.0,
              color: ClerkColors.lightGrey,
            ),
          ],
          Padding(
            padding: horizontalPadding20 + verticalPadding16,
            child: const Row(
              children: [
                SizedBox(
                  width: 36.0,
                  child: Center(
                    child: ClerkIcon(
                      ClerkAssets.addIcon,
                      size: 24.0,
                    ),
                  ),
                ),
                horizontalMargin8,
                Text('Add account', maxLines: 1, style: ClerkTextStyle.userButtonTitle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

@immutable
class _UserTile extends StatelessWidget {
  const _UserTile({
    required this.user,
    required this.selected,
  });

  final _User user;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: ClerkColors.brightGrey,
          radius: 18.0,
          child: ClipRRect(
            borderRadius: borderRadius18,
            child: SvgPicture.network(
              'https://api.dicebear.com/9.x/dylan/svg?seed=${user.email.hashCode}',
            ),
          ),
        ),
        horizontalMargin12,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                user.name,
                style: ClerkTextStyle.userButtonSubtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                user.email,
                style: ClerkTextStyle.userButtonSubtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (selected) //
                ...[
                verticalMargin16,
                const Row(
                  children: [
                    Expanded(
                      child: ClerkMaterialButton(
                        style: ClerkMaterialButtonStyle.light,
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClerkIcon(ClerkAssets.gearIcon),
                            horizontalMargin8,
                            Text('Manage account'),
                          ],
                        ),
                      ),
                    ),
                    horizontalMargin8,
                    Expanded(
                      child: ClerkMaterialButton(
                        style: ClerkMaterialButtonStyle.light,
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClerkIcon(ClerkAssets.signOutIcon),
                            horizontalMargin8,
                            Text('Sign out'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
