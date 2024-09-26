// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrganizationSettings _$OrganizationSettingsFromJson(
        Map<String, dynamic> json) =>
    OrganizationSettings(
      maxAllowedMemberships: (json['max_allowed_memberships'] as num).toInt(),
      creatorRole: json['creator_role'] as String,
      actions:
          OrganizationActions.fromJson(json['actions'] as Map<String, dynamic>),
      domains:
          OrganizationDomains.fromJson(json['domains'] as Map<String, dynamic>),
      isEnabled: json['enabled'] as bool,
    );

Map<String, dynamic> _$OrganizationSettingsToJson(
        OrganizationSettings instance) =>
    <String, dynamic>{
      'max_allowed_memberships': instance.maxAllowedMemberships,
      'creator_role': instance.creatorRole,
      'domains': instance.domains.toJson(),
      'actions': instance.actions.toJson(),
      'enabled': instance.isEnabled,
    };
