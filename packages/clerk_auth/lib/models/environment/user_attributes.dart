import 'package:json_annotation/json_annotation.dart';

import '../models.dart';

part 'user_attributes.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class UserAttributes {
  static const empty = UserAttributes();

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
    this.emailAddress = UserAttribute.empty,
    this.phoneNumber = UserAttribute.empty,
    this.username = UserAttribute.empty,
    this.web3Wallet = UserAttribute.empty,
    this.firstName = UserAttribute.empty,
    this.lastName = UserAttribute.empty,
    this.password = UserAttribute.empty,
    this.authenticatorApp = UserAttribute.empty,
    this.backupCode = UserAttribute.empty,
    this.passkey = UserAttribute.empty,
  });

  factory UserAttributes.fromJson(Map<String, dynamic> json) => _$UserAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$UserAttributesToJson(this);
}
