// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_attributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAttributes _$UserAttributesFromJson(Map<String, dynamic> json) =>
    UserAttributes(
      emailAddress: json['email_address'] == null
          ? UserAttribute.empty
          : UserAttribute.fromJson(
              json['email_address'] as Map<String, dynamic>),
      phoneNumber: json['phone_number'] == null
          ? UserAttribute.empty
          : UserAttribute.fromJson(
              json['phone_number'] as Map<String, dynamic>),
      username: json['username'] == null
          ? UserAttribute.empty
          : UserAttribute.fromJson(json['username'] as Map<String, dynamic>),
      web3Wallet: json['web3_wallet'] == null
          ? UserAttribute.empty
          : UserAttribute.fromJson(json['web3_wallet'] as Map<String, dynamic>),
      firstName: json['first_name'] == null
          ? UserAttribute.empty
          : UserAttribute.fromJson(json['first_name'] as Map<String, dynamic>),
      lastName: json['last_name'] == null
          ? UserAttribute.empty
          : UserAttribute.fromJson(json['last_name'] as Map<String, dynamic>),
      password: json['password'] == null
          ? UserAttribute.empty
          : UserAttribute.fromJson(json['password'] as Map<String, dynamic>),
      authenticatorApp: json['authenticator_app'] == null
          ? UserAttribute.empty
          : UserAttribute.fromJson(
              json['authenticator_app'] as Map<String, dynamic>),
      backupCode: json['backup_code'] == null
          ? UserAttribute.empty
          : UserAttribute.fromJson(json['backup_code'] as Map<String, dynamic>),
      passkey: json['passkey'] == null
          ? UserAttribute.empty
          : UserAttribute.fromJson(json['passkey'] as Map<String, dynamic>),
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
