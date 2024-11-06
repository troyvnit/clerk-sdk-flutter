import 'dart:async';

import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';

class ErrorMessage extends StatefulWidget {
  @override
  State<ErrorMessage> createState() => _ErrorMessageState();
}

class _ErrorMessageState extends State<ErrorMessage> {
  static const _errorDisplayDuration = Duration(seconds: 3);

  String _error = '';
  Timer? _timer;

  void _setError(String? error) {
    if (error case String error) {
      _error = error;
      _timer?.cancel();
      _timer = Timer(_errorDisplayDuration, () => setState(() => _timer = null));
    }
  }

  @override
  Widget build(BuildContext context) {
    final translator = ClerkAuth.translatorOf(context);
    return StreamBuilder<String>(
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
