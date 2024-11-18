import 'package:clerk_auth/clerk_auth.dart';
import 'package:json_annotation/json_annotation.dart';

typedef AuthParameters = Map<Field, dynamic>;

@JsonEnum(fieldRename: FieldRename.snake)
enum EnrollmentMode {
  manualInvitation;
}

@JsonEnum(fieldRename: FieldRename.snake)
enum Status {
  abandoned,
  active,
  missingRequirements,
  needsIdentifier,
  needsFirstFactor,
  needsSecondFactor,
  transferable,
  unverified,
  verified,
  complete;

  bool get isActive => this == active;

  bool get needsFactor => this == needsFirstFactor || this == needsSecondFactor;
}

@JsonEnum(fieldRename: FieldRename.snake)
enum IdentificationStrategy {
  emailAddress,
  oauthApple,
  oauthGithub,
  oauthGoogle,
  phoneNumber,
  username;
}

@JsonEnum(fieldRename: FieldRename.snake)
enum UserAttribute {
  username,
  emailAddress,
  phoneNumber,
  firstName,
  lastName,
  password,
  passwordConfirmation,
  web3Wallet,
  authenticatorApp,
  backupCode,
  passkey;

  bool get obscure => this == password || this == passwordConfirmation;

  String get snakeCaseName => name.toSnakeCase();

  String get title => snakeCaseName.replaceAll('_', ' ').capitalized;
}

@JsonEnum(fieldRename: FieldRename.snake)
enum Stage {
  first,
  second;

  static Stage forStatus(Status status) {
    return switch (status) {
      Status.needsFirstFactor => first,
      Status.needsSecondFactor => second,
      _ => throw AuthError(message: 'No Stage for $status'),
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
  signature;
}
