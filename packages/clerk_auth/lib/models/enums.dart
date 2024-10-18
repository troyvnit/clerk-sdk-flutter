import 'package:clerk_auth/clerk_auth.dart';
import 'package:json_annotation/json_annotation.dart';

typedef AuthParameters = Map<Field, dynamic>;

@JsonEnum(fieldRename: FieldRename.snake)
enum EnrollmentMode {
  manualInvitation,
  ;

  @override
  String toString() => name.toSnakeCase();
}

@JsonEnum(fieldRename: FieldRename.snake)
enum Status {
  abandoned,
  active,
  missingRequirements,
  needsFirstFactor,
  needsSecondFactor,
  unverified,
  verified,
  complete,
  ;

  bool get isActive => this == active;
  bool get needsFactor => this == needsFirstFactor || this == needsSecondFactor;

  @override
  String toString() => name;
}

@JsonEnum(fieldRename: FieldRename.snake)
enum IdentificationStrategy {
  emailAddress,
  oauthApple,
  oauthGithub,
  oauthGoogle,
  phoneNumber,
  username,
  ;

  @override
  String toString() => name.toSnakeCase();
}

@JsonEnum(fieldRename: FieldRename.snake)
enum Stage {
  first,
  second;

  @override
  String toString() => name;

  static Stage forStatus(Status status) {
    return switch (status) {
      Status.needsFirstFactor => first,
      Status.needsSecondFactor => second,
      _ => throw AuthError('No Stage for $status'),
    };
  }
}

@JsonEnum(fieldRename: FieldRename.snake)
enum Field {
  emailAddress,
  externalAccount,
  firstName,
  lastName,
  password,
  phoneNumber,
  oauthApple,
  oauthGithub,
  oauthGoogle,
  username,
  web3Wallet,
  code,
  token,
  signature,
  ;

  @override
  String toString() => name.toSnakeCase();
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
