import 'package:flutter/foundation.dart';

/// Clerk-approved assets.
///
@immutable
class ClerkAssets {
  const ClerkAssets._();

  static const String _kAssetsPath = 'packages/clerk_flutter/assets/';

  /// Secured by Clerk logo.
  static const String securedByClerkLogo = '$_kAssetsPath/secured-by-clerk.svg';

  /// Default organization logo.
  static const String defaultOrganizationLogo =
      '$_kAssetsPath/default-organization-logo.svg';

  /// Google logo.
  static const String googleLogo = '$_kAssetsPath/google-logo.svg';

  /// Facebook logo.
  static const String facebookLogo = '$_kAssetsPath/facebook-logo.svg';

  /// Github logo.
  static const String githubLogo = '$_kAssetsPath/github-logo.svg';

  /// Chevron up down.
  static const String chevronUpDown = '$_kAssetsPath/chevron-up-down.svg';
}
