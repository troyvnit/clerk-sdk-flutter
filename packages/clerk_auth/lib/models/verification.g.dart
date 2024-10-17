// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Verification _$VerificationFromJson(Map<String, dynamic> json) => Verification(
      status: $enumDecode(_$StatusEnumMap, json['status']),
      strategy: $enumDecode(_$StrategyEnumMap, json['strategy']),
      attempts: (json['attempts'] as num?)?.toInt(),
      expireAt:
          Verification._convertDateTime((json['expire_at'] as num?)?.toInt()),
      nonce: json['nonce'] as String?,
    );

Map<String, dynamic> _$VerificationToJson(Verification instance) =>
    <String, dynamic>{
      'status': _$StatusEnumMap[instance.status]!,
      'strategy': _$StrategyEnumMap[instance.strategy]!,
      'attempts': instance.attempts,
      'nonce': instance.nonce,
      'expire_at': instance.expireAt?.toIso8601String(),
    };

const _$StatusEnumMap = {
  Status.abandoned: 'abandoned',
  Status.active: 'active',
  Status.missingRequirements: 'missing_requirements',
  Status.needsFirstFactor: 'needs_first_factor',
  Status.needsSecondFactor: 'needs_second_factor',
  Status.unverified: 'unverified',
  Status.verified: 'verified',
  Status.complete: 'complete',
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
