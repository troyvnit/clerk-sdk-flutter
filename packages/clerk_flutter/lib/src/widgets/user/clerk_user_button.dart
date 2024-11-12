import 'package:clerk_auth/clerk_auth.dart' as Clerk;
import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';

class ClerkUserButton extends StatefulWidget {
  const ClerkUserButton({super.key});

  @override
  State<ClerkUserButton> createState() => _ClerkUserButtonState();
}

class _ClerkUserButtonState extends State<ClerkUserButton> {
  static const _closeDelay = Duration(milliseconds: 250);

  List<Clerk.Session> _sessions = [];

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: ClerkColors.white,
        boxShadow: [BoxShadow(color: ClerkColors.mercury, blurRadius: 15)],
      ),
      child: ClerkAuthBuilder(builder: (context, auth) {
        final translator = auth.translator;

        // adding to a list of existing sessions means we have ones that are now deleted
        // available for prettier UI
        _sessions.addOrReplaceAll(auth.client.sessions, by: (s) => s.id);

        // after a delay period, all deleted sessions will have been closed, so we can
        // clear the `_sessions` cache of any such for next time round
        Future.delayed(_closeDelay, () => _sessions = [...auth.client.sessions]);

        return ClerkVerticalCard(
          topPortion: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final session in _sessions)
                Closeable(
                  key: Key(session.id),
                  duration: _closeDelay,
                  open: auth.client.sessions.contains(session),
                  child: _SessionRow(
                    session: session,
                    selected: session == auth.client.activeSession,
                    onTap: () => auth.call(context, () => auth.setActiveSession(session)),
                  ),
                ),
              if (auth.env.config.singleSessionMode == false)
                Padding(
                  padding: horizontalPadding20 + verticalPadding8,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _signIn(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox.square(
                          dimension: 22,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: ClerkColors.dawnPink,
                              shape: BoxShape.circle,
                              border: Border.all(color: ClerkColors.mercury),
                            ),
                            child: const Icon(Icons.add, size: 16, color: ClerkColors.stormGrey),
                          ),
                        ),
                        horizontalMargin24,
                        Text(
                          translator.translate('Add account'),
                          style:
                              ClerkTextStyle.buttonTitle.copyWith(color: ClerkColors.almostBlack),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          bottomPortion: Closeable(
            open: auth.client.sessions.length > 1,
            child: Padding(
              padding: horizontalPadding16 + verticalPadding12,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => auth.call(context, () => auth.signOut()),
                child: Row(
                  children: [
                    const Icon(Icons.logout, color: ClerkColors.grey, size: 16),
                    horizontalMargin8,
                    Text(
                      translator.translate('Sign out of all accounts'),
                      style: ClerkTextStyle.buttonTitle,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Future<void> _signIn(BuildContext context) async {
    final auth = ClerkAuth.nonDependentOf(context);
    final numSessions = auth.client.sessions.length;

    late final OverlayEntry overlay;
    late VoidCallback unloadOverlay;

    unloadOverlay = () {
      if (auth.client.sessions.length != numSessions) {
        overlay.remove();
        auth.removeListener(unloadOverlay);
      }
    };

    overlay = OverlayEntry(
      builder: (context) {
        return ClerkAuth(
          auth: auth,
          child: const Scaffold(
            backgroundColor: ClerkColors.whiteSmoke,
            body: Padding(
              padding: allPadding32,
              child: ClerkAuthenticationWidget(),
            ),
          ),
        );
      },
    );
    auth.addListener(unloadOverlay);
    Overlay.of(context).insert(overlay);
  }
}

class _SessionRow extends StatelessWidget {
  final Clerk.Session session;
  final bool selected;
  final VoidCallback? onTap;

  const _SessionRow({
    super.key,
    required this.session,
    this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final translator = ClerkAuth.translatorOf(context);
    final user = session.user;
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: Padding(
            padding: horizontalPadding16 + topPadding4,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: ClerkColors.mountainMist,
                  child: user.imageUrl is String
                      ? ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(16)),
                          child: Image.network(
                            user.imageUrl!,
                            width: 32,
                            height: 32,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Text(user.name.initials, style: ClerkTextStyle.subtitleDark),
                ),
                horizontalMargin16,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: ClerkTextStyle.buttonTitle.copyWith(color: ClerkColors.almostBlack),
                    ),
                    if (user.email is String) Text(user.email!, style: ClerkTextStyle.buttonTitle),
                  ],
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: horizontalPadding16 + topPadding4,
          child: Closeable(
            open: selected,
            child: Padding(
              padding: leftPadding48 + bottomPadding8,
              child: Builder(builder: (context) {
                final auth = ClerkAuth.nonDependentOf(context);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Expanded(
                    //   child: ClerkMaterialButton(
                    //     onPressed: () => auth.call(context, () => auth.signOut()),
                    //     label: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       crossAxisAlignment: CrossAxisAlignment.end,
                    //       children: [
                    //         const Icon(Icons.settings, color: ClerkColors.charcoalGrey, size: 11),
                    //         horizontalMargin8,
                    //         Text(
                    //           translator.translate('Manage account'),
                    //           style: ClerkTextStyle.buttonSubtitle.copyWith(
                    //             fontSize: 8,
                    //             color: ClerkColors.charcoalGrey,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //     style: ClerkMaterialButtonStyle.light,
                    //     height: 16,
                    //   ),
                    // ),
                    // horizontalMargin8,
                    Expanded(
                      child: ClerkMaterialButton(
                        onPressed: () {
                          if (auth.client.sessions.length == 1) {
                            auth.call(context, () => auth.signOut());
                          } else {
                            auth.call(context, () => auth.signOutSession(session));
                          }
                        },
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Icon(Icons.logout, color: ClerkColors.charcoalGrey, size: 11),
                            horizontalMargin8,
                            Text(
                              translator.translate('Sign Out'),
                              style: ClerkTextStyle.buttonSubtitle.copyWith(
                                fontSize: 8,
                                color: ClerkColors.charcoalGrey,
                              ),
                            ),
                          ],
                        ),
                        style: ClerkMaterialButtonStyle.light,
                        height: 16,
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
        const Divider(height: 1, color: ClerkColors.dawnPink),
      ],
    );
  }
}
