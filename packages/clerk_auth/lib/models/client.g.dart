// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Client _$ClientFromJson(Map<String, dynamic> json) => Client(
      id: json['id'] as String?,
      signIn: json['sign_in'] == null
          ? null
          : SignIn.fromJson(json['sign_in'] as Map<String, dynamic>),
      signUp: json['sign_up'] == null
          ? null
          : SignUp.fromJson(json['sign_up'] as Map<String, dynamic>),
      sessions: (json['sessions'] as List<dynamic>?)
              ?.map((e) => Session.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      lastActiveSessionId: json['last_active_session_id'] as String?,
      updatedAt: intToDateTime(json['updated_at']),
      createdAt: intToDateTime(json['created_at']),
    );

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
      'id': instance.id,
      'sign_in': instance.signIn?.toJson(),
      'sign_up': instance.signUp?.toJson(),
      'last_active_session_id': instance.lastActiveSessionId,
      'updated_at': instance.updatedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'sessions': instance.sessions.map((e) => e.toJson()).toList(),
    };
