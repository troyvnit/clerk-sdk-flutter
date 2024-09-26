// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_number.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhoneNumber _$PhoneNumberFromJson(Map<String, dynamic> json) => PhoneNumber(
      id: json['id'] as String,
      phoneNumber: json['phone_number'] as String,
      reserved: json['reserved'] as bool,
      reservedForSecondFactor: json['reserved_for_second_factor'] as bool,
      defaultSecondFactor: json['default_second_factor'] as bool,
      verification: json['verification'] == null
          ? null
          : Verification.fromJson(json['verification'] as Map<String, dynamic>),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(
          (json['updated_at'] as num).toInt()),
      createdAt: DateTime.fromMillisecondsSinceEpoch(
          (json['created_at'] as num).toInt()),
    );

Map<String, dynamic> _$PhoneNumberToJson(PhoneNumber instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone_number': instance.phoneNumber,
      'reserved': instance.reserved,
      'reserved_for_second_factor': instance.reservedForSecondFactor,
      'default_second_factor': instance.defaultSecondFactor,
      'verification': instance.verification?.toJson(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
    };
