import 'package:json_annotation/json_annotation.dart';

import '../../../models/models.dart';

part 'user_settings.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class UserSettings {
  final UserAttributes attributes;
  final SignInSettings signIn;
  final SignUpSettings signUp;
  final Restrictions restrictions;
  final UsernameSettings usernameSettings;
  final Actions actions;
  final AttackProtection attackProtection;
  final PasskeySettings passkeySettings;
  final PasswordSettings passwordSettings;

  @JsonKey(readValue: _readSamlEnabled)
  final bool saml;

  @JsonKey(name: 'social')
  final SocialSettings socialSettings;

  const UserSettings({
    required this.attributes,
    required this.signIn,
    required this.signUp,
    required this.restrictions,
    required this.usernameSettings,
    required this.actions,
    required this.attackProtection,
    required this.passkeySettings,
    required this.socialSettings,
    required this.passwordSettings,
    required this.saml,
  });

  factory UserSettings.fromJson(Map<String, dynamic> json) => _$UserSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$UserSettingsToJson(this);
}

bool _readSamlEnabled(map, _) => map['saml']?['enabled'] == true;
