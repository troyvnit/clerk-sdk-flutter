// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_attribute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAttribute _$UserAttributeFromJson(Map<String, dynamic> json) =>
    UserAttribute(
      isEnabled:
          json['is_enabled'] == null ? false : isTrue(json['is_enabled']),
      isRequired:
          json['is_required'] == null ? false : isTrue(json['is_required']),
      usedForFirstFactor: json['used_for_first_factor'] == null
          ? false
          : isTrue(json['used_for_first_factor']),
      firstFactors: (json['first_factors'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$StrategyEnumMap, e))
              .toList() ??
          const [],
      userForSecondFactor: json['user_for_second_factor'] == null
          ? false
          : isTrue(json['user_for_second_factor']),
      secondFactors: (json['second_factors'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$StrategyEnumMap, e))
              .toList() ??
          const [],
      verifyAtSignUp: json['verify_at_sign_up'] == null
          ? false
          : isTrue(json['verify_at_sign_up']),
      verifications: (json['verifications'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$StrategyEnumMap, e))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UserAttributeToJson(UserAttribute instance) =>
    <String, dynamic>{
      'first_factors':
          instance.firstFactors.map((e) => _$StrategyEnumMap[e]!).toList(),
      'second_factors':
          instance.secondFactors.map((e) => _$StrategyEnumMap[e]!).toList(),
      'verifications':
          instance.verifications.map((e) => _$StrategyEnumMap[e]!).toList(),
      'used_for_first_factor': instance.usedForFirstFactor,
      'user_for_second_factor': instance.userForSecondFactor,
      'verify_at_sign_up': instance.verifyAtSignUp,
      'is_enabled': instance.isEnabled,
      'is_required': instance.isRequired,
    };

const _$StrategyEnumMap = {
  Strategy.admin: 'admin',
  Strategy.emailCode: 'email_code',
  Strategy.emailLink: 'email_link',
  Strategy.oauthApple: 'oauth_apple',
  Strategy.oauthGoogle: 'oauth_google',
  Strategy.oauthGithub: 'oauth_github',
  Strategy.oauthTokenApple: 'oauth_token_apple',
  Strategy.passkey: 'passkey',
  Strategy.password: 'password',
  Strategy.phoneCode: 'phone_code',
  Strategy.resetPasswordEmailCode: 'reset_password_email_code',
  Strategy.resetPasswordPhoneCode: 'reset_password_phone_code',
  Strategy.saml: 'saml',
  Strategy.ticket: 'ticket',
  Strategy.web3MetamaskSignature: 'web3_metamask_signature',
  Strategy.web3CoinbaseSignature: 'web3_coinbase_signature',
};
