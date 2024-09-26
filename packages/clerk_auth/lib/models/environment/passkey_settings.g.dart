// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passkey_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PasskeySettings _$PasskeySettingsFromJson(Map<String, dynamic> json) =>
    PasskeySettings(
      allowAutofill: json['allow_autofill'] as bool,
      showSignInButton: json['show_sign_in_button'] as bool,
    );

Map<String, dynamic> _$PasskeySettingsToJson(PasskeySettings instance) =>
    <String, dynamic>{
      'allow_autofill': instance.allowAutofill,
      'show_sign_in_button': instance.showSignInButton,
    };
