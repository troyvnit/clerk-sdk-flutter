import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'organization_membership.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class OrganizationMembership {
  final String id;
  final String role;
  final Organization organization;
  final UserPublic publicUserData;

  @JsonKey(fromJson: intToDateTime)
  final DateTime? updatedAt;

  @JsonKey(fromJson: intToDateTime)
  final DateTime? createdAt;

  OrganizationMembership({
    required this.id,
    required this.role,
    required this.updatedAt,
    required this.createdAt,
    required this.organization,
    required this.publicUserData,
  });

  factory OrganizationMembership.fromJson(Map<String, dynamic> json) =>
      _$OrganizationMembershipFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationMembershipToJson(this);
}
