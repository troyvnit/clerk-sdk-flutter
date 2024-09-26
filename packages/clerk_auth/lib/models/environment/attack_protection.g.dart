// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attack_protection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttackProtection _$AttackProtectionFromJson(Map<String, dynamic> json) =>
    AttackProtection(
      userLockout:
          UserLockout.fromJson(json['user_lockout'] as Map<String, dynamic>),
      piiEnabled: _readPiiEnabled(json, 'pii_enabled') as bool,
      emailLinkRequireSameClient: _readEmailLinkRequireSameClient(
          json, 'email_link_require_same_client') as bool,
    );

Map<String, dynamic> _$AttackProtectionToJson(AttackProtection instance) =>
    <String, dynamic>{
      'user_lockout': instance.userLockout.toJson(),
      'pii_enabled': instance.piiEnabled,
      'email_link_require_same_client': instance.emailLinkRequireSameClient,
    };

UserLockout _$UserLockoutFromJson(Map<String, dynamic> json) => UserLockout(
      isEnabled: json['enabled'] as bool,
      maxAttempts: (json['max_attempts'] as num).toInt(),
      duration:
          Duration(microseconds: (json['duration_in_minutes'] as num).toInt()),
    );

Map<String, dynamic> _$UserLockoutToJson(UserLockout instance) =>
    <String, dynamic>{
      'max_attempts': instance.maxAttempts,
      'enabled': instance.isEnabled,
      'duration_in_minutes': _toDuration(instance.duration),
    };
