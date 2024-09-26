import 'package:json_annotation/json_annotation.dart';

part 'sign_up_settings.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class SignUpSettings {
  final bool captchaEnabled;
  final String captchaWidgetType;
  final bool customActionRequired;
  final bool progressive;
  final String mode;
  final bool legalConsentEnabled;

  const SignUpSettings({
    required this.captchaEnabled,
    required this.captchaWidgetType,
    required this.customActionRequired,
    required this.progressive,
    required this.mode,
    required this.legalConsentEnabled,
  });

  factory SignUpSettings.fromJson(Map<String, dynamic> json) => _$SignUpSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpSettingsToJson(this);
}
