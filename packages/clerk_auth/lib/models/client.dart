import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'client.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Client {
  static const empty = Client();

  final String? id;
  final SignIn? signIn;
  final SignUp? signUp;
  final String? lastActiveSessionId;
  final List<Session> sessions;

  @JsonKey(fromJson: intToDateTime)
  final DateTime? updatedAt;

  @JsonKey(fromJson: intToDateTime)
  final DateTime? createdAt;

  const Client({
    this.id,
    this.signIn,
    this.signUp,
    this.sessions = const [],
    this.lastActiveSessionId,
    this.updatedAt,
    this.createdAt,
  });

  bool get isEmpty => this == empty;

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  Map<String, dynamic> toJson() => _$ClientToJson(this);

  Session? get activeSession {
    for (final session in sessions) {
      if (session.id == lastActiveSessionId) return session;
    }

    for (final session in sessions) {
      if (session.status.isActive) return session;
    }

    return null;
  }

  User? get user => activeSession?.user;
}
