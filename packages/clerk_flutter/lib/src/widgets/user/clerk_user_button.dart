import 'package:clerk_flutter/style/colors.dart';
import 'package:clerk_flutter/src/common.dart';
import 'package:clerk_flutter/src/widgets/authentication/clerk_vertical_card.dart';
import 'package:clerk_flutter/src/widgets/clerk_material_button.dart';
import 'package:flutter/material.dart';

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
  const ClerkUserButton({super.key});

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
                    Icon(Icons.logout),
                    horizontalMargin12,
                    Text('Sign out of all accounts'),
                  ],
                ),
              ),
              verticalMargin12,
              const Divider(),
              verticalMargin12,
              Center(
                child: SizedBox(
                  height: 40.0,
                  width: 150.0,
                  child: const Placeholder(),
                ),
              ),
              verticalMargin12,
            ],
          ),
        ),
      ],
      builder:
          (BuildContext context, MenuController controller, Widget? child) {
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
      child: const CircleAvatar(),
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
            _UserTile(
              user: user,
              selected: selectedUserIndex == _users.indexOf(user),
            ),
            Divider(
              height: 1.0,
              thickness: 1.0,
              color: ClerkColors.lightGrey,
            ),
          ],
          const ListTile(
            leading: Icon(Icons.add_circle_outline, size: 40.0),
            title: Text('Add account'),
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
    return ListTile(
      leading: const CircleAvatar(),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(user.name),
          Text(user.email),
        ],
      ),
      subtitle: selected //
          ? const Row(
              children: [
                Expanded(
                  child: const ClerkMaterialButton(
                    style: ClerkMaterialButtonStyle.light,
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.settings),
                        horizontalMargin4,
                        Text('Manage account'),
                      ],
                    ),
                  ),
                ),
                horizontalMargin8,
                Expanded(
                  child: const ClerkMaterialButton(
                    style: ClerkMaterialButtonStyle.light,
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.logout),
                        horizontalMargin4,
                        Text('Sign out'),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : null,
    );
  }
}
