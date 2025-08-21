<p align="center">
<img src="https://images.clerk.com/static/logo-light-mode-400x400.png" height="90">
</p>

## Official [Clerk](https://clerk.com) Dart SDK (Beta)

[![Pub Version](https://img.shields.io/pub/v/clerk_auth?color=blueviolet)](https://pub.dev/packages/clerk_auth)
[![Pub Points](https://img.shields.io/pub/points/clerk_auth?label=pub%20points)](https://pub.dev/packages/clerk_auth/score)
[![chat on Discord](https://img.shields.io/discord/856971667393609759.svg?logo=discord)](https://discord.com/invite/b5rXHjAg7A)
[![documentation](https://img.shields.io/badge/documentation-clerk-green.svg)](https://clerk.com/docs)
[![twitter](https://img.shields.io/twitter/follow/ClerkDev?style=social)](https://twitter.com/intent/follow?screen_name=ClerkDev)

> ### ⚠️ The Clerk Flutter SDK is in Beta ⚠️
> ❗️ Breaking changes should be expected until the first stable release (1.0.0) ❗️

**Clerk helps developers build user management. We provide streamlined user experiences
for your users to sign up, sign in, and manage their profile from your Dart code.**

## Requirements

* Dart >= 3.6.2

## Example Usage

To use this package you will need to go to your [Clerk Dashboard](https://dashboard.clerk.com/)
create an application and copy the public and publishable API keys into your project.

```dart
import 'dart:io';

import 'package:clerk_auth/clerk_auth.dart';

Future<void> main() async {
  final auth = Auth(
    config: const AuthConfig(
      publishableKey: '<YOUR-PUBLISHABLE-KEY>',
    ),
    persistor: DefaultPersistor(
      getCacheDirectory: () => Directory.current,
    ),
    // To enable running of the example in e.g. Flutter environments where
    // [Directory.current] causes problems, use the `clerk_flutter` package and
    // use:
    // persistor: DefaultCachingPersistor(
    //   getCacheDirectory: getApplicationDocumentsDirectory,
    // )
    // Which will use the correct directory for the platform your Flutter app
    // is running on. You can also implement a bespoke [Persistor] specific
    // to your applications storage mechanism,
    //
    // or replace the above line with...
    // persistor: Persistor.none,
  );

  await auth.initialize();

  await auth.attemptSignIn(
    strategy: Strategy.password,
    identifier: '<USER-EMAIL>',
    password: '<PASSWORD>',
  );

  print('Signed in as ${auth.user}');

  await auth.signOut();

  auth.terminate();
}
```

For more details see [Clerk Auth object](https://pub.dev/documentation/clerk_auth/latest/clerk_auth/Auth-class.html)

## License

This SDK is licensed under the MIT license found in the [LICENSE](./LICENSE) file.
