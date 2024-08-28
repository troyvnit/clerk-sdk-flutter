import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'sign_in.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class SignIn {
  final String id;
  final Status status;
  final List<String> supportedIdentifiers;
  final String identifier;
  final User? userData;
  final Verification? firstFactorVerification;
  final Verification? secondFactorVerification;
  final String? createdSessionId;

  @JsonKey(fromJson: DateTime.fromMillisecondsSinceEpoch)
  final DateTime abandonAt;

  @JsonKey(defaultValue: const [])
  final List<Factor> supportedFirstFactors;

  @JsonKey(defaultValue: const [])
  final List<Factor> supportedSecondFactors;

  const SignIn({
    required this.id,
    required this.status,
    required this.supportedIdentifiers,
    required this.identifier,
    required this.userData,
    required this.supportedFirstFactors,
    required this.firstFactorVerification,
    required this.supportedSecondFactors,
    required this.secondFactorVerification,
    required this.createdSessionId,
    required this.abandonAt,
  });

  factory SignIn.fromJson(Map<String, dynamic> json) => _$SignInFromJson(json);

  Map<String, dynamic> toJson() => _$SignInToJson(this);
}
