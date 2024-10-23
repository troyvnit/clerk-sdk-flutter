import 'package:clerk_auth/clerk_auth.dart' as Clerk;
import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';

class ErrorMessage extends StatefulWidget {
  final Clerk.AuthError? error;

  const ErrorMessage({super.key, this.error});

  @override
  State<ErrorMessage> createState() => _ErrorMessageState();
}

class _ErrorMessageState extends State<ErrorMessage> {
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _setErrorMessage();
  }

  @override
  void didUpdateWidget(covariant ErrorMessage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setErrorMessage();
  }

  void _setErrorMessage() {
    if (widget.error case Clerk.AuthError error) {
      errorMessage = error.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Closeable(
      closed: widget.error is! Clerk.AuthError,
      child: Padding(
        padding: horizontalPadding32 + bottomPadding8,
        child: Text(
          errorMessage,
          textAlign: TextAlign.left,
          maxLines: 2,
          style: ClerkTextStyle.error,
        ),
      ),
    );
  }
}
