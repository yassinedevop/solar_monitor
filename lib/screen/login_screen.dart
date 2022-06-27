import 'package:animated_login/animated_login.dart';
import 'package:flutter/material.dart';
import '/utils/login.dart';

class LoginScreen extends StatelessWidget {
  final LoginUtils _loginUtils = LoginUtils();
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedLogin(
      loginMobileTheme: LoginViewTheme(
        backgroundColor: Colors.green.shade600,
        formFieldHoverColor: Colors.white60,
        textFormStyle: TextStyle(color: Colors.white),
      ),
      onSignup: (data) => _loginUtils.onSignUp(data, context),
      onLogin: (data) => _loginUtils.onLogin(data, context),
      onForgotPassword: _loginUtils.onForgotPass,
    );
  }
}
