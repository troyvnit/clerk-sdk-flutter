// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocialEntity _$SocialEntityFromJson(Map<String, dynamic> json) => SocialEntity(
      isEnabled: json['enabled'] == null ? false : isTrue(json['enabled']),
      isRequired: json['required'] == null ? false : isTrue(json['required']),
      authenticatable: json['authenticatable'] == null
          ? false
          : isTrue(json['authenticatable']),
      blockEmailSubaddresses: json['block_email_subaddresses'] == null
          ? false
          : isTrue(json['block_email_subaddresses']),
      strategy: $enumDecodeNullable(_$StrategyEnumMap, json['strategy']) ??
          Strategy.admin,
      notSelectable: json['non_selectable'] == null
          ? false
          : isTrue(json['non_selectable']),
      deprecated:
          json['deprecated'] == null ? false : isTrue(json['deprecated']),
      name: json['name'] as String? ?? '',
      logoUrl: json['logo_url'] as String? ?? '',
    );

Map<String, dynamic> _$SocialEntityToJson(SocialEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'logo_url': instance.logoUrl,
      'strategy': _$StrategyEnumMap[instance.strategy]!,
      'enabled': instance.isEnabled,
      'required': instance.isRequired,
      'authenticatable': instance.authenticatable,
      'block_email_subaddresses': instance.blockEmailSubaddresses,
      'non_selectable': instance.notSelectable,
      'deprecated': instance.deprecated,
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
