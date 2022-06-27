import 'package:firebase_auth/firebase_auth.dart';
import 'package:animated_login/animated_login.dart';
import 'package:flutter/material.dart';

class LoginUtils {
  LoginUtils();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> onLogin(LoginData data, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: data.email, password: data.password);
    } on FirebaseAuthException catch (error) {
      return error.message;
    }
    _navigateToMain(context);

    return "Welcome Again !";
  }

  Future<String?> onSignUp(SignUpData data, BuildContext context) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: data.email, password: data.password);
    } on FirebaseAuthException catch (error) {
      return error.message;
    }

    _navigateToMain(context);
    return "Account Created, Welcome !";
  }

  Future<String?> onForgotPass(String data) async {
    try {
      await _auth.sendPasswordResetEmail(email: data);
    } on FirebaseAuthException catch (error) {
      return error.message;
    }
    return "A code has been sent to your email !";
  }

  void _navigateToMain(BuildContext context) {
    Navigator.pushNamed(context, '/main');
  }

  FirebaseAuth get firebaseInstance => _auth;
}
