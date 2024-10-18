import 'dart:async';

import 'package:clerk_auth/clerk_api/clerk_api.dart';
import 'package:clerk_auth/clerk_auth.dart';

class Auth {
  final Api _api;
  late final Future<Client> _clientFuture = _api.createClient();
  late final Future<Environment> _envFuture = _api.environment();

  Auth({required String publishableKey, required String publicKey, Persistor? persistor})
      : _api = Api(publicKey: publicKey, publishableKey: publishableKey, persistor: persistor);

  /// A method to be overriden by extending subclasses to cope with updating their systems when
  /// things change
  void update() {}

  // `init` does not have to be called and awaited. However, `envSync`, `clientSync` and other
  // synchronous methods cannot be guaranteed to work without a call to `init` completing first.
  Future<Auth> init() async {
    await Future.wait([client, env]); // forces `_env` and `_client` to be populated
    return this;
  }

  Future<void> refresh() async {
    _env = await _api.environment();
  }

  bool get isLoaded => _env is Environment && _client is Client;

  Environment? _env;
  Environment get envSync => _env!;
  Future<Environment> get env async => _env ??= await _envFuture;

  Client? _client;
  Client get clientSync => _client!;
  Future<Client> get client async => _client ??= await _clientFuture;

  Future<SignIn?> get signIn async => (await client).signIn;
  Future<SignUp?> get signUp async => (await client).signUp;
  Future<Session?> get session async => (await client).activeSession;
  Future<User?> get user async => (await session)?.user;

  SignIn? get signInSync => clientSync.signIn;
  SignUp? get signUpSync => clientSync.signUp;
  Session? get sessionSync => clientSync.activeSession;
  User? get userSync => sessionSync?.user;

  Future<ApiResponse> _housekeeping(ApiResponse resp) async {
    if (resp.client case Client client when resp.isOkay) {
      _client = client;
    } else {
      throw AuthError('${resp.status}: ${resp.errorMessage}');
    }
    return resp;
  }

  Future<void> signOut() async {
    _client = await _api.signOut();
    update();
  }

  Future<void> deleteUser() async {
    _client = await _api.deleteUser();
    update();
  }

  Future<Client> attemptSignIn({
    String? identifier,
    Strategy? strategy,
    String? password,
    String? code,
    String? redirectUrl,
  }) async {
    Client client = await this.client;

    // If we already have a user, can return
    if (client.user is User) return client;

    if (client.signIn == null && identifier is String) {
      // if a password has been presented, we can immediately attempt a sign in
      // if `password` is null it will be ignored
      await _api.createSignIn(identifier: identifier, password: password).then(_housekeeping);
      client = await this.client;
      if (client.user is User) return client;
    }

    switch (client.signIn) {
      case SignIn signIn when strategy == Strategy.emailLink:
        await _api
            .prepareSignIn(
              signIn,
              stage: Stage.first,
              strategy: Strategy.emailLink,
              redirectUrl: redirectUrl,
            )
            .then(_housekeeping);

        final signInCompleter = Completer<Client>();

        _pollForCompletion(signInCompleter, () async {
          await _api.currentClient().then(_housekeeping);
          final client = await this.client;
          return client.user is User ? client : null;
        });

        update();
        return signInCompleter.future;

      case SignIn signIn
          when signIn.status == Status.needsFirstFactor && strategy == Strategy.password:
        await _api
            .attemptSignIn(
              signIn,
              stage: Stage.first,
              strategy: Strategy.password,
              password: password,
            )
            .then(_housekeeping);

      case SignIn signIn when signIn.status.needsFactor && strategy is Strategy:
        final stage = Stage.forStatus(signIn.status);
        await _api.prepareSignIn(signIn, stage: stage, strategy: strategy).then(_housekeeping);
        await _api
            .attemptSignIn(signIn, stage: stage, strategy: strategy, code: code)
            .then(_housekeeping);
    }

    update();
    return await this.client;
  }

  Future<Client> attemptSignUp({
    Strategy? strategy,
    String? firstName,
    String? lastName,
    String? username,
    String? emailAddress,
    String? phoneNumber,
    String? password,
    String? passwordConfirmation,
    String? code,
    String? token,
    String? signature,
  }) async {
    if (password != passwordConfirmation) {
      throw AuthError("Password and password confirmation must match");
    }
    Client client = await this.client;

    // If we already have a user, can return
    if (client.user is User) return client;

    if (client.signUp == null) {
      await _api
          .createSignUp(
            strategy: strategy,
            firstName: firstName,
            lastName: lastName,
            username: username,
            emailAddress: emailAddress,
            phoneNumber: phoneNumber,
            password: password,
            code: code,
            token: token,
          )
          .then(_housekeeping);
      client = await this.client;
    }

    switch (client.signUp) {
      case SignUp signUp
          when signUp.status == Status.missingRequirements &&
              signUp.missingFields.isEmpty &&
              strategy is Strategy:
        await _api.prepareSignUp(signUp, strategy: strategy).then(_housekeeping);
        await _api
            .attemptSignUp(signUp, strategy: strategy, code: code, signature: signature)
            .then(_housekeeping);

      case SignUp signUp when signUp.status == Status.missingRequirements:
        await _api
            .updateSignUp(
              signUp,
              strategy: strategy,
              firstName: firstName,
              lastName: lastName,
              username: username,
              emailAddress: emailAddress,
              phoneNumber: phoneNumber,
              password: password,
              code: code,
              token: token,
            )
            .then(_housekeeping);
    }

    update();
    return await this.client;
  }

  void _pollForCompletion<T>(Completer<T> completer, Future<T?> Function() fn) async {
    while (true) {
      final expiry = (await signIn)?.firstFactorVerification?.expireAt;
      if (expiry?.isAfter(DateTime.now()) != true) {
        // return if expiry has expired or is null
        completer.completeError(AuthError('Email Link not clicked in required timeframe'));
        update();
        return;
      }

      final result = await fn.call();
      if (result is T) {
        completer.complete(result);
        update();
        return;
      }

      await Future.delayed(const Duration(seconds: 1));
    }
  }
}
