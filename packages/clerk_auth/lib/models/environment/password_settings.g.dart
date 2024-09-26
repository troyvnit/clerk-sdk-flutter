// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PasswordSettings _$PasswordSettingsFromJson(Map<String, dynamic> json) =>
    PasswordSettings(
      allowedSpecialCharacters: json['allowed_special_characters'] as String,
      minZxcvbnStrength: (json['min_zxcvbn_strength'] as num).toInt(),
      minLength: (json['min_length'] as num).toInt(),
      maxLength: (json['max_length'] as num).toInt(),
      disableHibp: isTrue(json['disable_hibp']),
      requireSpecialChar: isTrue(json['require_special_char']),
      requireNumbers: isTrue(json['require_numbers']),
      requireUppercase: isTrue(json['require_uppercase']),
      requireLowercase: isTrue(json['require_lowercase']),
      showZxcvbn: isTrue(json['show_zxcvbn']),
      enforceHibpOnSignIn: isTrue(json['enforce_hibp_on_sign_in']),
    );

Map<String, dynamic> _$PasswordSettingsToJson(PasswordSettings instance) =>
    <String, dynamic>{
      'allowed_special_characters': instance.allowedSpecialCharacters,
      'min_zxcvbn_strength': instance.minZxcvbnStrength,
      'min_length': instance.minLength,
      'max_length': instance.maxLength,
      'disable_hibp': instance.disableHibp,
      'require_special_char': instance.requireSpecialChar,
      'require_numbers': instance.requireNumbers,
      'require_uppercase': instance.requireUppercase,
      'require_lowercase': instance.requireLowercase,
      'show_zxcvbn': instance.showZxcvbn,
      'enforce_hibp_on_sign_in': instance.enforceHibpOnSignIn,
    };
