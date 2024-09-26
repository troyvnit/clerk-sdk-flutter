import 'package:json_annotation/json_annotation.dart';

import '../models.dart';

part 'user_attributes.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class UserAttributes {
  final UserAttribute emailAddress;
  final UserAttribute phoneNumber;
  final UserAttribute username;
  final UserAttribute web3Wallet;
  final UserAttribute firstName;
  final UserAttribute lastName;
  final UserAttribute password;
  final UserAttribute authenticatorApp;
  final UserAttribute backupCode;
  final UserAttribute passkey;

  const UserAttributes({
    required this.emailAddress,
    required this.phoneNumber,
    required this.username,
    required this.web3Wallet,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.authenticatorApp,
    required this.backupCode,
    required this.passkey,
  });

  factory UserAttributes.fromJson(Map<String, dynamic> json) => _$UserAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$UserAttributesToJson(this);
}
