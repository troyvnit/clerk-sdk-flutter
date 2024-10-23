import 'package:clerk_flutter/assets.dart';
import 'package:clerk_flutter/src/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// A reusable and Clerk styled [TextFormField] for collecting phone numbers.
///
class ClerkPhoneNumberFormField extends StatelessWidget {
  /// Constructs a new [ClerkPhoneNumberFormField].
  const ClerkPhoneNumberFormField({
    super.key,
    this.showLabel = true,
    this.optional = false,
  });

  /// Show label?
  final bool showLabel;

  /// Is this field optional?
  final bool optional;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            if (showLabel) //
              const Text(
                'Phone number',
                textAlign: TextAlign.start,
                maxLines: 1,
              ),
            spacer,
            if (optional) //
              const Text(
                'Optional',
                textAlign: TextAlign.end,
                maxLines: 1,
              ),
          ],
        ),
        verticalMargin4,
        SizedBox(
          height: 32.0,
          child: ClipRRect(
            clipBehavior: Clip.antiAlias,
            borderRadius: borderRadius8,
            child: DecoratedBox(
              decoration: insetBoxShadowDecoration,
              child: TextFormField(
                decoration: InputDecoration(
                  border: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  focusedBorder: outlineInputBorder,
                  contentPadding: horizontalPadding8,
                  prefixIcon: Padding(
                    padding: leftPadding12 + rightPadding8,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('US'),
                        horizontalMargin12,
                        SvgPicture.asset(ClerkAssets.chevronUpDown, package: 'clerk_flutter'),
                        horizontalMargin12,
                        const Text('+1'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
