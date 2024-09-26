import 'package:json_annotation/json_annotation.dart';

part 'username_settings.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class UsernameSettings {
  final int minLength;
  final int maxLength;

  const UsernameSettings({
    required this.minLength,
    required this.maxLength,
  });

  factory UsernameSettings.fromJson(Map<String, dynamic> json) => _$UsernameSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$UsernameSettingsToJson(this);
}
