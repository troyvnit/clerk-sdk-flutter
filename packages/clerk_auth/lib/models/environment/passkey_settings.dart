import 'package:json_annotation/json_annotation.dart';

part 'passkey_settings.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class PasskeySettings {
  final bool allowAutofill;
  final bool showSignInButton;

  const PasskeySettings({
    required this.allowAutofill,
    required this.showSignInButton,
  });

  factory PasskeySettings.fromJson(Map<String, dynamic> json) => _$PasskeySettingsFromJson(json);

  Map<String, dynamic> toJson() => _$PasskeySettingsToJson(this);
}
