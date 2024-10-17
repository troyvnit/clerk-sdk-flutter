// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthConfig _$AuthConfigFromJson(Map<String, dynamic> json) => AuthConfig(
      id: json['id'] as String? ?? '',
      singleSessionMode: json['single_session_mode'] as bool? ?? false,
      enhancedEmailDeliverability:
          json['enhanced_email_deliverability'] as bool? ?? false,
      testMode: json['test_mode'] as bool? ?? false,
      demo: json['demo'] as bool? ?? false,
      cookielessDev: json['cookieless_dev'] as bool? ?? false,
      urlBasedSessionSyncing:
          json['url_based_session_syncing'] as bool? ?? false,
      identificationStrategies:
          (json['identification_strategies'] as List<dynamic>?)
                  ?.map((e) => $enumDecode(_$IdentificationStrategyEnumMap, e))
                  .toList() ??
              const [],
      firstFactors: (json['first_factors'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$StrategyEnumMap, e))
              .toList() ??
          const [],
      secondFactors: (json['second_factors'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$StrategyEnumMap, e))
              .toList() ??
          const [],
      emailAddressVerificationStrategies:
          (json['email_address_verification_strategies'] as List<dynamic>?)
                  ?.map((e) => $enumDecode(_$StrategyEnumMap, e))
                  .toList() ??
              const [],
      usesFirstName:
          json['first_name'] == null ? false : isOn(json['first_name']),
      usesLastName: json['last_name'] == null ? false : isOn(json['last_name']),
      usesEmailAddress:
          json['email_address'] == null ? false : isOn(json['email_address']),
      usesPhoneNumber:
          json['phone_number'] == null ? false : isOn(json['phone_number']),
      usesUsername: json['username'] == null ? false : isOn(json['username']),
      usesPassword: json['password'] == null ? false : isOn(json['password']),
    );

Map<String, dynamic> _$AuthConfigToJson(AuthConfig instance) =>
    <String, dynamic>{
      'id': instance.id,
      'single_session_mode': instance.singleSessionMode,
      'enhanced_email_deliverability': instance.enhancedEmailDeliverability,
      'test_mode': instance.testMode,
      'demo': instance.demo,
      'cookieless_dev': instance.cookielessDev,
      'url_based_session_syncing': instance.urlBasedSessionSyncing,
      'identification_strategies': instance.identificationStrategies
          .map((e) => _$IdentificationStrategyEnumMap[e]!)
          .toList(),
      'first_factors':
          instance.firstFactors.map((e) => _$StrategyEnumMap[e]!).toList(),
      'second_factors':
          instance.secondFactors.map((e) => _$StrategyEnumMap[e]!).toList(),
      'email_address_verification_strategies': instance
          .emailAddressVerificationStrategies
          .map((e) => _$StrategyEnumMap[e]!)
          .toList(),
      'first_name': instance.usesFirstName,
      'last_name': instance.usesLastName,
      'email_address': instance.usesEmailAddress,
      'phone_number': instance.usesPhoneNumber,
      'username': instance.usesUsername,
      'password': instance.usesPassword,
    };

const _$IdentificationStrategyEnumMap = {
  IdentificationStrategy.emailAddress: 'email_address',
  IdentificationStrategy.oauthApple: 'oauth_apple',
  IdentificationStrategy.oauthGithub: 'oauth_github',
  IdentificationStrategy.oauthGoogle: 'oauth_google',
  IdentificationStrategy.phoneNumber: 'phone_number',
  IdentificationStrategy.username: 'username',
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
