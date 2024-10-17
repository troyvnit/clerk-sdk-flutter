import 'package:json_annotation/json_annotation.dart';

part 'username_settings.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class UsernameSettings {
  static const empty = UsernameSettings();

  final int minLength;
  final int maxLength;

  const UsernameSettings({
    this.minLength = 0,
    this.maxLength = 0,
  });

  factory UsernameSettings.fromJson(Map<String, dynamic> json) => _$UsernameSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$UsernameSettingsToJson(this);
}
