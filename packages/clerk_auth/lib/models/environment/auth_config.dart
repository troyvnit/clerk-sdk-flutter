import 'package:json_annotation/json_annotation.dart';

import '../models.dart';

part 'auth_config.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class AuthConfig {
  final String id;
  final bool singleSessionMode;
  final bool enhancedEmailDeliverability;
  final bool testMode;
  final bool demo;
  final bool cookielessDev;
  final bool urlBasedSessionSyncing;
  final List<IdentificationStrategy> identificationStrategies;
  final List<Strategy> firstFactors;
  final List<Strategy> secondFactors;
  final List<Strategy> emailAddressVerificationStrategies;

  @JsonKey(name: 'first_name', fromJson: isOn)
  final bool usesFirstName;

  @JsonKey(name: 'last_name', fromJson: isOn)
  final bool usesLastName;

  @JsonKey(name: 'email_address', fromJson: isOn)
  final bool usesEmailAddress;

  @JsonKey(name: 'phone_number', fromJson: isOn)
  final bool usesPhoneNumber;

  @JsonKey(name: 'username', fromJson: isOn)
  final bool usesUsername;

  @JsonKey(name: 'password', fromJson: isOn)
  final bool usesPassword;

  const AuthConfig({
    required this.id,
    required this.singleSessionMode,
    required this.enhancedEmailDeliverability,
    required this.testMode,
    required this.demo,
    required this.cookielessDev,
    required this.urlBasedSessionSyncing,
    required this.identificationStrategies,
    required this.firstFactors,
    required this.secondFactors,
    required this.emailAddressVerificationStrategies,
    required this.usesFirstName,
    required this.usesLastName,
    required this.usesEmailAddress,
    required this.usesPhoneNumber,
    required this.usesUsername,
    required this.usesPassword,
  });

  factory AuthConfig.fromJson(Map<String, dynamic> json) => _$AuthConfigFromJson(json);

  Map<String, dynamic> toJson() => _$AuthConfigToJson(this);
}
