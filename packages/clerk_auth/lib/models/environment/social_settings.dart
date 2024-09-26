import 'package:json_annotation/json_annotation.dart';

import '../models.dart';

part 'social_settings.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class SocialSettings {
  @JsonKey(name: 'oauth_apple')
  final SocialEntity apple;

  @JsonKey(name: 'oauth_google')
  final SocialEntity google;

  @JsonKey(name: 'oauth_github')
  final SocialEntity github;

  const SocialSettings({
    required this.apple,
    required this.google,
    required this.github,
  });

  factory SocialSettings.fromJson(Map<String, dynamic> json) => _$SocialSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$SocialSettingsToJson(this);
}
