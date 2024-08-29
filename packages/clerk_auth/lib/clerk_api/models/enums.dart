import 'package:json_annotation/json_annotation.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum Status {
  active,
  abandoned,
  needsFirstFactor,
  unverified,
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
  String toString() => name.toSnakeCase();
}

@JsonEnum(fieldRename: FieldRename.snake)
enum FactorStage {
  first,
  second;

  @override
  String toString() => name;
}

extension CaseExtension on String {
  bool _isUpper(int c) => c >= 0x41 && c <= 0x5a;

  String toSnakeCase({String separator = "_"}) {
    if (isEmpty) return this;

    final buffer = StringBuffer();
    for (final rune in runes) {
      if (_isUpper(rune)) {
        buffer.write(separator);
        buffer.writeCharCode(rune | 0x20);
      } else {
        buffer.writeCharCode(rune);
      }
    }
    return buffer.toString();
  }
}
