import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'client.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Client {
  final String id;
  final SignIn? signIn;
  final SignUp? signUp;
  final String? lastActiveSessionId;

  @JsonKey(fromJson: DateTime.fromMillisecondsSinceEpoch)
  final DateTime updatedAt;

  @JsonKey(fromJson: DateTime.fromMillisecondsSinceEpoch)
  final DateTime createdAt;

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
}
