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
      final r1 = await api.createSignIn(identifier: email);

      final signIn = r1.client?.signIn;
      if (signIn is SignIn) {
        expect(signIn.status, Status.needsFirstFactor);

        final r2 = await api.attemptVerification(
          id: signIn.id,
          stage: FactorStage.first,
          strategy: Strategy.password,
          password: password,
        );

        final client = r2.client;
        expect(client?.signIn, null);
        expect(client?.activeSession?.status, Status.active);
        expect(client?.activeSession?.publicUserData.identifier.isNotEmpty, true);
      }
    });
  });
}
