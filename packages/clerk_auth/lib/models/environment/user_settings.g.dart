// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSettings _$UserSettingsFromJson(Map<String, dynamic> json) => UserSettings(
      attributes:
          UserAttributes.fromJson(json['attributes'] as Map<String, dynamic>),
      signIn: SignInSettings.fromJson(json['sign_in'] as Map<String, dynamic>),
      signUp: SignUpSettings.fromJson(json['sign_up'] as Map<String, dynamic>),
      restrictions:
          Restrictions.fromJson(json['restrictions'] as Map<String, dynamic>),
      usernameSettings: UsernameSettings.fromJson(
          json['username_settings'] as Map<String, dynamic>),
      actions: Actions.fromJson(json['actions'] as Map<String, dynamic>),
      attackProtection: AttackProtection.fromJson(
          json['attack_protection'] as Map<String, dynamic>),
      passkeySettings: PasskeySettings.fromJson(
          json['passkey_settings'] as Map<String, dynamic>),
      socialSettings:
          SocialSettings.fromJson(json['social'] as Map<String, dynamic>),
      passwordSettings: PasswordSettings.fromJson(
          json['password_settings'] as Map<String, dynamic>),
      saml: _readSamlEnabled(json, 'saml') as bool,
    );

Map<String, dynamic> _$UserSettingsToJson(UserSettings instance) =>
    <String, dynamic>{
      'attributes': instance.attributes.toJson(),
      'sign_in': instance.signIn.toJson(),
      'sign_up': instance.signUp.toJson(),
      'restrictions': instance.restrictions.toJson(),
      'username_settings': instance.usernameSettings.toJson(),
      'actions': instance.actions.toJson(),
      'attack_protection': instance.attackProtection.toJson(),
      'passkey_settings': instance.passkeySettings.toJson(),
      'password_settings': instance.passwordSettings.toJson(),
      'saml': instance.saml,
      'social': instance.socialSettings.toJson(),
    };
