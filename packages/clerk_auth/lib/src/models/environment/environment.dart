import 'package:clerk_auth/clerk_auth.dart';
import 'package:clerk_auth/src/models/informative_to_string_mixin.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'environment.g.dart';

/// [Environment] Clerk object
@immutable
@JsonSerializable()
class Environment with InformativeToStringMixin {
  /// Construction
  const Environment({
    this.config = Config.empty,
    this.display = DisplayConfig.empty,
    this.user = UserSettings.empty,
    this.organization = OrganizationSettings.empty,
    this.maintenanceMode = false,
  });

  /// auth config
  @JsonKey(name: 'auth_config')
  final Config config;

  /// display config
  @JsonKey(name: 'display_config')
  final DisplayConfig display;

  /// user settings
  @JsonKey(name: 'user_settings')
  final UserSettings user;

  /// organization settings
  @JsonKey(name: 'organization_settings')
  final OrganizationSettings organization;

  /// maintenance mode?
  final bool maintenanceMode;

  /// isEmpty?
  bool get isEmpty => this == empty;

  /// is not empty?
  bool get isNotEmpty => isEmpty == false;

  /// empty [Environment]
  static const empty = Environment();

  /// Do we have [Strategy.password] configured?
  bool get hasPasswordStrategy =>
      config.firstFactors.contains(Strategy.password);

  /// [List] of identification strategies
  List<Strategy> get strategies => config.identificationStrategies;

  /// [Iterable] of non-oauth and non-phone identification strategies
  Iterable<Strategy> get identificationStrategies => strategies.where(
        (i) => const [
          Strategy.emailAddress,
          Strategy.username,
          Strategy.phoneNumber
        ].contains(i),
      );

  /// Do we have identification strategies?
  bool get hasIdentificationStrategies => identificationStrategies.isNotEmpty;

  /// [Iterable] of oauth identification strategies
  Iterable<Strategy> get oauthStrategies => strategies.where((i) => i.isOauth);

  /// Do we have oauth strategies?
  bool get hasOauthStrategies => oauthStrategies.isNotEmpty;

  bool _supports(UserAttribute attr, Strategy strategy) =>
      user.attributes[attr]?.verifications.contains(strategy) == true;

  /// Can we verify email verification with [Strategy.emailCode]?
  bool get supportsEmailCode =>
      _supports(UserAttribute.emailAddress, Strategy.emailCode);

  /// Can we verify email verification with [Strategy.emailLink]?
  bool get supportsEmailLink =>
      _supports(UserAttribute.emailAddress, Strategy.emailLink);

  /// Can we verify phone verification with [Strategy.phoneCode]?
  bool get supportsPhoneCode =>
      _supports(UserAttribute.phoneNumber, Strategy.phoneCode);

  /// [Iterable] of other strategies
  /// i.e. strategies that are neither oauth nor password-based
  Iterable<Strategy> get otherStrategies =>
      strategies.where((f) => f.isOtherStrategy);

  /// Do we have other strategies?
  bool get hasOtherStrategies => otherStrategies.isNotEmpty;

  /// fromJson
  static Environment fromJson(Map<String, dynamic> json) =>
      _$EnvironmentFromJson(json);

  /// toJson
  @override
  Map<String, dynamic> toJson() => _$EnvironmentToJson(this);
}
