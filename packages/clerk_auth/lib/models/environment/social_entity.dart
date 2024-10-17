import 'package:json_annotation/json_annotation.dart';

import '../models.dart';

part 'social_entity.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class SocialEntity {
  static const empty = SocialEntity();

  final String name;
  final String logoUrl;
  final Strategy strategy;

  @JsonKey(name: 'enabled', fromJson: isTrue)
  final bool isEnabled;

  @JsonKey(name: 'required', fromJson: isTrue)
  final bool isRequired;

  @JsonKey(name: 'authenticatable', fromJson: isTrue)
  final bool authenticatable;

  @JsonKey(name: 'block_email_subaddresses', fromJson: isTrue)
  final bool blockEmailSubaddresses;

  @JsonKey(name: 'non_selectable', fromJson: isTrue)
  final bool notSelectable;

  @JsonKey(name: 'deprecated', fromJson: isTrue)
  final bool deprecated;

  const SocialEntity({
    this.isEnabled = false,
    this.isRequired = false,
    this.authenticatable = false,
    this.blockEmailSubaddresses = false,
    this.strategy = Strategy.admin,
    this.notSelectable = false,
    this.deprecated = false,
    this.name = '',
    this.logoUrl = '',
  });

  factory SocialEntity.fromJson(Map<String, dynamic> json) => _$SocialEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SocialEntityToJson(this);
}
