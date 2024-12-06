import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get message => _message;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setMessage(String? value) {
    _message = value;
    notifyListeners();
  }

  Future<void> register(String email, String password) async {
    _setLoading(true);
    _setMessage(null);

    try {
      await _authService.registerWithEmail(email, password);

      if (_user != null && !_user!.emailVerified) {
        await _user!.sendEmailVerification();
        _setMessage('A verification email has been sent to ${_user!.email}. Please verify your email.');
      } else {
        _setMessage('Registration successful, but email verification could not be sent.');
      }
    } on FirebaseAuthException catch (e) {
      _setMessage(e.message);
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
        _setMessage('Verification email resent to ${_user!.email}. Please check your inbox.');
      } else {
        _setMessage('User not logged in or already verified.');
      }
    } catch (e) {
      _setMessage('An error occurred while resending the email. Please try again.');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> login(String email, String password) async {
    await _authService.loginWithEmail(email, password);
  }

  Future<void> logout() async {
    await _authService.signOut();
    _setMessage(null);
  }
}
