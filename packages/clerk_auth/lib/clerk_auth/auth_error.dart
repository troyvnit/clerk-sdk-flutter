class AuthError extends Error {
  final int? code;
  final String message;

  AuthError({this.code, required this.message});

  String toString() => message;
}
