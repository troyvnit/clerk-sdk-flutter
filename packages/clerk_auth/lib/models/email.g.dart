// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Email _$EmailFromJson(Map<String, dynamic> json) => Email(
      id: json['id'] as String,
      emailAddress: json['email_address'] as String,
      reserved: json['reserved'] as bool,
      verification: json['verification'] == null
          ? null
          : Verification.fromJson(json['verification'] as Map<String, dynamic>),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(
          (json['updated_at'] as num).toInt()),
      createdAt: DateTime.fromMillisecondsSinceEpoch(
          (json['created_at'] as num).toInt()),
    );

Map<String, dynamic> _$EmailToJson(Email instance) => <String, dynamic>{
      'id': instance.id,
      'email_address': instance.emailAddress,
      'reserved': instance.reserved,
      'verification': instance.verification?.toJson(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
    };
