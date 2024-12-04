// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findatutor360/core/models/auth/user_model.dart';
import 'package:findatutor360/core/view_models/auth/auth_controller.dart';
import 'package:findatutor360/utils/operation_runner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';

abstract class AuthService {
  // Handles Google sign-in and returns the authenticated Firebase user
  Future<User?> continueWithGoogle(BuildContext context);

  // Registers a new user with email and password
  Future<User?> signUp(
    BuildContext context, {
    required String fullName,
    required String email,
    required String password,
  });

  // Logs in a user with email and password, ensuring the email is verified
  Future<User?> logIn(
    BuildContext context, {
    required String email,
    required String password,
  });

  // Handles Facebook sign-in and returns the authenticated Firebase user
  Future<User?> continueWithFacebook(BuildContext context);

  // Sends a password reset email to the user
  Future<void> resetPassword({required String email});

  // Logs out the user from all authentication providers
  Future<void> logout();

  // Adds user information to Firestore database after registration
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

  // Updates existing user information in Firestore
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

  // Retrieves a user document from Firestore by userID
  Stream<Users?> getUserInfo(String userId);
}

class AuthServiceImpl implements AuthService {
  AuthServiceImpl();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FacebookAuth facebookAuth = FacebookAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final String webClientID = dotenv.env['WEB_CLIENT_ID'] ?? '';
  final String hostedDomainID = dotenv.env['HOSTED_DOMAIN'] ?? '';

  // Google Sign-In implementation for both Web and Native platforms
  @override
  Future<User?> continueWithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: kIsWeb ? webClientID : null,
        hostedDomain: kIsWeb ? hostedDomainID : null,
      );

      GoogleSignInAccount? googleUser;

      if (kIsWeb) {
        // For Web
        googleUser = await googleSignIn.signInSilently();
      } else {
        // For Native (Android/iOS/Desktop)
        googleUser = await googleSignIn.signIn();
      }

      // If user is null, the sign-in process was canceled or failed
      if (googleUser == null) {
        showSnackMessage(context, "Google sign-in error", isError: true);
        return null;
      }

      // Retrieve authentication tokens
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create credential for Firebase
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      if (!kIsWeb) {
        await GoogleSignIn().signOut();
      }

      // Sign in with Firebase
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      return userCredential.user;
    } catch (e) {
      // Handle exceptions and errors
      showSnackMessage(context, "Google sign-in error: $e", isError: true);
      log("Google sign-in error: $e", name: 'Google sign in');
      return null;
    }
  }

  // Registers a user and returns the created user
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

  // Logs in a user, requiring email verification
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

  // Facebook Sign-In implementation
  @override
  Future<User?> continueWithFacebook(BuildContext context) async {
    try {
      // Log in with Facebook
      final LoginResult result = await facebookAuth.login(
        permissions: ['email', 'public_profile'],
      );

      if (result.status == LoginStatus.success) {
        // Extract the Facebook OAuth credential
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(result.accessToken!.token);

        await facebookAuth.logOut();

        // Authenticate with Firebase
        UserCredential userCredential =
            await _auth.signInWithCredential(facebookAuthCredential);

        return userCredential.user; // Return the authenticated user
      } else {
        showSnackMessage(context, "${result.status}", isError: true);
        log('Facebook sign-in failed: ${result.status}', name: 'Facebook');
        return null;
      }
    } catch (e) {
      showSnackMessage(context,
          "An account already exists with the same email address but different sign-in credentials.",
          isError: true);
      log('Error during Facebook sign-in: $e', name: 'Facebook');
      return null;
    }
  }

  // Sends password reset email
  @override
  Future<void> resetPassword({required String email}) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

// Adds a user's information to Firestore after registration
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
      fullName: userName ?? '',
      email: email ?? '',
      photoUrl: photoUrl ?? '',
      backGround: backGround ?? '',
      dOB: dOB ?? '',
      sex: sex ?? '',
      phoneNumber: phoneNumber ?? '',
      eduLevel: eduLevel ?? '',
      college: college ?? '',
      certificate: certificate ?? '',
      certificateDetails: certificateDetails ?? '',
      certImageUrl: certImageUrl ?? '',
      award: award ?? '',
      awardDetails: awardDetails ?? '',
      awardImageUrl: awardImageUrl ?? '',
    );

    final data = newUser.toJson();
    data['createdAt'] = FieldValue.serverTimestamp();

    await _fireStore.collection('Users').doc(user.uid).set(
          data,
          SetOptions(
              merge:
                  true), // This ensures we don't overwrite the entire document
        );

    log("User added to DB successfully!", name: 'debug');
  }

// Updates existing user information in Firestore
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

  // Retrieves a user document from Firestore by userID
  @override
  Stream<Users?> getUserInfo(String userId) {
    return _fireStore.collection('Users').doc(userId).snapshots().map((data) {
      final json = data.data();
      if (json != null) {
        return Users.fromJson(json);
      }
      return null;
    });
  }

  // Logs out from Firebase and Facebook
  @override
  Future<void> logout() async {
    await _auth.signOut();
    await facebookAuth.logOut();
    log('Log out successfully', name: 'debug');
  }
}
