import 'package:clerk_auth/clerk_api/clerk_api.dart';
import 'package:dart_dotenv/dart_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:test/test.dart';

import '../../test_helpers.dart';

void main() {
  late final Api api;
  late final Logger logger;

  final env = TestEnv();

  setUpAll(() {
    logger = Logger();

    env.addAll(DotEnv(filePath: '.env.test').getDotEnv());

    api = Api(publicKey: env.publicKey, publishableKey: env.publishableKey);
  });

  group('Can sign in:', () {
    test('with email and password', () async {
      late ApiResponse response;

      response = await api.createSignIn(identifier: env.email);
      expect(response.client?.signIn?.status, Status.needsFirstFactor);

      final signIn = response.client!.signIn!;
      response = await api.attemptVerification(
        id: signIn.id,
        stage: FactorStage.first,
        strategy: Strategy.password,
        password: env.password,
      );

      final client = response.client;
      expect(client?.signIn, null);
      expect(client?.activeSession?.status, Status.active);
      expect(client?.activeSession?.publicUserData.identifier.isNotEmpty, true);

      await api.signOut();
    });

    test('with email code', () async {
      late ApiResponse response;
      late SignIn signIn;

      response = await api.createSignIn(identifier: env.email);
      expect(response.client?.signIn?.status, Status.needsFirstFactor);

      signIn = response.client!.signIn!;
      response = await api.prepareVerification(
        id: signIn.id,
        stage: FactorStage.first,
        strategy: Strategy.emailCode,
        emailAddressId: signIn.firstFactorFor(Strategy.emailCode)?.emailAddressId,
      );
      expect(response.client?.signIn?.status, Status.needsFirstFactor);

      signIn = response.client!.signIn!;
      response = await api.attemptVerification(
        id: signIn.id,
        stage: FactorStage.first,
        strategy: Strategy.emailCode,
        code: env.code,
      );
      expect(response.client!.sessions.length > 0, true);

      final client = response.client;
      expect(client?.signIn, null);
      expect(client?.activeSession?.status, Status.active);
      expect(client?.activeSession?.publicUserData.identifier.isNotEmpty, true);

      await api.signOut();
    });

    test('with email link', () async {
      late ApiResponse response;
      late SignIn signIn;

      response = await api.createSignIn(identifier: env.email);
      expect(response.client?.signIn?.status, Status.needsFirstFactor);

      final redirectUrl = 'https://redirect.to.somewhere';

      signIn = response.client!.signIn!;
      response = await api.prepareVerification(
        id: signIn.id,
        stage: FactorStage.first,
        strategy: Strategy.emailLink,
        emailAddressId: signIn.firstFactorFor(Strategy.emailCode)?.emailAddressId,
        redirectUrl: redirectUrl,
      );
      expect(response.client?.signIn?.status, Status.needsFirstFactor);

      // no way to test onward journey easily
    });

    test('with phone code', () async {
      late ApiResponse response;
      late SignIn signIn;

      response = await api.createSignIn(identifier: env.phoneNumber);
      expect(response.client?.signIn?.status, Status.needsFirstFactor);

      signIn = response.client!.signIn!;
      response = await api.prepareVerification(
        id: signIn.id,
        stage: FactorStage.first,
        strategy: Strategy.phoneCode,
        phoneNumberId: signIn.firstFactorFor(Strategy.phoneCode)?.phoneNumberId,
      );
      expect(response.client?.signIn?.status, Status.needsFirstFactor);

      signIn = response.client!.signIn!;
      response = await api.attemptVerification(
        id: signIn.id,
        stage: FactorStage.first,
        strategy: Strategy.phoneCode,
        code: env.code,
      );
      expect(response.client!.sessions.length > 0, true);

      final client = response.client;
      expect(client?.signIn, null);
      expect(client?.activeSession?.status, Status.active);
      expect(client?.activeSession?.publicUserData.identifier.isNotEmpty, true);

      await api.signOut();
    });
  });
}
