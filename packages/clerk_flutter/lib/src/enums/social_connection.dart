/// Authentication providers.
enum SocialConnection {
  /// Google.
  google('Google'),

  /// Facebook.
  facebook('Facebook'),

  /// Github.
  github('GitHub');

  const SocialConnection(this.value);

  /// The name of the provider.
  final String value;
}
