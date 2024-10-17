import 'package:json_annotation/json_annotation.dart';

import '../models.dart';

part 'social_settings.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class SocialSettings {
  static const empty = SocialSettings();

  @JsonKey(name: 'oauth_apple')
  final SocialEntity apple;

  @JsonKey(name: 'oauth_google')
  final SocialEntity google;

  @JsonKey(name: 'oauth_github')
  final SocialEntity github;

  const SocialSettings({
    this.apple = SocialEntity.empty,
    this.google = SocialEntity.empty,
    this.github = SocialEntity.empty,
  });

  factory SocialSettings.fromJson(Map<String, dynamic> json) => _$SocialSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$SocialSettingsToJson(this);
}
