// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
      id: json['id'] as String,
      status: $enumDecode(_$StatusEnumMap, json['status']),
      lastActiveAt: DateTime.fromMillisecondsSinceEpoch(
          (json['last_active_at'] as num).toInt()),
      expireAt: DateTime.fromMillisecondsSinceEpoch(
          (json['expire_at'] as num).toInt()),
      abandonAt: DateTime.fromMillisecondsSinceEpoch(
          (json['abandon_at'] as num).toInt()),
      publicUserData:
          UserPublic.fromJson(json['public_user_data'] as Map<String, dynamic>),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      lastActiveToken: json['last_active_token'] == null
          ? null
          : SessionToken.fromJson(
              json['last_active_token'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'id': instance.id,
      'status': _$StatusEnumMap[instance.status]!,
      'public_user_data': instance.publicUserData.toJson(),
      'last_active_token': instance.lastActiveToken?.toJson(),
      'user': instance.user.toJson(),
      'last_active_at': instance.lastActiveAt.toIso8601String(),
      'expire_at': instance.expireAt.toIso8601String(),
      'abandon_at': instance.abandonAt.toIso8601String(),
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
