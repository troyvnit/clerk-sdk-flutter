import 'package:json_annotation/json_annotation.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum Status {
  active,
  abandoned,
  needsFirstFactor,
  ;

  bool get isActive => this == active;

  @override
  String toString() => name;
}

@JsonEnum(fieldRename: FieldRename.snake)
enum Strategy {
  emailCode,
  emailLink,
  password,
  phoneCode,
  web3MetamaskSignature,
  web3CoinbaseSignature,
  resetPasswordPhoneCode,
  resetPasswordEmailCode,
  saml,
  passkey;

  @override
  String toString() => name;
}

@JsonEnum(fieldRename: FieldRename.snake)
enum FactorStage {
  first,
  second;

  @override
  String toString() => name;
}
