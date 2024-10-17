import 'package:clerk_auth/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'organization_settings.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class OrganizationSettings {
  static const empty = OrganizationSettings();

  final int maxAllowedMemberships;
  final String creatorRole;
  final OrganizationDomains domains;
  final OrganizationActions actions;

  @JsonKey(name: 'enabled')
  final bool isEnabled;

  const OrganizationSettings({
    this.maxAllowedMemberships = 0,
    this.creatorRole = '',
    this.actions = OrganizationActions.empty,
    this.domains = OrganizationDomains.empty,
    this.isEnabled = false,
  });

  factory OrganizationSettings.fromJson(Map<String, dynamic> json) =>
      _$OrganizationSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationSettingsToJson(this);
}
