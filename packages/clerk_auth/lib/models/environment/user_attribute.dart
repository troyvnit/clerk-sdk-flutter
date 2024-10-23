import 'package:json_annotation/json_annotation.dart';

import '../models.dart';

part 'user_attribute.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class UserAttribute {
  static const empty = UserAttribute();

  @JsonKey(fromJson: toStrategyList)
  final List<Strategy> firstFactors;

  @JsonKey(fromJson: toStrategyList)
  final List<Strategy> secondFactors;

  @JsonKey(fromJson: toStrategyList)
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
    this.isEnabled = false,
    this.isRequired = false,
    this.usedForFirstFactor = false,
    this.firstFactors = const [],
    this.userForSecondFactor = false,
    this.secondFactors = const [],
    this.verifyAtSignUp = false,
    this.verifications = const [],
  });

  factory UserAttribute.fromJson(Map<String, dynamic> json) => _$UserAttributeFromJson(json);

  Map<String, dynamic> toJson() => _$UserAttributeToJson(this);
}
