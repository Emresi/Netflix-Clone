import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/product/constants/locale_keys.dart';
import 'package:netflix_clone/product/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  AuthProvider() {
    _authService.authStateChanges.listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  final AuthService _authService = AuthService();
  User? _user;
  bool _isLoading = false;
  String? _message;
  bool _isError = false;
  bool _obscurePwd = true;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get message => _message;
  bool get isError => _isError;
  bool get obscurePwd => _obscurePwd;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setMessage(String? value, {bool isError = false}) {
    _message = value;
    _isError = isError;
    notifyListeners();
  }

  void clearMessage() {
    _message = null;
    notifyListeners();
  }

  Future<void> register(String email, String password) async {
    _setLoading(true);
    _setMessage(null);
    try {
      await _authService.registerWithEmail(email, password);
      if (_user != null && !_user!.emailVerified) {
        await _user!.sendEmailVerification();
        _setMessage(
          'A verification email has been sent to ${_user!.email}. Please verify your email.',
        );
      } else {
        _setMessage(
          LocaleKeys.kRegistered,
          isError: true,
        );
      }
    } on FirebaseAuthException catch (e) {
      _setMessage(e.message, isError: true);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> resendVerificationEmail() async {
    _setLoading(true);
    _setMessage(null);
    try {
      if (_user != null && !_user!.emailVerified) {
        await _user!.sendEmailVerification();
        _setMessage(
          'Verification email resent to ${_user!.email}. Please check your inbox.',
        );
      } else {
        _setMessage(LocaleKeys.kAlreadyVerified, isError: true);
      }
    } catch (e) {
      _setMessage(
        LocaleKeys.kErrResend,
        isError: true,
      );
    } finally {
      _setLoading(false);
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final user = await _authService.loginWithEmail(email, password);
      if (user == null) {
        _setMessage(LocaleKeys.kNope, isError: true);
        return;
      }
      _setMessage(LocaleKeys.kLogSuccess);
    } on FirebaseAuthException catch (e) {
      _setMessage(e.message ?? LocaleKeys.kErrUnKnown, isError: true);
    } catch (e) {
      _setMessage(e.toString(), isError: true);
    }
  }

  Future<void> logout() async {
    await _authService.signOut();
    _setMessage(LocaleKeys.kLogOutSuccess);
  }

  void togglePasswordVisibility() {
    _obscurePwd = !_obscurePwd;
    notifyListeners();
  }
}
