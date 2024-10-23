import 'package:clerk_flutter/src/common.dart';
import 'package:clerk_flutter/src/widgets/ui/style/colors.dart';
import 'package:clerk_flutter/src/widgets/ui/style/text_style.dart';
import 'package:flutter/material.dart';

/// A reusable and Clerk styled [TextFormField].
///
class ClerkTextFormField extends StatelessWidget {
  /// Constructs a new [ClerkTextFormField].
  const ClerkTextFormField({
    super.key,
    this.label,
    this.optional = false,
    this.obscureText = false,
    required this.onChanged,
    this.onSubmit,
  });

  /// Report changes back to calling widget
  final ValueChanged<String> onChanged;

  /// Callback for when field submitted
  final ValueChanged<String>? onSubmit;

  /// Optional label.
  final String? label;

  /// Is this field optional?
  final bool optional;

  /// can we see the text or not?
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (label case String label) //
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  label,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  style: ClerkTextStyle.inputLabel,
                ),
              ),
            spacer,
            if (optional) //
              Text(
                'Optional',
                textAlign: TextAlign.end,
                maxLines: 1,
                style: ClerkTextStyle.inputLabel.copyWith(
                  color: ClerkColors.stormGrey,
                  fontSize: 12.0,
                ),
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
                onChanged: onChanged,
                onFieldSubmitted: onSubmit,
                obscureText: obscureText,
                decoration: const InputDecoration(
                  border: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  focusedBorder: outlineInputBorder,
                  contentPadding: horizontalPadding8,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
