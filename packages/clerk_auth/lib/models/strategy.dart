import 'package:clerk_auth/clerk_auth.dart';

class Strategy {
  static const _oauthToken = 'oauth_token';
  static const _oauthCustom = 'oauth_custom';
  static const _oauth = 'oauth';

  // verification strategies
  static const admin = Strategy(name: 'admin');
  static const emailCode = Strategy(name: 'email_code');
  static const emailLink = Strategy(name: 'email_link');
  static const passkey = Strategy(name: 'passkey');
  static const password = Strategy(name: 'password');
  static const phoneCode = Strategy(name: 'phone_code');
  static const resetPasswordEmailCode = Strategy(name: 'reset_password_email_code');
  static const resetPasswordPhoneCode = Strategy(name: 'reset_password_phone_code');
  static const saml = Strategy(name: 'saml');
  static const ticket = Strategy(name: 'ticket');
  static const web3MetamaskSignature = Strategy(name: 'web3_metamask_signature');
  static const web3CoinbaseSignature = Strategy(name: 'web3_coinbase_signature');
  static final verificationStrategies = {
    admin.name: admin,
    emailCode.name: emailCode,
    emailLink.name: emailLink,
    passkey.name: passkey,
    password.name: password,
    phoneCode.name: phoneCode,
    resetPasswordEmailCode.name: resetPasswordEmailCode,
    resetPasswordPhoneCode.name: resetPasswordPhoneCode,
    saml.name: saml,
    ticket.name: ticket,
    web3MetamaskSignature.name: web3MetamaskSignature,
    web3CoinbaseSignature.name: web3CoinbaseSignature,
  };

  // identification strategies
  static const emailAddress = Strategy(name: 'email_address');
  static const phoneNumber = Strategy(name: 'phone_number');
  static const username = Strategy(name: 'username');
  static final identificationStrategies = {
    emailAddress.name: emailAddress,
    phoneNumber.name: phoneNumber,
    username.name: username,
  };

  static final _strategies = {...verificationStrategies, ...identificationStrategies};

  final String name;
  final String? provider;

  const Strategy({required this.name, this.provider});

  factory Strategy.fromJson(String name) {
    switch (_strategies[name]) {
      case Strategy strategy:
        return strategy;

      case null when name.startsWith(_oauthToken):
        return _strategies[name] =
            Strategy(name: _oauthToken, provider: name.substring(_oauthToken.length + 1));

      case null when name.startsWith(_oauthCustom):
        return _strategies[name] =
            Strategy(name: _oauthCustom, provider: name.substring(_oauthCustom.length + 1));

      case null when name.startsWith(_oauth):
        return _strategies[name] =
            Strategy(name: _oauth, provider: name.substring(_oauth.length + 1));

      default:
        throw AuthError('No such strategy: $name');
    }
  }

  String toJson() => [name, provider].whereType<String>().join(': ');

  @override
  String toString() => [name, provider].whereType<String>().join('_');
}
