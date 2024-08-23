import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:navicode/constants/colors.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _currentUser;
  bool isAuthorized = false;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      bool isAuthorized = account != null;
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _signIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _signOut() => _googleSignIn.disconnect();

  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? user = _currentUser;
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Navicode로 환영합니다."),
            if (user != null)
              ListTile(
                leading: GoogleUserCircleAvatar(identity: user),
              )
            else
              Column(
                children: [
                  SignInButton(Buttons.anonymous, onPressed: () => {}),
                  SignInButton(
                    Buttons.google,
                    onPressed: _signIn,
                  ),
                ],
              )
            // if (user != null)
            //   ListTile(
            //     leading: GoogleUserCircleAvatar(identity: user),
            //   )
            // else
            //   ElevatedButton(
            //       onPressed: _signIn, child: const Text("Sign in Google"))
          ],
        ),
      ),
    );
  }
}
