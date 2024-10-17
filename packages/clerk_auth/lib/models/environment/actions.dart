import 'package:json_annotation/json_annotation.dart';

part 'actions.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Actions {
  static const empty = Actions();

  final bool deleteSelf;
  final bool createOrganization;
  final int? createOrganizationsLimit;

  const Actions({
    this.deleteSelf = false,
    this.createOrganization = false,
    this.createOrganizationsLimit = 0,
  });

  factory Actions.fromJson(Map<String, dynamic> json) => _$ActionsFromJson(json);

  Map<String, dynamic> toJson() => _$ActionsToJson(this);
}
