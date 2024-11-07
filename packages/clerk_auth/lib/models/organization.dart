import 'package:json_annotation/json_annotation.dart';

import 'helpers.dart';

part 'organization.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Organization {
  final String id;
  final String name;
  final int maxAllowedMemberships;
  final bool adminDeleteEnabled;
  final String slug;
  final String logoUrl;
  final String imageUrl;
  final bool hasImage;
  final int membersCount;
  final int pendingInvitationsCount;
  final Map<String, dynamic> publicMetadata;

  @JsonKey(fromJson: intToDateTime)
  final DateTime? updatedAt;

  @JsonKey(fromJson: intToDateTime)
  final DateTime? createdAt;

  Organization({
    required this.id,
    required this.name,
    required this.maxAllowedMemberships,
    required this.adminDeleteEnabled,
    required this.slug,
    required this.logoUrl,
    required this.imageUrl,
    required this.hasImage,
    required this.membersCount,
    required this.pendingInvitationsCount,
    required this.publicMetadata,
    required this.updatedAt,
    required this.createdAt,
  });

  factory Organization.fromJson(Map<String, dynamic> json) => _$OrganizationFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationToJson(this);
}
