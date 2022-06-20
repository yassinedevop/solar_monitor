import 'package:animated_login/animated_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Solar Monitor',
        home: AnimatedLogin(
          onSignup: _onSignUp,
          onLogin: _onLogin,
          onForgotPassword: _onForgotPass,
        ));
  }
}

Future<String?> _onLogin(LoginData data) async {
  try {
    await _auth.signInWithEmailAndPassword(
        email: data.email, password: data.password);
  } on FirebaseAuthException catch (error) {
    return error.message;
  }
  return "Welcome Again !";
}

Future<String?> _onSignUp(SignUpData data) async {
  try {
    await _auth.createUserWithEmailAndPassword(
        email: data.email, password: data.password);
  } on FirebaseAuthException catch (error) {
    return error.message;
  }
  return "Account Created, Welcome !";
}

Future<String?> _onForgotPass(String data) async {
  try {
    await _auth.sendPasswordResetEmail(email: data);
  } on FirebaseAuthException catch (error) {
    return error.message;
  }
  return "A code has been sent to your email !";
}
