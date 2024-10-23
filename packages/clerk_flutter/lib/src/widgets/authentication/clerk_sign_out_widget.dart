import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:clerk_flutter/src/common.dart';
import 'package:clerk_flutter/src/widgets/ui/clerk_material_button.dart';
import 'package:flutter/material.dart';

/// The [ClerkSignOutWidget] renders a UI for signing out users.
///
@immutable
class ClerkSignOutWidget extends StatelessWidget {
  /// Constructs a new [ClerkSignOutWidget].
  const ClerkSignOutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = ClerkAuth.of(context);
    return Padding(
      padding: horizontalPadding16,
      child: ClerkMaterialButton(
        onPressed: () => auth.signOut(),
        label: const Text('Sign Out'),
      ),
    );
  }
}
