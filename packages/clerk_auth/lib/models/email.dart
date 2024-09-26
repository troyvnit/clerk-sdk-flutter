import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'email.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Email extends UserIdentifyingData {
  final String emailAddress;
  final bool reserved;
  final Verification? verification;

  @JsonKey(fromJson: DateTime.fromMillisecondsSinceEpoch)
  final DateTime updatedAt;

  @JsonKey(fromJson: DateTime.fromMillisecondsSinceEpoch)
  final DateTime createdAt;

  Email({
    required super.id,
    required this.emailAddress,
    required this.reserved,
    required this.verification,
    required this.updatedAt,
    required this.createdAt,
  });

  String get identifier => emailAddress;

  factory Email.fromJson(Map<String, dynamic> json) => _$EmailFromJson(json);

  Map<String, dynamic> toJson() => _$EmailToJson(this);
}
