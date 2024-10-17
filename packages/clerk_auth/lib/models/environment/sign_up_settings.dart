import 'package:json_annotation/json_annotation.dart';

part 'sign_up_settings.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class SignUpSettings {
  static const empty = SignUpSettings();

  final bool captchaEnabled;
  final String captchaWidgetType;
  final bool customActionRequired;
  final bool progressive;
  final String mode;
  final bool legalConsentEnabled;

  const SignUpSettings({
    this.captchaEnabled = false,
    this.captchaWidgetType = '',
    this.customActionRequired = false,
    this.progressive = false,
    this.mode = '',
    this.legalConsentEnabled = false,
  });

  factory SignUpSettings.fromJson(Map<String, dynamic> json) => _$SignUpSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpSettingsToJson(this);
}
