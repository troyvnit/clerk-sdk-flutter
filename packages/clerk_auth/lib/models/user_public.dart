import 'package:json_annotation/json_annotation.dart';

part 'user_public.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class UserPublic {
  final String identifier;
  final String? firstName;
  final String? lastName;
  final String? profileImageUrl;
  final String? imageUrl;

  @JsonKey(defaultValue: false)
  final bool hasImage;

  UserPublic({
    required this.identifier,
    required this.firstName,
    required this.lastName,
    required this.profileImageUrl,
    required this.imageUrl,
    required this.hasImage,
  });

  factory UserPublic.fromJson(Map<String, dynamic> json) => _$UserPublicFromJson(json);

  Map<String, dynamic> toJson() => _$UserPublicToJson(this);
}
