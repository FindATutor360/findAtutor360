// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:findatutor360/core/models/auth/user_model.dart';
import 'package:findatutor360/core/services/auth/auth_services.dart';
import 'package:findatutor360/utils/base_provider.dart';
import 'package:findatutor360/utils/injection_container.dart';
import 'package:findatutor360/utils/operation_runner.dart';
import 'package:findatutor360/utils/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthController extends BaseProvider {
  final AuthServiceImpl _authServiceImpl = locator.get<AuthServiceImpl>();
  AppPreferences appPreferences = AppPreferences();

  final ValueNotifier<bool> _isLoadings = ValueNotifier<bool>(false);

  Users? _user;
  ValueNotifier<bool> get isLoading => _isLoadings;

  final List<Users> _users = [];
  List<Users> get users => _users;

  Users? get user => _user;

  late Stream<Users?>? userStream;

  String? _fullName;
  String? _photoUrl;
  String? _phoneNumber;
  String? _dOB;
  String? _sex;
  String? _backGround;
  String? _eduLevel;
  String? _college;
  String? _certificate;
  String? _certificateDetails;
  String? _certImageUrl;
  String? _award;
  String? _awardDetails;
  String? _awardImageUrl;

  void setUserInfo(Users users) {
    _user = users;
    notifyListeners();
  }

  void startUserInfo(String userId) {
    userStream = _authServiceImpl.getUserInfo(userId);
    userStream?.listen((updatedUserInfo) {
      if (updatedUserInfo != null) {
        setUserInfo(updatedUserInfo);
      }
    });
  }

  Future<void> storeUserToken(User user) async {
    String? userToken = await user.getIdToken();
    if (userToken != null) {
      await appPreferences.setString('userToken', userToken);
      log('User token: $userToken', name: 'debug');
    } else {
      log('Failed to get user token.', name: 'debug');
    }
  }

  void clearUserData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (user != null) {
        _user = null;

        notifyListeners();
      } else {
        log("No user data to clear.", name: 'debug');
      }
    });
  }

  Future<void> _handleError(BuildContext context, dynamic e) async {
    log('$e', name: 'debug');
    showSnackMessage(context, '$e', isError: true);
  }

  Future<User?> continueWithGoogle(BuildContext context) async {
    _isLoadings.value = true;
    try {
      User? user = await _authServiceImpl.continueWithGoogle(
        context,
      );
      _isLoadings.value = false;

      if (user != null) {
        await user.updateProfile(displayName: user.displayName);
        await user.verifyBeforeUpdateEmail(user.email!);

        await sendEmailVerification(
          user,
          context,
          name: user.displayName,
          email: user.email,
        );

        await storeUserToken(user);
      } else {
        await user?.updateProfile(displayName: user.displayName ?? '');
        await user?.verifyBeforeUpdateEmail(user.email ?? '');

        await sendEmailVerification(
          user,
          context,
          name: user?.displayName,
          email: user?.email,
        );

        await storeUserToken(user!);
      }

      return user;
    } on FirebaseAuthException catch (e) {
      _handleError(context, e);
    }
    return null;
  }

  Future<User?> signUp(
    BuildContext context, {
    required String fullName,
    required String email,
    required String password,
  }) async {
    _isLoadings.value = true;

    try {
      User? user = await _authServiceImpl.signUp(
        context,
        fullName: fullName,
        email: email,
        password: password,
      );

      if (user != null) {
        await user.updateProfile(displayName: fullName);
        await user.verifyBeforeUpdateEmail(email);

        await sendEmailVerification(
          user,
          context,
          name: fullName,
          email: email,
        );

        await storeUserToken(user);
      } else {
        await user?.updateProfile(displayName: fullName);
        await user?.verifyBeforeUpdateEmail(email);

        await sendEmailVerification(
          user,
          context,
          name: fullName,
          email: email,
        );

        await storeUserToken(user!);
      }

      return user;
    } on FirebaseAuthException catch (e) {
      _handleError(context, e);
      return null;
    } finally {
      _isLoadings.value = false;
    }
  }

  Future<User?> logIn(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    _isLoadings.value = true;
    try {
      User? user = await _authServiceImpl.logIn(
        context,
        email: email,
        password: password,
      );
      _isLoadings.value = false;

      if (user != null) {
        await storeUserToken(user);
      }

      return user;
    } on FirebaseAuthException catch (e) {
      _handleError(context, e);

      return null;
    } finally {
      _isLoadings.value = false;
    }
  }

  Future<User?> continueWithFacebook(BuildContext context) async {
    _isLoadings.value = true;

    try {
      User? user = await _authServiceImpl.continueWithFacebook(context);

      if (user != null) {
        await sendEmailVerification(
          user,
          context,
          name: user.displayName!,
          email: user.email!,
        );
        await storeUserToken(user);
      } else {
        await user?.updateProfile(displayName: user.displayName);
        await user?.verifyBeforeUpdateEmail(user.email ?? '');

        await sendEmailVerification(
          user,
          context,
          name: user?.displayName,
          email: user?.email,
        );

        await storeUserToken(user!);
      }

      return user;
    } on FirebaseAuthException catch (e) {
      _handleError(context, e);

      return null;
    } finally {
      _isLoadings.value = false; // Ensure the loading state is reset
    }
  }

  Future<void> resetPassword({required String email}) async {
    _isLoadings.value = true;
    try {
      await _authServiceImpl.resetPassword(email: email);
      log('User\'s $email.', name: 'debug');
    } catch (e) {
      log('Failed to get user\'s $email.', name: 'debug');
    }
  }

  Future<void> updatePersonalDetails(
    String? fullName,
    String? backGround,
    String? dOB,
    String? sex,
  ) async {
    _isLoadings.value = true;
    try {
      _fullName = fullName;
      _backGround = backGround;
      _dOB = dOB;
      _sex = sex;
      _isLoadings.value = false;
      notifyListeners();
    } catch (e) {
      _isLoadings.value = false;
      throw Exception("Personal details are missing");
    }
  }

  Future<void> updateContactDetails(
    String? phoneNumber,
    String? photoUrl,
  ) async {
    _isLoadings.value = true;
    try {
      _phoneNumber = phoneNumber;
      _photoUrl = photoUrl;
      _isLoadings.value = false;
      notifyListeners();
    } catch (e) {
      _isLoadings.value = false;
      throw Exception("Personal details are missing");
    }
  }

  Future<void> updateEducationDetails(
    String? eduLevel,
    String? college,
    String? certificate,
    String? certificateDetails,
    String? certImageUrl,
    String? award,
    String? awardDetails,
    String? awardImageUrl,
  ) async {
    _isLoadings.value = true;
    try {
      _eduLevel = eduLevel;
      _college = college;
      _certificate = certificate;
      _certificateDetails = certificateDetails;
      _certImageUrl = certImageUrl;
      _award = award;
      _awardDetails = awardDetails;
      _awardImageUrl = awardImageUrl;
      _isLoadings.value = false;
      notifyListeners();
    } catch (e) {
      _isLoadings.value = false;
      throw Exception("Personal details are missing");
    }
  }

  Future<void> updateUserInfo(BuildContext context) async {
    _isLoadings.value = true;
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        // Update user information
        await _authServiceImpl.updateUserInfo(
          context,
          fullName: _fullName,
          backGround: _backGround,
          dOB: _dOB,
          sex: _sex,
          phoneNumber: _phoneNumber,
          photoUrl: _photoUrl,
          eduLevel: _eduLevel,
          college: _college,
          certificate: _certificate,
          certificateDetails: _certificateDetails,
          certImageUrl: _certImageUrl,
          award: _award,
          awardDetails: _awardDetails,
          awardImageUrl: _awardImageUrl,
        );

        // Update profile in Firebase Auth
        await currentUser.updateProfile(
            displayName: _fullName, photoURL: _photoUrl);
        await currentUser.reload();

        // Store token
        await storeUserToken(currentUser);

        log("User info updated successfully!", name: 'debug');
        resetUserInfoDetails();
      }
    } catch (e) {
      log("Failed to update user info: $e", name: 'debug');
      rethrow;
    } finally {
      _isLoadings.value = false;
    }
  }

  Future<void> logout() async {
    await appPreferences.remove('userToken');
    await _authServiceImpl.logout();
    log('Log out successfully', name: 'debug');
  }

  Future<void> sendEmailVerification(
    User? user,
    BuildContext context, {
    required String? name,
    required String? email,
  }) async {
    try {
      await for (var updatedUserInfo in getUserInfo(user!.uid)) {
        if (updatedUserInfo == null) {
          log("User data is null", name: 'debug');
          return;
        }

        if (!user.emailVerified) {
          await user.sendEmailVerification();

          Provider.of<AuthController>(context, listen: false)
              .setUserInfo(updatedUserInfo);

          await addUserInfo(
            user,
            updatedUserInfo.fullName ?? name,
            updatedUserInfo.email ?? email,
            updatedUserInfo.photoUrl ?? user.photoURL,
            updatedUserInfo.backGround ?? _backGround,
            updatedUserInfo.dOB ?? _dOB,
            updatedUserInfo.sex ?? _sex,
            updatedUserInfo.phoneNumber ?? _phoneNumber,
            updatedUserInfo.eduLevel ?? _eduLevel,
            updatedUserInfo.college ?? _college,
            updatedUserInfo.certificate ?? _certificate,
            updatedUserInfo.certificateDetails ?? _certificateDetails,
            updatedUserInfo.certImageUrl ?? _certImageUrl,
            updatedUserInfo.award ?? _award,
            updatedUserInfo.awardDetails ?? _awardDetails,
            updatedUserInfo.awardImageUrl ?? _awardImageUrl,
          );

          log('Verification email sent', name: 'debug');
        } else {
          log('User email already verified', name: 'debug');
          // Handle the case where the email is already verified
          Provider.of<AuthController>(context, listen: false)
              .setUserInfo(updatedUserInfo);

          await addUserInfo(
            user,
            updatedUserInfo.fullName ?? name,
            updatedUserInfo.email ?? email,
            updatedUserInfo.photoUrl ?? user.photoURL,
            updatedUserInfo.backGround ?? _backGround,
            updatedUserInfo.dOB ?? _dOB,
            updatedUserInfo.sex ?? _sex,
            updatedUserInfo.phoneNumber ?? _phoneNumber,
            updatedUserInfo.eduLevel ?? _eduLevel,
            updatedUserInfo.college ?? _college,
            updatedUserInfo.certificate ?? _certificate,
            updatedUserInfo.certificateDetails ?? _certificateDetails,
            updatedUserInfo.certImageUrl ?? _certImageUrl,
            updatedUserInfo.award ?? _award,
            updatedUserInfo.awardDetails ?? _awardDetails,
            updatedUserInfo.awardImageUrl ?? _awardImageUrl,
          );
        }

        // Stop the stream once we are done
        break;
      }
    } catch (e) {
      log("Error during email verification process: $e", name: 'debug');
      // _handleError(context, e);
    }
  }

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
      _authServiceImpl.addUserInfo(
        user,
        userName,
        email,
        photoUrl,
        backGround,
        dOB,
        sex,
        phoneNumber,
        eduLevel,
        college,
        certificate,
        certificateDetails,
        certImageUrl,
        award,
        awardDetails,
        awardImageUrl,
      );

      log("User added to DB successfully!", name: 'debug');
    } catch (e) {
      log(e.toString(), name: 'debug');

      rethrow;
    }
  }

  Stream<Users?> getUserInfo(String userId) {
    clearUserData();
    try {
      return _authServiceImpl.getUserInfo(userId);
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<Users>> getUserStream() {
    return _authServiceImpl.getUsersStream();
  }

  Future<Users?> getUserByEmail(String email) async {
    try {
      await _authServiceImpl.getUserByEmail(email);
    } catch (e) {
      log('Error fetching user by email: $e', name: 'debug');
    }
    return null;
  }

  void resetUserInfoDetails() {
    _fullName = null;
    _backGround = null;
    _dOB = null;
    _sex = null;
    _phoneNumber = null;
    _photoUrl = null;
    _eduLevel = null;
    _college = null;
    _certificate = null;
    _certificateDetails = null;
    _certImageUrl = null;
    _award = null;
    _awardDetails = null;
    _awardImageUrl = null;
  }
}
