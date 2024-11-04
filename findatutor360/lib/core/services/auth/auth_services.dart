// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findatutor360/core/models/auth/user_model.dart';
import 'package:findatutor360/core/view_models/auth/auth_controller.dart';
import 'package:findatutor360/utils/operation_runner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';

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

  Future<void> addUserInfo(
    User user,
    String? userName,
    String? email,
    String? photoUrl,
    String? backGround,
    String? dOB,
    String? sex,
    String? phoneNumber,
    String? eduLevel,
    String? college,
    String? certificate,
    String? certificateDetails,
    String? certImageUrl,
    String? award,
    String? awardDetails,
    String? awardImageUrl,
  );

  Future<void> updateUserInfo(
    BuildContext context, {
    String? fullName,
    String? backGround,
    String? dOB,
    String? sex,
    String? phoneNumber,
    String? photoUrl,
    String? eduLevel,
    String? college,
    String? certificate,
    String? certificateDetails,
    String? certImageUrl,
    String? award,
    String? awardDetails,
    String? awardImageUrl,
  });

  Future<Users?> getUserInfo(String userId);
}

class AuthServiceImpl implements AuthService {
  AuthServiceImpl();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FacebookAuth facebookAuth = FacebookAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @override
  Future<User?> continueWithGoogle(BuildContext context) async {
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser?.authentication;

    if (googleAuth != null) {
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final response = await _auth.signInWithCredential(credential);

      await GoogleSignIn().signOut();
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
  Future<void> addUserInfo(
    User user,
    String? userName,
    String? email,
    String? photoUrl,
    String? backGround,
    String? dOB,
    String? sex,
    String? phoneNumber,
    String? eduLevel,
    String? college,
    String? certificate,
    String? certificateDetails,
    String? certImageUrl,
    String? award,
    String? awardDetails,
    String? awardImageUrl,
  ) async {
    try {
      Users newUser = Users(
        uId: user.uid,
        fullName: userName,
        email: email,
        photoUrl: photoUrl,
        backGround: backGround,
        dOB: dOB,
        sex: sex,
        phoneNumber: phoneNumber,
        eduLevel: eduLevel,
        college: college,
        certificate: certificate,
        certificateDetails: certificateDetails,
        certImageUrl: certImageUrl,
        award: award,
        awardDetails: awardDetails,
        awardImageUrl: awardImageUrl,
      );

      final data = newUser.toJson();
      data['createdAt'] = FieldValue.serverTimestamp();
      await _fireStore.collection('Users').doc(user.uid).set(
            data,
          );
      log("User added to DB successfully!", name: 'debug');
    } catch (e) {
      log(e.toString(), name: 'debug');

      rethrow;
    }
  }

  @override
  Future<void> updateUserInfo(
    BuildContext context, {
    String? fullName,
    String? backGround,
    String? dOB,
    String? sex,
    String? phoneNumber,
    String? photoUrl,
    String? eduLevel,
    String? college,
    String? certificate,
    String? certificateDetails,
    String? certImageUrl,
    String? award,
    String? awardDetails,
    String? awardImageUrl,
  }) async {
    try {
      final updatedData = Users(
        uId: _auth.currentUser!.uid,
        fullName: fullName,
        photoUrl: photoUrl,
        email: _auth.currentUser!.email,
        phoneNumber: phoneNumber,
        dOB: dOB,
        backGround: backGround,
        award: award,
        awardDetails: awardDetails,
        awardImageUrl: awardImageUrl,
        eduLevel: eduLevel,
        college: college,
        certificate: certificate,
        certificateDetails: certificateDetails,
        certImageUrl: certImageUrl,
        sex: sex,
      );
      final data = updatedData.toJson()
        ..['updatedAt'] = FieldValue.serverTimestamp();
      await _fireStore
          .collection('Users')
          .doc(_auth.currentUser?.uid)
          .update(data);

      Provider.of<AuthController>(context, listen: false)
          .setUserInfo(updatedData);

      log("User info updated successfully!", name: 'debug');
    } catch (e) {
      log("Failed to update user info: $e", name: 'debug');
      rethrow;
    }
  }

  @override
  Future<Users?> getUserInfo(String userId) async {
    try {
      DocumentSnapshot doc =
          await _fireStore.collection('Users').doc(userId).get();
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Users user = Users.fromJson(data);
        log("User info retrieved successfully!", name: 'debug');
        return user;
      } else {
        log("User not found", name: 'debug');
        return null;
      }
    } catch (e) {
      log("Failed to get user info: $e", name: 'debug');
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
    await facebookAuth.logOut();
    log('Log out successfully', name: 'debug');
  }
}
