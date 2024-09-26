import 'package:clerk_auth/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'organization_settings.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class OrganizationSettings {
  final int maxAllowedMemberships;
  final String creatorRole;
  final OrganizationDomains domains;
  final OrganizationActions actions;

  @JsonKey(name: 'enabled')
  final bool isEnabled;

  const OrganizationSettings({
    required this.maxAllowedMemberships,
    required this.creatorRole,
    required this.actions,
    required this.domains,
    required this.isEnabled,
  });

  factory OrganizationSettings.fromJson(Map<String, dynamic> json) =>
      _$OrganizationSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationSettingsToJson(this);
}
