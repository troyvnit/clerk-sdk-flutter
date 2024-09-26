import 'package:clerk_auth/models/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'organization_domains.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class OrganizationDomains {
  final String defaultRole;
  final List<EnrollmentMode> enrollmentModes;

  @JsonKey(name: 'enabled')
  final bool isEnabled;

  const OrganizationDomains({
    required this.defaultRole,
    required this.enrollmentModes,
    required this.isEnabled,
  });

  factory OrganizationDomains.fromJson(Map<String, dynamic> json) =>
      _$OrganizationDomainsFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationDomainsToJson(this);
}
