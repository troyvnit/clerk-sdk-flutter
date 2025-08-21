// ignore_for_file: public_member_api_docs, use_super_parameters

import 'clerk_sdk_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class ClerkSdkLocalizationsEn extends ClerkSdkLocalizations {
  ClerkSdkLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String aLengthOfBetweenMINAndMAX(int min, int max) {
    return 'a length of between $min and $max';
  }

  @override
  String aLengthOfMINOrGreater(int min) {
    return 'a length of $min or greater';
  }

  @override
  String get aLowercaseLetter => 'a LOWERCASE letter';

  @override
  String get aNumber => 'a NUMBER';

  @override
  String aSpecialCharacter(String chars) {
    return 'a SPECIAL CHARACTER ($chars)';
  }

  @override
  String get abandoned => 'abandoned';

  @override
  String get acceptTerms =>
      'I accept the Terms & Conditions and Privacy Policy';

  @override
  String get actionNotTimely =>
      'Awaited user action not completed in required timeframe';

  @override
  String get active => 'active';

  @override
  String get addAccount => 'Add account';

  @override
  String get addDomain => 'Add domain';

  @override
  String get addEmailAddress => 'Add email address';

  @override
  String get addPhoneNumber => 'Add phone number';

  @override
  String get alreadyHaveAnAccount => 'Already have an account?';

  @override
  String get anUppercaseLetter => 'an UPPERCASE letter';

  @override
  String get and => 'and';

  @override
  String get areYouSure => 'Are you sure?';

  @override
  String get authenticatorApp => 'authenticator app';

  @override
  String get automaticInvitation => 'Automatic invitation';

  @override
  String get automaticSuggestion => 'Automatic suggestion';

  @override
  String get backupCode => 'backup code';

  @override
  String get cancel => 'Cancel';

  @override
  String get cannotDeleteSelf => 'You are not authorized to delete your user';

  @override
  String clickOnTheLinkThatSBeenSentToAndThenCheckBackHere(String identifier) {
    return 'Click on the link that‘s been sent to $identifier and then check back here';
  }

  @override
  String get complete => 'complete';

  @override
  String get connectAccount => 'Connect account';

  @override
  String get connectedAccounts => 'Connected accounts';

  @override
  String get cont => 'Continue';

  @override
  String get createOrganization => 'Create organization';

  @override
  String get didntReceiveCode => 'Didn\'t receive the code?';

  @override
  String get domainName => 'Domain name';

  @override
  String get dontHaveAnAccount => 'Don’t have an account?';

  @override
  String get edit => 'edit';

  @override
  String get emailAddress => 'email address';

  @override
  String get emailAddressConcise => 'email';

  @override
  String get enrollment => 'Enrollment';

  @override
  String get enrollmentMode => 'Enrollment mode:';

  @override
  String enterTheCodeSentTo(String identifier) {
    return 'Enter the code sent to $identifier';
  }

  @override
  String get enterTheCodeSentToYou => 'Enter the code sent to you';

  @override
  String get expired => 'expired';

  @override
  String get failed => 'failed';

  @override
  String get firstName => 'first name';

  @override
  String get forgottenPassword => 'Forgotten password?';

  @override
  String get generalDetails => 'General details';

  @override
  String invalidEmailAddress(String address) {
    return 'Invalid email address: $address';
  }

  @override
  String invalidPhoneNumber(String number) {
    return 'Invalid phone number: $number';
  }

  @override
  String get join => 'JOIN';

  @override
  String jwtPoorlyFormatted(String arg) {
    return 'JWT poorly formatted: $arg';
  }

  @override
  String get lastName => 'last name';

  @override
  String get leave => 'Leave';

  @override
  String leaveOrg(String organization) {
    return 'Leave $organization';
  }

  @override
  String get leaveOrganization => 'Leave organization';

  @override
  String get loading => 'Loading…';

  @override
  String get logo => 'Logo';

  @override
  String get manualInvitation => 'Manual invitation';

  @override
  String get missingRequirements => 'missing requirements';

  @override
  String get name => 'Name';

  @override
  String get needsFirstFactor => 'needs first factor';

  @override
  String get needsIdentifier => 'needs identifier';

  @override
  String get needsSecondFactor => 'needs second factor';

  @override
  String get newPassword => 'New password';

  @override
  String get newPasswordConfirmation => 'Confirm new password';

  @override
  String noAssociatedCodeRetrievalMethod(String arg) {
    return 'No code retrieval method associated with $arg';
  }

  @override
  String noAssociatedStrategy(String arg) {
    return 'No strategy associated with $arg';
  }

  @override
  String noSessionFoundForUser(String arg) {
    return 'No session found for user $arg';
  }

  @override
  String get noSessionTokenRetrieved => 'No session token retrieved';

  @override
  String noStageForStatus(String arg) {
    return 'No stage found for status $arg';
  }

  @override
  String noSuchFirstFactorStrategy(String arg) {
    return 'Strategy $arg not supported for first factor';
  }

  @override
  String noSuchSecondFactorStrategy(String arg) {
    return 'Strategy $arg not supported for second factor';
  }

  @override
  String get ok => 'OK';

  @override
  String get optional => '(optional)';

  @override
  String get or => 'or';

  @override
  String get organizationProfile => 'Organization profile';

  @override
  String get organizations => 'Organizations';

  @override
  String get passkey => 'passkey';

  @override
  String get password => 'Password';

  @override
  String get passwordAndPasswordConfirmationMustMatch =>
      'Password and password confirmation must match';

  @override
  String get passwordConfirmation => 'confirm password';

  @override
  String get passwordMatchError =>
      'Password and password confirmation must match';

  @override
  String get passwordMustBeSupplied => 'A password must be supplied';

  @override
  String get passwordRequires => 'Password requires:';

  @override
  String get pending => 'pending';

  @override
  String get personalAccount => 'Personal account';

  @override
  String get phoneNumber => 'phone number';

  @override
  String get phoneNumberConcise => 'phone';

  @override
  String get pleaseAddRequiredInformation =>
      'Something seems to be missing. Please add the required information';

  @override
  String get pleaseChooseAnAccountToConnect =>
      'Please choose an account to connect';

  @override
  String get pleaseEnterYourIdentifier => 'Please enter your identifier';

  @override
  String get primary => 'PRIMARY';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get problemsConnecting => 'We are having problems connecting';

  @override
  String get profile => 'Profile';

  @override
  String get profileDetails => 'Profile details';

  @override
  String get recommendSize => 'Recommend size 1:1, up to 5MB.';

  @override
  String get requiredField => '(required)';

  @override
  String get resend => 'Resend';

  @override
  String get resetFailed =>
      'That password reset attempt failed. A new code has been sent.';

  @override
  String get resetPassword => 'Reset password and sign in';

  @override
  String get selectAccount =>
      'Select the account with which you wish to continue';

  @override
  String get sendMeTheCode => 'Send me the reset code';

  @override
  String get signIn => 'Sign in';

  @override
  String get signInByClickingALinkSentToYouByEmail =>
      'Sign in by clicking a link sent to you by email';

  @override
  String get signInByEnteringACodeSentToYouByEmail =>
      'Sign in by entering a code sent to you by email';

  @override
  String get signInByEnteringACodeSentToYouByTextMessage =>
      'Sign in by entering a code sent to you by text message';

  @override
  String signInError(String arg) {
    return 'Unsupported sign in attempt: $arg';
  }

  @override
  String signInTo(String name) {
    return 'Sign in to $name';
  }

  @override
  String get signOut => 'Sign out';

  @override
  String signOutIdentifier(String identifier) {
    return 'Sign out $identifier';
  }

  @override
  String get signOutOfAllAccounts => 'Sign out of all accounts';

  @override
  String get signUp => 'Sign up';

  @override
  String signUpTo(String name) {
    return 'Sign up to $name';
  }

  @override
  String get slugUrl => 'Slug URL';

  @override
  String get switchTo => 'Switch to';

  @override
  String get termsAndConditions => 'Terms & Conditions';

  @override
  String get transferable => 'transferable';

  @override
  String typeTypeInvalid(String type) {
    return 'Type \'$type\' is invalid';
  }

  @override
  String unsupportedPasswordResetStrategy(String arg) {
    return 'Unsupported password reset strategy: $arg';
  }

  @override
  String get unverified => 'unverified';

  @override
  String get username => 'username';

  @override
  String get verificationEmailAddress => 'Email address verification';

  @override
  String get verificationPhoneNumber => 'Phone number verification';

  @override
  String get verified => 'verified';

  @override
  String get verifiedDomains => 'Verified domains';

  @override
  String get verifyYourEmailAddress => 'Verify your email address';

  @override
  String get verifyYourPhoneNumber => 'Verify your phone number';

  @override
  String get viaAutomaticInvitation => 'via automatic invitation';

  @override
  String get viaAutomaticSuggestion => 'via automatic suggestion';

  @override
  String get viaManualInvitation => 'via manual invitation';

  @override
  String get web3Wallet => 'web3 wallet';

  @override
  String get welcomeBackPleaseSignInToContinue =>
      'Welcome back! Please sign in to continue';

  @override
  String get welcomePleaseFillInTheDetailsToGetStarted =>
      'Welcome! Please fill in the details to get started';
}
