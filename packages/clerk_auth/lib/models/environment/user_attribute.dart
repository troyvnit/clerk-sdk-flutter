import 'package:json_annotation/json_annotation.dart';

import '../models.dart';

part 'user_attribute.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class UserAttribute {
  final List<Strategy> firstFactors;
  final List<Strategy> secondFactors;
  final List<Strategy> verifications;

  @JsonKey(fromJson: isTrue)
  final bool usedForFirstFactor;

  @JsonKey(fromJson: isTrue)
  final bool userForSecondFactor;

  @JsonKey(fromJson: isTrue)
  final bool verifyAtSignUp;

  @JsonKey(fromJson: isTrue)
  final bool isEnabled;

  @JsonKey(fromJson: isTrue)
  final bool isRequired;

  const UserAttribute({
    required this.isEnabled,
    required this.isRequired,
    required this.usedForFirstFactor,
    required this.firstFactors,
    required this.userForSecondFactor,
    required this.secondFactors,
    required this.verifyAtSignUp,
    required this.verifications,
  });

  factory UserAttribute.fromJson(Map<String, dynamic> json) => _$UserAttributeFromJson(json);

  Map<String, dynamic> toJson() => _$UserAttributeToJson(this);
}
