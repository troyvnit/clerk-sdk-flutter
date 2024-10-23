import 'package:clerk_auth/clerk_auth.dart' as Clerk;
import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';

/// Control widget initialising Clerk Auth system
class ClerkAuth extends StatefulWidget {
  /// Clerk public key from dashboard
  final String publicKey;

  /// Clerk publishable key from dashboard
  final String publishableKey;

  /// Persistence service for caching tokens
  final Clerk.Persistor? persistor;

  /// Injectable translations for strings
  final ClerkTranslator translator;

  /// child widget tree
  final Widget child;

  /// Loading widget
  final Widget? loading;

  /// Constructor that constructs a construct constructingly
  const ClerkAuth({
    super.key,
    required this.publicKey,
    required this.publishableKey,
    required this.child,
    this.translator = const ClerkTranslator(),
    this.persistor,
    this.loading,
  });

  @override
  State<ClerkAuth> createState() => _ClerkAuthState();

  static Clerk.Auth of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<_ClerkAuthData>();
    assert(result != null, 'No Clerk `Auth` found in context');
    return result!.auth;
  }

  static Clerk.DisplayConfig displayConfigOf(BuildContext context) {
    final result = context.findAncestorWidgetOfExactType<_ClerkAuthData>();
    assert(result != null, 'No Clerk `Auth` found in context');
    return result!.auth.env.display;
  }

  static ClerkTranslator translatorOf(context) {
    final result = context.findAncestorWidgetOfExactType<_ClerkAuthData>();
    assert(result != null, 'No Clerk `Auth` found in context');
    return result!.translator;
  }
}

class _ClerkAuthState extends State<ClerkAuth> {
  late _ClerkNotifyingAuth _auth;
  late Future<Clerk.Auth> _authFuture;

  @override
  void initState() {
    super.initState();
    _auth = _ClerkNotifyingAuth(
      publishableKey: widget.publishableKey,
      publicKey: widget.publicKey,
      persistor: widget.persistor,
    );
    _auth.addListener(() => setState(() {}));
    _authFuture = _auth.init();
  }

  @override
  void dispose() {
    _auth.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _authFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _ClerkAuthData(
            child: widget.child,
            auth: snapshot.data!,
            translator: widget.translator,
          );
        }
        return widget.loading ?? emptyWidget;
      },
    );
  }
}

/// Data class holding the auth object
class _ClerkAuthData extends InheritedWidget {
  /// Clerk auth object
  final Clerk.Auth auth;
  final Clerk.Client client;
  final Clerk.Environment env;
  final ClerkTranslator translator;

  _ClerkAuthData({
    required super.child,
    required this.auth,
    required this.translator,
  })  : this.client = auth.client,
        this.env = auth.env;

  @override
  bool updateShouldNotify(_ClerkAuthData old) => old.client != client || old.env != env;
}

class _ClerkNotifyingAuth extends Clerk.Auth with ChangeNotifier {
  _ClerkNotifyingAuth({required super.publicKey, required super.publishableKey, super.persistor});

  @override
  void update() => notifyListeners();
}
