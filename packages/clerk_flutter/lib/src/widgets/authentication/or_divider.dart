import 'package:clerk_flutter/src/common.dart';
import 'package:clerk_flutter/style/colors.dart';
import 'package:clerk_flutter/style/text_style.dart';
import 'package:flutter/material.dart';

/// A reusable divider with the text 'or' in the middle. Meant to divide vertical content.
///
@immutable
class OrDivider extends StatelessWidget {
  /// Constructs a new [OrDivider].
  const OrDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(color: ClerkColors.whiteSmoke),
        ),
        horizontalMargin24,
        Text('or', style: ClerkTextStyle.subtitle.copyWith(fontSize: 12.0)),
        horizontalMargin24,
        const Expanded(
          child: const Divider(color: ClerkColors.whiteSmoke),
        ),
      ],
    );
  }
}
