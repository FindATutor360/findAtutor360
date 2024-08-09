// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:findatutor360/utils/operation_runner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

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
  Future<void> logout(
    BuildContext context,
  );
  Future<User?> sendEmailVerification(User user);
}

class AuthServiceImpl implements AuthService {
  AuthServiceImpl();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FacebookAuth facebookAuth = FacebookAuth.instance;

  @override
  Future<User?> continueWithGoogle(BuildContext context) async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;

      if (googleAuth == null) {
        return null;
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      await GoogleSignIn().signOut();

      User? user = userCredential.user;

      return user;
    } on FirebaseAuthException catch (e) {
      log("$e", name: 'debug');
      showSnackMessage(context, "$e", isError: true);
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
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      log('User added successful', name: 'debug');
      User? user = credential.user;

      return user;
    } on FirebaseAuthException catch (e) {
      log("$e", name: 'debug');
      showSnackMessage(context, "$e", isError: true);
    }
    return null;
  }

  @override
  Future<User?> logIn(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      log('User log in successful', name: 'debug');
      User? user = credential.user;

      return user;
    } on FirebaseAuthException catch (e) {
      log("$e", name: 'debug');
      showSnackMessage(context, "$e", isError: true);
    }
    return null;
  }

  @override
  Future<User?> continueWithFacebook(
    BuildContext context,
  ) async {
    try {
      final loginResult = await facebookAuth.login();
      final facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      UserCredential credential =
          await _auth.signInWithCredential(facebookAuthCredential);
      await facebookAuth.logOut();
      User? user = credential.user;

      return user;
    } on FirebaseAuthException catch (e) {
      log("$e", name: 'debug');
      showSnackMessage(context, "$e", isError: true);
    }
    return null;
  }

  @override
  Future<void> logout(
    BuildContext context,
  ) async {
    try {
      await _auth.signOut();
      log('Log out successfully', name: 'debug');
    } on FirebaseAuthException catch (e) {
      log("$e", name: 'debug');
      showSnackMessage(context, "$e", isError: true);
    }
  }

  @override
  Future<User?> sendEmailVerification(User user) async {
    if (!user.emailVerified) {
      await user.sendEmailVerification();
      log('Verification email sent', name: 'debug');
    } else {
      log('Email is already verified', name: 'debug');
    }
    return user;
  }
}
