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
    this.translator = const DefaultClerkTranslator(),
    this.persistor,
    this.loading,
  });

  @override
  State<ClerkAuth> createState() => _ClerkAuthState();

  static ClerkAuthProvider of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<_ClerkAuthData>();
    assert(result != null, 'No Clerk `Auth` found in context');
    return result!.auth;
  }

  static Clerk.User? userOf(BuildContext context) => of(context).user;
  static Clerk.Session? sessionOf(BuildContext context) => of(context).session;

  static ClerkAuthProvider _authOf(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<_ClerkAuthData>();
    assert(result != null, 'No Clerk `Auth` found in context');
    return result!.auth;
  }

  static Clerk.DisplayConfig displayConfigOf(BuildContext context) => _authOf(context).env.display;
  static ClerkTranslator translatorOf(BuildContext context) => _authOf(context).translator;
}

class _ClerkAuthState extends State<ClerkAuth> {
  late ClerkAuthProvider _auth;
  late Future<ClerkAuthProvider> _authFuture;

  @override
  void initState() {
    super.initState();
    _auth = ClerkAuthProvider(
      publishableKey: widget.publishableKey,
      publicKey: widget.publicKey,
      persistor: widget.persistor,
      translator: widget.translator,
    );
    _auth.addListener(() => setState(() {}));
    _authFuture = _auth.init().then((_) => _auth);
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
          return _ClerkAuthData(child: widget.child, auth: snapshot.data!);
        }
        return widget.loading ?? emptyWidget;
      },
    );
  }
}

/// Data class holding the auth object
class _ClerkAuthData extends InheritedWidget {
  /// Clerk auth object
  final ClerkAuthProvider auth;
  final Clerk.Client client;
  final Clerk.Environment env;

  _ClerkAuthData({
    required super.child,
    required this.auth,
  })  : this.client = auth.client,
        this.env = auth.env;

  @override
  bool updateShouldNotify(_ClerkAuthData old) => old.client != client || old.env != env;
}

class ClerkAuthProvider extends Clerk.Auth with ChangeNotifier {
  final ClerkTranslator translator;

  ClerkAuthProvider({
    required super.publicKey,
    required super.publishableKey,
    ClerkTranslator? translator,
    super.persistor,
  }) : this.translator = translator ?? const DefaultClerkTranslator();

  @override
  void update() => notifyListeners();
}
