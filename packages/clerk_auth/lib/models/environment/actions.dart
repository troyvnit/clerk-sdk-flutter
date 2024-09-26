import 'package:json_annotation/json_annotation.dart';

import '../models.dart';

part 'actions.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Actions {
  final bool deleteSelf;
  final bool createOrganization;
  final int? createOrganizationsLimit;

  const Actions({
    required this.deleteSelf,
    required this.createOrganization,
    required this.createOrganizationsLimit,
  });

  factory Actions.fromJson(Map<String, dynamic> json) => _$ActionsFromJson(json);

  Map<String, dynamic> toJson() => _$ActionsToJson(this);
}
