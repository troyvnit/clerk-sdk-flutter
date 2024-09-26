// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocialEntity _$SocialEntityFromJson(Map<String, dynamic> json) => SocialEntity(
      isEnabled: isTrue(json['enabled']),
      isRequired: isTrue(json['required']),
      authenticatable: isTrue(json['authenticatable']),
      blockEmailSubaddresses: isTrue(json['block_email_subaddresses']),
      strategy: $enumDecode(_$StrategyEnumMap, json['strategy']),
      notSelectable: isTrue(json['non_selectable']),
      deprecated: isTrue(json['deprecated']),
      name: json['name'] as String,
      logoUrl: json['logo_url'] as String,
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
