import 'package:json_annotation/json_annotation.dart';

import '../models.dart';

part 'sign_in_settings.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class SignInSettings {
  @JsonKey(readValue: _readSecondFactorRequired)
  final bool secondFactorRequired;

  const SignInSettings({
    required this.secondFactorRequired,
  });

  factory SignInSettings.fromJson(Map<String, dynamic> json) => _$SignInSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$SignInSettingsToJson(this);
}

bool _readSecondFactorRequired(map, _) => isTrue(map['second_factor']?['required']);
