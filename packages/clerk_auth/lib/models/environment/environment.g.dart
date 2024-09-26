// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'environment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Environment _$EnvironmentFromJson(Map<String, dynamic> json) => Environment(
      auth: AuthConfig.fromJson(json['auth_config'] as Map<String, dynamic>),
      display: DisplayConfig.fromJson(
          json['display_config'] as Map<String, dynamic>),
      user:
          UserSettings.fromJson(json['user_settings'] as Map<String, dynamic>),
      organization: OrganizationSettings.fromJson(
          json['organization_settings'] as Map<String, dynamic>),
      maintenanceMode: json['maintenance_mode'] as bool,
    );

Map<String, dynamic> _$EnvironmentToJson(Environment instance) =>
    <String, dynamic>{
      'auth_config': instance.auth.toJson(),
      'display_config': instance.display.toJson(),
      'user_settings': instance.user.toJson(),
      'organization_settings': instance.organization.toJson(),
      'maintenance_mode': instance.maintenanceMode,
    };
