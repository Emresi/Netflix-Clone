import 'package:flutter/foundation.dart';

@immutable
final class LocaleKeys {
  const LocaleKeys._();
  static const String kFontFam = 'BebasNeue';

  //home
  static const String kActors = 'Actors';
  static const String kDirectors = 'Directors';
  static const String kScenarists = 'Scenarists';
  static const String kPopular = 'Most Popular';
  static const String kTrends = 'Trends';
  static const String kCategories = 'Categories';
  static const String kHomePage = 'Home Page';
  static const String kProfile = 'Profile';
  static const String kMyList = 'My List';
  static const String kRegisterWelcomeLink = 'https://www.youtube.com/embed/CFNMt9XzQQI';
  static const String kAuthImageLink =
      'https://assets.nflxext.com/ffe/siteui/vlv3/ce449112-3294-449a-b8d3-c4e1fdd7cff5/web/TR-en-20241202-TRIFECTA-perspective_5c739a54-c245-44ff-b2be-d874cf704950_large.jpg';

  static const String kSignIn = 'Sign In';
  static const String kSignUp = 'Sign Up';
  static const String kHaveAccount = 'Already have an account?';
  static const String kReVerify = 'Resend Verification Email';
  static const String kPwd = 'Password';
  static const String kEmail = 'Email';
  static const String kNotVerified = 'Email not verified ';
  static const String kLogSuccess = 'Login successful.';
  static const String kLogOutSuccess = 'Logged out successfully.';
  static const String kForgot = 'Forgot password?';
  static const String kNoAccount = "Don't have an account?";
  static const String kErrResend = 'An error occurred while resending the email. Please try again.';
  static const String kRegistered = 'Registration successful, but email verification could not be sent.';
  static const String kAlreadyVerified = 'User not logged in or already verified.';
  static const String kErrUnKnown = 'An unknown error occurred.';
  static const String kNope = 'Wrong email or password';

  static const String kEpisodes = 'Episodes';
  static const String kSimilar = 'Similar';
}
