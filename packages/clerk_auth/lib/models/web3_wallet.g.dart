// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web3_wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Web3Wallet _$Web3WalletFromJson(Map<String, dynamic> json) => Web3Wallet(
      id: json['id'] as String,
      web3Wallet: json['web3_wallet'] as String,
      verification:
          Verification.fromJson(json['verification'] as Map<String, dynamic>),
      updatedAt: intToDateTime(json['updated_at']),
      createdAt: intToDateTime(json['created_at']),
    );

Map<String, dynamic> _$Web3WalletToJson(Web3Wallet instance) =>
    <String, dynamic>{
      'id': instance.id,
      'web3_wallet': instance.web3Wallet,
      'verification': instance.verification.toJson(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
    };
