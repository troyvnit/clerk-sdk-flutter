import 'package:json_annotation/json_annotation.dart';

import '../models.dart';

part 'password_settings.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class PasswordSettings {
  static const empty = PasswordSettings();

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
    this.allowedSpecialCharacters = '',
    this.minZxcvbnStrength = 0,
    this.minLength = 0,
    this.maxLength = 0,
    this.disableHibp = false,
    this.requireSpecialChar = false,
    this.requireNumbers = false,
    this.requireUppercase = false,
    this.requireLowercase = false,
    this.showZxcvbn = false,
    this.enforceHibpOnSignIn = false,
  });

  factory PasswordSettings.fromJson(Map<String, dynamic> json) => _$PasswordSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$PasswordSettingsToJson(this);
}
