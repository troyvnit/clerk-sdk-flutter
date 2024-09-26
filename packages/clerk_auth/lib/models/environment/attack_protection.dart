import 'package:json_annotation/json_annotation.dart';

part 'attack_protection.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class AttackProtection {
  final UserLockout userLockout;

  @JsonKey(readValue: _readPiiEnabled)
  final bool piiEnabled;

  @JsonKey(readValue: _readEmailLinkRequireSameClient)
  final bool emailLinkRequireSameClient;

  const AttackProtection({
    required this.userLockout,
    required this.piiEnabled,
    required this.emailLinkRequireSameClient,
  });

  factory AttackProtection.fromJson(Map<String, dynamic> json) => _$AttackProtectionFromJson(json);

  Map<String, dynamic> toJson() => _$AttackProtectionToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class UserLockout {
  final int maxAttempts;

  @JsonKey(name: 'enabled')
  final bool isEnabled;

  @JsonKey(name: 'duration_in_minutes', toJson: _toDuration)
  final Duration duration;

  const UserLockout({
    required this.isEnabled,
    required this.maxAttempts,
    required this.duration,
  });

  factory UserLockout.fromJson(Map<String, dynamic> json) => _$UserLockoutFromJson(json);

  Map<String, dynamic> toJson() => _$UserLockoutToJson(this);
}

Duration _toDuration(dynamic value) =>
    value is num ? Duration(minutes: value.toInt()) : Duration.zero;

bool _readPiiEnabled(map, _) => map['pii']?['enabled'] == true;

bool _readEmailLinkRequireSameClient(map, _) => map['email_link']?['require_same_client'] == true;
