import 'package:clerk_auth/clerk_auth.dart' as Clerk;
import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';

/// The [ClerkSignUpWidget] renders a UI for signing up users.
///
/// The functionality of the [ClerkSignUpWidget] is controlled by the instance settings
/// you specify in your Clerk Dashboard, such as sign-in and social connections. You can
/// further customize your [ClerkSignUpWidget] by passing additional properties.
///
/// https://clerk.com/docs/components/authentication/sign-up
///
///
@immutable
class ClerkSignUpWidget extends StatefulWidget {
  const ClerkSignUpWidget();

  @override
  State<ClerkSignUpWidget> createState() => _ClerkSignUpWidgetState();
}

class _ClerkSignUpWidgetState extends State<ClerkSignUpWidget> {
  static final _phoneNumberRE = RegExp(r'[^0-9+]');
  static const _errorDisplayDuration = Duration(seconds: 3);

  final _values = <Clerk.UserAttribute, String>{
    Clerk.UserAttribute.firstName: 'Nic',
    Clerk.UserAttribute.lastName: 'Ford',
    Clerk.UserAttribute.username: 'shinyford',
    Clerk.UserAttribute.emailAddress: 'nicsford+clerk_test@gmail.com',
    Clerk.UserAttribute.phoneNumber: '+15555550131',
    Clerk.UserAttribute.password: r'3Bogart5$',
    Clerk.UserAttribute.passwordConfirmation: r'3Bogart5$',
  };
  String? _error;
  bool obscurePassword = true;

  Future<T?> _callAuth<T>(Future<T> Function() fn) async {
    T? result;
    try {
      Overlay.of(context).insert(awaitingAuthResponseOverlay);
      result = await fn.call();
    } on Clerk.AuthError catch (error) {
      _setError(error.toString());
    } finally {
      awaitingAuthResponseOverlay.remove();
    }
    return result;
  }

  void _setError(String error) {
    setState(() => _error = error);
    Future.delayed(_errorDisplayDuration, () => setState(() => _error = null));
  }

  static final _lowerCaseRE = RegExp(r'[a-z]');
  static final _upperCaseRE = RegExp(r'[A-Z]');
  static final _numberRE = RegExp(r'[0-9]');

  String? _checkPassword(Clerk.Auth auth, String? password, String? confirmation) {
    final translator = ClerkAuth.translatorOf(context);

    if (password != confirmation) {
      return translator.translate('Password and password confirmation must match');
    }

    if (password case String password when password.isNotEmpty) {
      final criteria = auth.env.user.passwordSettings;
      final missing = <String>[];

      if (criteria.requireLowercase && _lowerCaseRE.hasMatch(password) == false) {
        missing.add('a LOWERCASE letter');
      }

      if (criteria.requireUppercase && _upperCaseRE.hasMatch(password) == false) {
        missing.add('an UPPERCASE letter');
      }

      if (criteria.requireNumbers && _numberRE.hasMatch(password) == false) {
        missing.add('a NUMBER');
      }

      if (criteria.requireSpecialChar) {
        final pRunes = password.runes.toSet();
        final scRunes = criteria.allowedSpecialCharacters.runes.toSet();
        final lacksSpecialChar = pRunes.intersection(scRunes).isEmpty;
        if (lacksSpecialChar) missing.add('a SPECIAL CHARACTER (###)');
      }

      if (missing.isNotEmpty) {
        final value =
            translator.alternatives(missing, connector: 'and', prefix: 'Password requires');
        return value.replaceFirst('###', criteria.allowedSpecialCharacters);
      }
    }

    return null;
  }

  Future<void> _continue(Clerk.Auth auth, {String? code, Clerk.Strategy? strategy}) async {
    await _callAuth(() async {
      final password = _values[Clerk.UserAttribute.password];
      final passwordConfirmation = _values[Clerk.UserAttribute.passwordConfirmation];
      if (_checkPassword(auth, password, passwordConfirmation) case String error) {
        _setError(error);
      } else {
        await auth.attemptSignUp(
          strategy: strategy ?? Clerk.Strategy.password,
          firstName: _values[Clerk.UserAttribute.firstName],
          lastName: _values[Clerk.UserAttribute.lastName],
          username: _values[Clerk.UserAttribute.username],
          emailAddress: _values[Clerk.UserAttribute.emailAddress],
          phoneNumber: _values[Clerk.UserAttribute.phoneNumber]?.replaceAll(_phoneNumberRE, ''),
          password: password,
          passwordConfirmation: passwordConfirmation,
          code: code,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = ClerkAuth.of(context);
    final translator = auth.translator;
    final env = auth.env;
    final attributes = [
      ...env.user.attributes.entries.where((a) => a.value.isEnabled).map(_Attribute.fromMapEntry),
      const _Attribute(Clerk.UserAttribute.passwordConfirmation, true),
    ]..sort((a, b) => a.index - b.index);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        ErrorMessage(error: _error),
        ClerkCodeInput(
          key: const Key('phone_code'),
          open: auth.signUp?.unverified(Clerk.Field.phoneNumber) == true,
          title: translator.translate('Verify your phone number'),
          subtitle: translator.translate(
            'Enter code sent to ###',
            substitution: _values[Clerk.UserAttribute.phoneNumber],
          ),
          onSubmit: (code) async {
            await _continue(auth, strategy: Clerk.Strategy.phoneCode, code: code);
            return false;
          },
        ),
        ClerkCodeInput(
          key: const Key('email_code'),
          open: auth.signUp?.unverified(Clerk.Field.emailAddress) == true,
          title: translator.translate('Verify your email address'),
          subtitle: translator.translate(
            'Enter code sent to ###',
            substitution: _values[Clerk.UserAttribute.emailAddress],
          ),
          onSubmit: (code) async {
            await _continue(auth, strategy: Clerk.Strategy.emailCode, code: code);
            return false;
          },
        ),
        Closeable(
          closed: auth.signUp?.unverifiedFields.isNotEmpty == true,
          child: Column(
            children: [
              for (final attribute in attributes)
                Padding(
                  padding: horizontalPadding32 + bottomPadding24,
                  child: attribute.isPhoneNumber
                      ? ClerkPhoneNumberFormField(
                          initial: _values[attribute.attr],
                          label: attribute.title,
                          optional: attribute.isOptional,
                          onChanged: (value) => _values[attribute.attr] = value,
                        )
                      : ClerkTextFormField(
                          initial: _values[attribute.attr],
                          label: attribute.title,
                          optional: attribute.isOptional,
                          obscureText: attribute.needsObscuring && obscurePassword,
                          onObscure: attribute.needsObscuring
                              ? () => setState(() => obscurePassword = !obscurePassword)
                              : null,
                          onChanged: (value) => _values[attribute.attr] = value,
                        ),
                ),
            ],
          ),
        ),
        Padding(
          padding: horizontalPadding32,
          child: ClerkMaterialButton(
            onPressed: () => _continue(auth),
            label: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(child: Text(translator.translate('Continue'))),
                horizontalMargin4,
                const Icon(Icons.arrow_right_sharp),
              ],
            ),
          ),
        ),
        ErrorMessage(error: _error),
        verticalMargin32,
      ],
    );
  }
}

class _Attribute {
  final Clerk.UserAttribute attr;
  final bool isRequired;

  const _Attribute(this.attr, this.isRequired);

  factory _Attribute.fromMapEntry(MapEntry<Clerk.UserAttribute, Clerk.UserAttributeData> entry) =>
      _Attribute(entry.key, entry.value.isRequired);

  int get index => attr.index;
  bool get needsObscuring => attr.obscure;
  bool get isPhoneNumber => attr == Clerk.UserAttribute.phoneNumber;
  bool get isOptional => isRequired == false;
  String get title => attr.title;
}
