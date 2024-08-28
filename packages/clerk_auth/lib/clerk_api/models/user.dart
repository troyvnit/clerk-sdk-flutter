import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class User {
  final String identifier;
  final String? firstName;
  final String? lastName;
  final String? profileImageUrl;
  final String? imageUrl;

  @JsonKey(defaultValue: false)
  final bool hasImage;

  User({
    required this.identifier,
    required this.firstName,
    required this.lastName,
    required this.profileImageUrl,
    required this.imageUrl,
    required this.hasImage,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
