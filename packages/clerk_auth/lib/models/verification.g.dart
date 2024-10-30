// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Verification _$VerificationFromJson(Map<String, dynamic> json) => Verification(
      status: $enumDecode(_$StatusEnumMap, json['status']),
      strategy: Strategy.fromJson(json['strategy'] as String),
      attempts: (json['attempts'] as num?)?.toInt(),
      expireAt: intToDateTime(json['expire_at']),
      providerUrl: json['external_verification_redirect_url'] as String?,
      nonce: json['nonce'] as String?,
    );

Map<String, dynamic> _$VerificationToJson(Verification instance) =>
    <String, dynamic>{
      'status': _$StatusEnumMap[instance.status]!,
      'strategy': instance.strategy.toJson(),
      'attempts': instance.attempts,
      'nonce': instance.nonce,
      'external_verification_redirect_url': instance.providerUrl,
      'expire_at': instance.expireAt?.toIso8601String(),
    };

const _$StatusEnumMap = {
  Status.abandoned: 'abandoned',
  Status.active: 'active',
  Status.missingRequirements: 'missing_requirements',
  Status.needsIdentifier: 'needs_identifier',
  Status.needsFirstFactor: 'needs_first_factor',
  Status.needsSecondFactor: 'needs_second_factor',
  Status.transferable: 'transferable',
  Status.unverified: 'unverified',
  Status.verified: 'verified',
  Status.complete: 'complete',
};
