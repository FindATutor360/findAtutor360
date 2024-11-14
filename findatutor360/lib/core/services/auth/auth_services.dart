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
  Future<void> resetPassword({required String email});
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

  Future<Users?> getUserByEmail(String email);

  Stream<Users?> getUserInfo(String userId);
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

    if (credential.user?.emailVerified ?? false) {
      return credential.user;
    } else {
      await _auth.signOut();

      if (context.mounted) {
        showSnackMessage(
          context,
          "Please verify your email before logging in",
          isError: true,
        );
      }
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

      User? user = credential.user;

      return user;
    }
    return null;
  }

  @override
  Future<void> resetPassword({required String email}) async {
    await _auth.sendPasswordResetEmail(email: email);
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
  }

  @override
  Stream<Users?> getUserInfo(String userId) {
    return _fireStore
        .collection('Users')
        .doc(userId)
        .snapshots()
        .map((data) => Users.fromJson(data.data()!));
  }

  @override
  Future<Users?> getUserByEmail(String email) async {
    // Query the Firestore collection to find the user by email
    final querySnapshot = await _fireStore
        .collection('Users') // Replace 'users' with your actual collection name
        .where('email', isEqualTo: email)
        .limit(1) // Limit to 1 result for optimization
        .get();

    // Check if the user was found
    if (querySnapshot.docs.isNotEmpty) {
      // Convert the document data to a Users instance
      final userData = querySnapshot.docs.first.data();
      return Users.fromJson(userData);
    }

    // Return null if no user is found or an error occurs
    return null;
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
    await facebookAuth.logOut();
    log('Log out successfully', name: 'debug');
  }
}
