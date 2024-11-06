import 'dart:async';

import 'package:clerk_auth/clerk_auth.dart' as Clerk;
import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';

class ClerkErrorMessage extends StatefulWidget {
  @override
  State<ClerkErrorMessage> createState() => _ClerkErrorMessageState();
}

class _ClerkErrorMessageState extends State<ClerkErrorMessage> {
  static const _errorDisplayDuration = Duration(seconds: 3);

  String _error = '';
  Timer? _timer;

  void _setError(Clerk.AuthError? error) {
    if (error case Clerk.AuthError error) {
      _error = error.toString();
      _timer?.cancel();
      _timer = Timer(_errorDisplayDuration, () => setState(() => _timer = null));
    }
  }

  @override
  Widget build(BuildContext context) {
    final translator = ClerkAuth.translatorOf(context);
    return StreamBuilder<Clerk.AuthError>(
      stream: ClerkAuth.errorStreamOf(context),
      builder: (context, snapshot) {
        _setError(snapshot.data);
        return Closeable(
          open: _timer is Timer && _error.isNotEmpty,
          child: Padding(
            padding: horizontalPadding32 + bottomPadding8,
            child: Text(translator.translate(_error), maxLines: 2, style: ClerkTextStyle.error),
          ),
        );
      },
    );
  }
}
