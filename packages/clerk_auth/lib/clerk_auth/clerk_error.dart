class ClerkError extends Error {
  final String message;

  ClerkError(this.message);

  String toString() => "Clerk: $message";
}
