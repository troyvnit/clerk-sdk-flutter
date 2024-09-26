// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Actions _$ActionsFromJson(Map<String, dynamic> json) => Actions(
      deleteSelf: json['delete_self'] as bool,
      createOrganization: json['create_organization'] as bool,
      createOrganizationsLimit:
          (json['create_organizations_limit'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ActionsToJson(Actions instance) => <String, dynamic>{
      'delete_self': instance.deleteSelf,
      'create_organization': instance.createOrganization,
      'create_organizations_limit': instance.createOrganizationsLimit,
    };
