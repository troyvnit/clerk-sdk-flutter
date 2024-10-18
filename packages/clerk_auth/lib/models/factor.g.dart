// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'factor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Factor _$FactorFromJson(Map<String, dynamic> json) => Factor(
      strategy: Strategy.fromJson(json['strategy'] as String),
      safeIdentifier: json['safe_identifier'] as String?,
      emailAddressId: json['email_address_id'] as String?,
      phoneNumberId: json['phone_number_id'] as String?,
      web3WalletId: json['web3_wallet_id'] as String?,
      passkeyId: json['passkey_id'] as String?,
      isPrimary: json['primary'] as bool? ?? false,
      isDefault: json['default'] as bool? ?? false,
    );

Map<String, dynamic> _$FactorToJson(Factor instance) => <String, dynamic>{
      'strategy': instance.strategy.toJson(),
      'safe_identifier': instance.safeIdentifier,
      'email_address_id': instance.emailAddressId,
      'phone_number_id': instance.phoneNumberId,
      'web3_wallet_id': instance.web3WalletId,
      'passkey_id': instance.passkeyId,
      'primary': instance.isPrimary,
      'default': instance.isDefault,
    };
