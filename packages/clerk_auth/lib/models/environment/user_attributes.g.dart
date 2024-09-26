// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_attributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAttributes _$UserAttributesFromJson(Map<String, dynamic> json) =>
    UserAttributes(
      emailAddress:
          UserAttribute.fromJson(json['email_address'] as Map<String, dynamic>),
      phoneNumber:
          UserAttribute.fromJson(json['phone_number'] as Map<String, dynamic>),
      username:
          UserAttribute.fromJson(json['username'] as Map<String, dynamic>),
      web3Wallet:
          UserAttribute.fromJson(json['web3_wallet'] as Map<String, dynamic>),
      firstName:
          UserAttribute.fromJson(json['first_name'] as Map<String, dynamic>),
      lastName:
          UserAttribute.fromJson(json['last_name'] as Map<String, dynamic>),
      password:
          UserAttribute.fromJson(json['password'] as Map<String, dynamic>),
      authenticatorApp: UserAttribute.fromJson(
          json['authenticator_app'] as Map<String, dynamic>),
      backupCode:
          UserAttribute.fromJson(json['backup_code'] as Map<String, dynamic>),
      passkey: UserAttribute.fromJson(json['passkey'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserAttributesToJson(UserAttributes instance) =>
    <String, dynamic>{
      'email_address': instance.emailAddress.toJson(),
      'phone_number': instance.phoneNumber.toJson(),
      'username': instance.username.toJson(),
      'web3_wallet': instance.web3Wallet.toJson(),
      'first_name': instance.firstName.toJson(),
      'last_name': instance.lastName.toJson(),
      'password': instance.password.toJson(),
      'authenticator_app': instance.authenticatorApp.toJson(),
      'backup_code': instance.backupCode.toJson(),
      'passkey': instance.passkey.toJson(),
    };
