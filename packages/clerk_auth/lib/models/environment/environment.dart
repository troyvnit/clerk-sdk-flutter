import 'package:json_annotation/json_annotation.dart';

import '../models.dart';

part 'environment.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Environment {
  static final empty = Environment();

  @JsonKey(name: 'auth_config')
  final AuthConfig config;

  @JsonKey(name: 'display_config')
  final DisplayConfig display;

  @JsonKey(name: 'user_settings')
  final UserSettings user;

  @JsonKey(name: 'organization_settings')
  final OrganizationSettings organization;

  final bool maintenanceMode;

  const Environment({
    this.config = AuthConfig.empty,
    this.display = DisplayConfig.empty,
    this.user = UserSettings.empty,
    this.organization = OrganizationSettings.empty,
    this.maintenanceMode = false,
  });

  bool get isEmpty => this == empty;

  factory Environment.fromJson(Map<String, dynamic> json) => _$EnvironmentFromJson(json);

  Map<String, dynamic> toJson() => _$EnvironmentToJson(this);
}
