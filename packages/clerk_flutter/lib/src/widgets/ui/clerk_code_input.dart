import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';

class ClerkCodeInput extends StatelessWidget {
  final bool open;
  final String? title;
  final String? subtitle;
  final Future<bool> Function(String) onSubmit;

  const ClerkCodeInput({
    super.key,
    required this.open,
    required this.onSubmit,
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Closeable(
      open: open,
      child: Padding(
        padding: horizontalPadding32 + verticalPadding8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title case String title)
              FittedBox(
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  style: ClerkTextStyle.inputLabel,
                ),
              ),
            if (subtitle case String subtitle)
              FittedBox(
                child: Text(
                  subtitle,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  style: ClerkTextStyle.inputLabel,
                ),
              ),
            verticalMargin4,
            MultiDigitCodeInput(onSubmit: onSubmit),
          ],
        ),
      ),
    );
  }
}
