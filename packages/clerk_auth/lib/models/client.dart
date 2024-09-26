import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'client.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Client {
  static final empty = Client.fromJson({});

  final String? id;
  final SignIn? signIn;
  final SignUp? signUp;
  final String? lastActiveSessionId;

  @JsonKey(fromJson: intToDateTime)
  final DateTime? updatedAt;

  @JsonKey(fromJson: intToDateTime)
  final DateTime? createdAt;

  @JsonKey(defaultValue: const [])
  final List<Session> sessions;

  const Client({
    required this.id,
    required this.signIn,
    required this.signUp,
    required this.sessions,
    required this.lastActiveSessionId,
    required this.updatedAt,
    required this.createdAt,
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
