import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'session.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Session {
  final String id;
  final Status status;
  final User publicUserData;
  final SessionToken? lastActiveToken;

  @JsonKey(fromJson: DateTime.fromMillisecondsSinceEpoch)
  final DateTime lastActiveAt;

  @JsonKey(fromJson: DateTime.fromMillisecondsSinceEpoch)
  final DateTime expireAt;

  @JsonKey(fromJson: DateTime.fromMillisecondsSinceEpoch)
  final DateTime abandonAt;

  Session({
    required this.id,
    required this.status,
    required this.lastActiveAt,
    required this.expireAt,
    required this.abandonAt,
    required this.publicUserData,
    this.lastActiveToken,
  });

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);

  Map<String, dynamic> toJson() => _$SessionToJson(this);
}
