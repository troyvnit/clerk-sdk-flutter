import 'package:json_annotation/json_annotation.dart';

import '../../../models/models.dart';

part 'user_settings.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class UserSettings {
  static const empty = UserSettings();

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
  final Map<String, SocialConnection> socialSettings;

  const UserSettings({
    this.attributes = UserAttributes.empty,
    this.signIn = SignInSettings.empty,
    this.signUp = SignUpSettings.empty,
    this.restrictions = Restrictions.empty,
    this.usernameSettings = UsernameSettings.empty,
    this.actions = Actions.empty,
    this.attackProtection = AttackProtection.empty,
    this.passkeySettings = PasskeySettings.empty,
    this.passwordSettings = PasswordSettings.empty,
    this.socialSettings = const {},
    this.saml = false,
  });

  factory UserSettings.fromJson(Map<String, dynamic> json) => _$UserSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$UserSettingsToJson(this);
}

bool _readSamlEnabled(map, _) => map['saml']?['enabled'] == true;
