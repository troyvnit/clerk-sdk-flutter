import 'package:json_annotation/json_annotation.dart';

part 'organization_actions.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class OrganizationActions {
  final bool adminDelete;

  const OrganizationActions({
    required this.adminDelete,
  });

  factory OrganizationActions.fromJson(Map<String, dynamic> json) =>
      _$OrganizationActionsFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationActionsToJson(this);
}
