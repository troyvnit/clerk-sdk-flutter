import 'package:flutter/material.dart';

/// A button that says "Cool Button".
///
///This is here purely for demonstration purposes.
///
@immutable
class CoolButton extends StatelessWidget {
  /// Constructs a const [CoolButton].
  const CoolButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: const Text('Cool Button'),
    );
  }
}
