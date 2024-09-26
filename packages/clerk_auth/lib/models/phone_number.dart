import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'phone_number.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class PhoneNumber extends UserIdentifyingData {
  final String phoneNumber;
  final bool reserved;
  final bool reservedForSecondFactor;
  final bool defaultSecondFactor;
  final Verification? verification;

  @JsonKey(fromJson: DateTime.fromMillisecondsSinceEpoch)
  final DateTime updatedAt;

  @JsonKey(fromJson: DateTime.fromMillisecondsSinceEpoch)
  final DateTime createdAt;

  PhoneNumber({
    required super.id,
    required this.phoneNumber,
    required this.reserved,
    required this.reservedForSecondFactor,
    required this.defaultSecondFactor,
    required this.verification,
    required this.updatedAt,
    required this.createdAt,
  });

  String get identifier => phoneNumber;

  factory PhoneNumber.fromJson(Map<String, dynamic> json) => _$PhoneNumberFromJson(json);

  Map<String, dynamic> toJson() => _$PhoneNumberToJson(this);
}
