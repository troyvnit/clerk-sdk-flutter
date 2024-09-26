import 'package:json_annotation/json_annotation.dart';

import '../models.dart';

part 'password_settings.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class PasswordSettings {
  final String allowedSpecialCharacters;
  final int minZxcvbnStrength;
  final int minLength;
  final int maxLength;

  @JsonKey(fromJson: isTrue)
  final bool disableHibp;

  @JsonKey(fromJson: isTrue)
  final bool requireSpecialChar;

  @JsonKey(fromJson: isTrue)
  final bool requireNumbers;

  @JsonKey(fromJson: isTrue)
  final bool requireUppercase;

  @JsonKey(fromJson: isTrue)
  final bool requireLowercase;

  @JsonKey(fromJson: isTrue)
  final bool showZxcvbn;

  @JsonKey(fromJson: isTrue)
  final bool enforceHibpOnSignIn;

  const PasswordSettings({
    required this.allowedSpecialCharacters,
    required this.minZxcvbnStrength,
    required this.minLength,
    required this.maxLength,
    required this.disableHibp,
    required this.requireSpecialChar,
    required this.requireNumbers,
    required this.requireUppercase,
    required this.requireLowercase,
    required this.showZxcvbn,
    required this.enforceHibpOnSignIn,
  });

  factory PasswordSettings.fromJson(Map<String, dynamic> json) => _$PasswordSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$PasswordSettingsToJson(this);
}
