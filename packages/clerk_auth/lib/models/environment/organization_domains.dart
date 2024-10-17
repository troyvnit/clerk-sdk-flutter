import 'package:clerk_auth/models/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'organization_domains.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class OrganizationDomains {
  static const empty = OrganizationDomains();

  final String defaultRole;
  final List<EnrollmentMode> enrollmentModes;

  @JsonKey(name: 'enabled')
  final bool isEnabled;

  const OrganizationDomains({
    this.defaultRole = '',
    this.enrollmentModes = const [],
    this.isEnabled = false,
  });

  factory OrganizationDomains.fromJson(Map<String, dynamic> json) =>
      _$OrganizationDomainsFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationDomainsToJson(this);
}
