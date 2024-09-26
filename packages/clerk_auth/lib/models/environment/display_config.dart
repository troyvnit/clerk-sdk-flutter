import 'package:json_annotation/json_annotation.dart';

part 'display_config.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class DisplayConfig {
  final String id;
  final String applicationName;
  final bool branded;
  final bool experimentalForceOauthFirst;
  final bool showDevmodeWarning;
  final String? afterCreateOrganizationUrl;
  final String? afterLeaveOrganizationUrl;
  final String? afterSignInUrl;
  final String? afterSignOutAllUrl;
  final String? afterSignOutOneUrl;
  final String? afterSignUpUrl;
  final String? afterSwitchSessionUrl;
  final String? captchaProvider;
  final String? captchaPublicKeyInvisible;
  final String? captchaPublicKey;
  final String? captchaWidgetType;
  final String? clerkJsVersion;
  final String? createOrganizationUrl;
  final String? faviconImageUrl;
  final String? faviconImage;
  final String? faviconUrl;
  final String? googleOneTapClientId;
  final String? helpUrl;
  final String? homeUrl;
  final String? instanceEnvironmentType;
  final String? logoImageUrl;
  final String? logoImage;
  final String? logoLinkUrl;
  final String? logoUrl;
  final String? organizationProfileUrl;
  final String? preferredSignInStrategy;
  final String? privacyPolicyUrl;
  final String? signInUrl;
  final String? signUpUrl;
  final String? supportEmail;
  final String? termsUrl;
  final String? userProfileUrl;

  const DisplayConfig({
    required this.id,
    required this.applicationName,
    required this.branded,
    required this.experimentalForceOauthFirst,
    required this.showDevmodeWarning,
    required this.afterCreateOrganizationUrl,
    required this.afterLeaveOrganizationUrl,
    required this.afterSignInUrl,
    required this.afterSignOutAllUrl,
    required this.afterSignOutOneUrl,
    required this.afterSignUpUrl,
    required this.afterSwitchSessionUrl,
    required this.captchaProvider,
    required this.captchaPublicKeyInvisible,
    required this.captchaPublicKey,
    required this.captchaWidgetType,
    required this.clerkJsVersion,
    required this.createOrganizationUrl,
    required this.faviconImageUrl,
    required this.faviconImage,
    required this.faviconUrl,
    required this.googleOneTapClientId,
    required this.helpUrl,
    required this.homeUrl,
    required this.instanceEnvironmentType,
    required this.logoImageUrl,
    required this.logoImage,
    required this.logoLinkUrl,
    required this.logoUrl,
    required this.organizationProfileUrl,
    required this.preferredSignInStrategy,
    required this.privacyPolicyUrl,
    required this.signInUrl,
    required this.signUpUrl,
    required this.supportEmail,
    required this.termsUrl,
    required this.userProfileUrl,
  });

  factory DisplayConfig.fromJson(Map<String, dynamic> json) => _$DisplayConfigFromJson(json);

  Map<String, dynamic> toJson() => _$DisplayConfigToJson(this);
}
