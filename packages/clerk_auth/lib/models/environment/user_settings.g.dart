// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSettings _$UserSettingsFromJson(Map<String, dynamic> json) => UserSettings(
      attributes: json['attributes'] == null
          ? UserAttributes.empty
          : UserAttributes.fromJson(json['attributes'] as Map<String, dynamic>),
      signIn: json['sign_in'] == null
          ? SignInSettings.empty
          : SignInSettings.fromJson(json['sign_in'] as Map<String, dynamic>),
      signUp: json['sign_up'] == null
          ? SignUpSettings.empty
          : SignUpSettings.fromJson(json['sign_up'] as Map<String, dynamic>),
      restrictions: json['restrictions'] == null
          ? Restrictions.empty
          : Restrictions.fromJson(json['restrictions'] as Map<String, dynamic>),
      usernameSettings: json['username_settings'] == null
          ? UsernameSettings.empty
          : UsernameSettings.fromJson(
              json['username_settings'] as Map<String, dynamic>),
      actions: json['actions'] == null
          ? Actions.empty
          : Actions.fromJson(json['actions'] as Map<String, dynamic>),
      attackProtection: json['attack_protection'] == null
          ? AttackProtection.empty
          : AttackProtection.fromJson(
              json['attack_protection'] as Map<String, dynamic>),
      passkeySettings: json['passkey_settings'] == null
          ? PasskeySettings.empty
          : PasskeySettings.fromJson(
              json['passkey_settings'] as Map<String, dynamic>),
      passwordSettings: json['password_settings'] == null
          ? PasswordSettings.empty
          : PasswordSettings.fromJson(
              json['password_settings'] as Map<String, dynamic>),
      socialSettings: json['social'] == null
          ? SocialSettings.empty
          : SocialSettings.fromJson(json['social'] as Map<String, dynamic>),
      saml: _readSamlEnabled(json, 'saml') as bool? ?? false,
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
