import 'package:clerk_flutter/style/colors.dart';
import 'package:clerk_flutter/src/common.dart';
import 'package:flutter/material.dart';

/// Style of [ClerkMaterialButton].
///
enum ClerkMaterialButtonStyle {
  /// Light.
  light,

  /// Dark.
  dark;
}

/// A reusable and Clerk themed [MaterialButton].
///
@immutable
class ClerkMaterialButton extends StatelessWidget {
  /// Constructs a new [ClerkMaterialButton].
  const ClerkMaterialButton({
    super.key,
    this.onPressed,
    required this.label,
    this.style = ClerkMaterialButtonStyle.dark,
    this.elevation = 2.0,
  });

  /// Called when the button is tapped or otherwise activated.
  final VoidCallback? onPressed;

  /// [Widget] to be displayed in button.
  final Widget label;

  /// Light or dark styled button.
  final ClerkMaterialButtonStyle style;

  /// Elevation creating shadow effect.
  final double elevation;

  @override
  Widget build(BuildContext context) {
    final dark = style == ClerkMaterialButtonStyle.dark;
    final color = dark ? Colors.transparent : ClerkColors.white;
    final textColor = dark ? ClerkColors.white : ClerkColors.nobel;
    final child = DefaultTextStyle(
      style: TextStyle(
        color: textColor,
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        height: 1.0,
      ),
      child: IconTheme(
        data: IconThemeData(color: textColor, size: 16.0),
        child: Center(child: label),
      ),
    );
    return SizedBox(
      height: 32.0,
      child: FilledButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          backgroundColor: MaterialStateProperty.all(color),
          foregroundColor: MaterialStateProperty.all(textColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: borderRadius8,
              side: const BorderSide(color: ClerkColors.dawnPink),
            ),
          ),
        ),
        child: dark
            ? Ink(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [ClerkColors.charcoalGrey, ClerkColors.gunmetal],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: borderRadius8,
                ),
                child: child,
              )
            : child,
      ),
    );
  }
}
