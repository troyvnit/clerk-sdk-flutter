import 'package:clerk_auth/clerk_auth.dart' as Clerk;
import 'package:clerk_flutter/src/common.dart';
import 'package:flutter/material.dart';

import 'clerk_auth.dart';

typedef AuthWidgetBuilder = Widget Function(BuildContext context, Clerk.Auth auth);

class ClerkAuthBuilder extends StatelessWidget {
  final AuthWidgetBuilder? signedInBuilder;
  final AuthWidgetBuilder? signedOutBuilder;
  final AuthWidgetBuilder? builder;

  const ClerkAuthBuilder({super.key, this.signedInBuilder, this.signedOutBuilder, this.builder});

  @override
  Widget build(BuildContext context) {
    final auth = ClerkAuth.of(context);
    final user = auth.client.user;

    if (signedInBuilder case AuthWidgetBuilder signedInBuilder when user is Clerk.User) {
      return signedInBuilder.call(context, auth);
    } else if (signedOutBuilder case AuthWidgetBuilder signedOutBuilder when user is! Clerk.User) {
      return signedOutBuilder.call(context, auth);
    } else if (builder case AuthWidgetBuilder builder) {
      return builder.call(context, auth);
    }

    return emptyWidget;
  }
}
