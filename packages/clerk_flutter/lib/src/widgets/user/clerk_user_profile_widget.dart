import 'package:clerk_flutter/style/colors.dart';
import 'package:clerk_flutter/src/common.dart';
import 'package:flutter/material.dart';

@immutable
class ClerkUserProfileWidget extends StatelessWidget {
  const ClerkUserProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: borderRadius12,
      clipBehavior: Clip.antiAlias,
      color: ClerkColors.lightGrey,
      child: Row(
        children: [
          Flexible(
            flex: 1,
            // FIXME(drexel-ue): how would we like this to scroll?
            child: SizedBox.expand(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    verticalMargin32,
                    const Padding(
                      padding: horizontalPadding32,
                      child: Text(
                        'Account',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                    ),
                    const Padding(
                      padding: horizontalPadding32,
                      child: Text(
                        'Manage your account info.',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                    ),
                    verticalMargin12,
                    Padding(
                      padding: horizontalPadding32,
                      child: FilledButton(
                        onPressed: () {},
                        style: ButtonStyle(),
                        child: const Row(
                          children: [
                            Icon(Icons.person),
                            horizontalMargin4,
                            Text('Profile'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: const Placeholder(),
          ),
        ],
      ),
    );
  }
}
