import 'package:clerk_auth/clerk_api/clerk_api.dart';
import 'package:dart_dotenv/dart_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:test/test.dart';

const _kPublicKey = 'public_key';
const _kPublishableKey = 'publishable_key';
const _kEmail = 'email';
const _kPassword = 'password';

void main() {
  late final String email;
  late final String password;
  late final Api api;
  late final Logger logger;

  setUpAll(() {
    logger = Logger();

    final env = DotEnv(filePath: '.env.test')..getDotEnv();
    email = env.get(_kEmail) ?? '';
    password = env.get(_kPassword) ?? '';

    final publicKey = (env.get(_kPublicKey) ?? '').replaceAll('\\n', '\n');
    final publishableKey = env.get(_kPublishableKey) ?? '';

    api = Api(publicKey: publicKey, publishableKey: publishableKey);
  });

  group('Can sign in:', () {
    test('with email and password', () async {
      late ApiResponse response;

      response = await api.createSignIn(identifier: email);
      expect(response.client?.signIn?.status, Status.needsFirstFactor);

      final signIn = response.client!.signIn!;
      response = await api.attemptVerification(
        id: signIn.id,
        stage: FactorStage.first,
        strategy: Strategy.password,
        password: password,
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

      response = await api.createSignIn(identifier: email);
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
        code: '424242', // set in Clerk dashboard
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
