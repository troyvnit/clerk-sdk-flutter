class AuthError extends Error {
  final String message;

  AuthError(this.message);

  String toString() => "Auth: $message";
}
