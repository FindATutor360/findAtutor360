// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:findatutor360/utils/operation_runner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthService {
  Future<User?> continueWithGoogle(BuildContext context);
  Future<User?> signUp(
    BuildContext context, {
    required String fullName,
    required String email,
    required String password,
  });
  Future<User?> logIn(
    BuildContext context, {
    required String email,
    required String password,
  });
  Future<User?> continueWithFacebook(
    BuildContext context,
  );
  Future<void> logout();
}

class AuthServiceImpl implements AuthService {
  AuthServiceImpl();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FacebookAuth facebookAuth = FacebookAuth.instance;

  @override
  Future<User?> continueWithGoogle(BuildContext context) async {
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser?.authentication;

    if (googleAuth != null) {
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await GoogleSignIn().signOut();
      final response = await _auth.signInWithCredential(credential);

      return response.user;
    }

    return null;
  }

  @override
  Future<User?> signUp(
    BuildContext context, {
    required String fullName,
    required String email,
    required String password,
  }) async {
    UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    log('User added successful', name: 'debug');
    User? user = credential.user;

    return user;
  }

  @override
  Future<User?> logIn(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    log('User log in successful', name: 'debug');
    User? user = credential.user;
    if (user != null && user.emailVerified) {
      return user;
    } else {
      await _auth.signOut();
      showSnackMessage(context, "Please verify your email before logging in",
          isError: true);
    }

    return null;
  }

  @override
  Future<User?> continueWithFacebook(
    BuildContext context,
  ) async {
    final loginResult = await facebookAuth.login();

    if (loginResult.status == LoginStatus.success) {
      final facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      UserCredential credential =
          await _auth.signInWithCredential(facebookAuthCredential);
      await facebookAuth.logOut();
      return credential.user;
    }
    return null;
  }

  @override
  Future<void> logout() async {
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.remove('userToken');
    await _auth.signOut();
    await facebookAuth.logOut();
    log('Log out successfully', name: 'debug');
  }
}
