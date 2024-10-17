import 'package:json_annotation/json_annotation.dart';

part 'organization_actions.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class OrganizationActions {
  static const empty = OrganizationActions();

  final bool adminDelete;

  const OrganizationActions({
    this.adminDelete = false,
  });

  factory OrganizationActions.fromJson(Map<String, dynamic> json) =>
      _$OrganizationActionsFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationActionsToJson(this);
}
