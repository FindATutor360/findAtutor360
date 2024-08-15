// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findatutor360/core/models/auth/user_model.dart';
import 'package:findatutor360/core/services/auth/auth_services.dart';
import 'package:findatutor360/utils/base_provider.dart';
import 'package:findatutor360/utils/injection_container.dart';
import 'package:findatutor360/utils/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthController extends BaseProvider {
  final AuthServiceImpl _authServiceImpl = locator.get<AuthServiceImpl>();
  AppPreferences appPreferences = AppPreferences();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final ValueNotifier<bool> _isLoadings = ValueNotifier<bool>(false);

  Users? _user;
  ValueNotifier<bool> get isLoading => _isLoadings;

  final List<Users> _users = [];
  List<Users> get users => _users;

  Users? get user => _user;

  Future<User?> continueWithGoogle(BuildContext context) async {
    _isLoadings.value = true;

    User? user = await _authServiceImpl.continueWithGoogle(
      context,
    );
    _isLoadings.value = false;

    if (user != null) {
      await sendEmailVerification(user,
          name: user.displayName, email: user.email);

      String? userToken = await user.getIdToken();
      if (userToken != null) {
        await appPreferences.setString('userToken', userToken);
        log('User token: $userToken', name: 'debug');
      } else {
        log('Failed to get user token.', name: 'debug');
      }
    }

    return user;
  }

  Future<User?> signUp(
    BuildContext context, {
    required String fullName,
    required String email,
    required String password,
  }) async {
    _isLoadings.value = true;

    User? user = await _authServiceImpl.signUp(
      context,
      fullName: fullName,
      email: email,
      password: password,
    );
    _isLoadings.value = false;

    if (user != null) {
      sendEmailVerification(user, name: fullName, email: email);

      String? userToken = await user.getIdToken();
      if (userToken != null) {
        await appPreferences.setString('userToken', userToken);
        log('User token: $userToken', name: 'debug');
      } else {
        log('Failed to get user token.', name: 'debug');
      }
    }

    return user;
  }

  Future<User?> logIn(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    _isLoadings.value = true;

    User? user = await _authServiceImpl.logIn(
      context,
      email: email,
      password: password,
    );
    _isLoadings.value = false;

    if (user != null) {
      String? userToken = await user.getIdToken();
      if (userToken != null) {
        await appPreferences.setString('userToken', userToken);
        log('User token: $userToken', name: 'debug');
      } else {
        log('Failed to get user token.', name: 'debug');
      }
    }

    return user;
  }

  Future<User?> continueWithFacebook(BuildContext context) async {
    _isLoadings.value = true;

    User? user = await _authServiceImpl.continueWithFacebook(
      context,
    );
    _isLoadings.value = false;

    if (user != null) {
      sendEmailVerification(user, name: user.displayName!, email: user.email!);
      // Send verification email

      String? userToken = await user.getIdToken();
      if (userToken != null) {
        await appPreferences.setString('userToken', userToken);
        log('User token: $userToken', name: 'debug');
      } else {
        log('Failed to get user token.', name: 'debug');
      }
    }

    return user;
  }

  Future<void> logout(
      // BuildContext context,
      ) async {
    await appPreferences.remove('userToken');
    await _authServiceImpl.logout();
  }

  Future<void> sendEmailVerification(
    User user, {
    required String? name,
    required String? email,
  }) async {
    if (!user.emailVerified) {
      await user.sendEmailVerification();
      log('Verification email sent', name: 'debug');
    } else if (user.emailVerified) {
      await addUserInfo(
        user,
        name,
        email,
        user.photoURL,
      );
    }

    return;
  }

  Future<void> addUserInfo(
      User user, String? userName, String? email, String? photoUrl) async {
    try {
      Users newUser = Users(
        uId: user.uid,
        fullName: userName,
        email: email,
        photoUrl: photoUrl,
      );

      final data = newUser.toJson();
      data['createdAt'] = FieldValue.serverTimestamp();
      await _firestore.collection('Users').doc(user.uid).set(
            data,
          );
      log("User added to DB successfully!", name: 'debug');
    } catch (e) {
      log(e.toString(), name: 'debug');

      rethrow;
    }
  }
}
