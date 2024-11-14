// ignore_for_file: sdk_version_since

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findatutor360/core/models/main/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class MessageService {
  Future<void> sendMessage(
    String? senderEmail,
    String? message,
    String? recipientEmail,
    String? recipientName,
    String? recipientPhotoUrl,
    String? recipientBackground,
    String? senderBackground,
  );
  Stream<List<Messages>> getMessages(
    String currentUserEmail,
    String recipientEmail,
  );
  Stream<List<Map<String, dynamic>>> getLatestMessages(String currentUserEmail);
}

class MessageServiceImpl implements MessageService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<void> sendMessage(
    String? senderEmail,
    String? message,
    String? recipientEmail,
    String? recipientName,
    String? recipientPhotoUrl,
    String? recipientBackground,
    String? senderBackground,
  ) async {
    try {
      // Ensure that both senderEmail and recipientEmail are included in participants
      List<String> participants = [senderEmail!, recipientEmail!];

      Messages messages = Messages(
        id: null,
        senderEmail: senderEmail,
        recipientEmail: recipientEmail,
        senderName: _auth.currentUser!.displayName,
        senderPhotoUrl: _auth.currentUser!.photoURL,
        // senderBackground: senderBackground,
        // recipientBackground: recipientBackground,
        recipientName: recipientName,
        recipientPhotoUrl: recipientPhotoUrl,
        participants: participants, // Explicitly set participants list
        message: message!,
        createdAt: DateTime.timestamp().toUtc(),
        readBy: false, // Initialize as false
      );

      DocumentReference docRef = await _fireStore.collection('Messages').add(
            messages.toJson(),
          );
      await _fireStore
          .collection('Messages')
          .doc(docRef.id)
          .update({'id': docRef.id});
      log("Message added to DB successfully!", name: 'debug');
    } catch (e) {
      log(e.toString(), name: 'debug');
      rethrow;
    }
  }

  @override
  Stream<List<Messages>> getMessages(
    String currentUserEmail,
    String recipientEmail,
  ) {
    return _fireStore
        .collection('Messages')
        .where('participants', arrayContains: currentUserEmail)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      // Fetch messages between the current user and recipient
      List<Messages> messages = snapshot.docs
          .map((doc) => Messages.fromJson(doc.data()))
          .where((message) => message.participants!.contains(recipientEmail))
          .toList();

      // Iterate through each message and update the readBy flag if necessary
      for (var message in messages) {
        if (message.recipientEmail == currentUserEmail &&
            message.readBy == false) {
          _fireStore
              .collection('Messages')
              .doc(message.id!)
              .update({'readBy': true});
          message.readBy = true;
        }
      }

      return messages;
    });
  }

  // @override
  // Stream<List<Messages>> getMessages(
  //   String currentUserEmail,
  //   String recipientEmail,
  // ) {
  //   return _fireStore
  //       .collection('Messages')
  //       .where('participants', arrayContains: currentUserEmail)
  //       .orderBy('createdAt', descending: true)
  //       .snapshots()
  //       .map((snapshot) {
  //     List<Messages> messages = snapshot.docs
  //         .map((doc) => Messages.fromJson(doc.data()))
  //         .where((message) => message.participants!.contains(recipientEmail))
  //         .toList();

  //     for (var message in messages) {
  //       if (message.recipientEmail == currentUserEmail &&
  //           message.readBy == false) {
  //         _fireStore
  //             .collection('Messages')
  //             .doc(message.id!)
  //             .update({'readBy': true});
  //         message.readBy = true;
  //       }
  //     }

  //     return messages;
  //   });
  // }

  @override
  Stream<List<Map<String, dynamic>>> getLatestMessages(
    String currentUserEmail,
  ) {
    return _fireStore
        .collection('Messages')
        .where('participants', arrayContains: currentUserEmail)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      final messages =
          snapshot.docs.map((doc) => Messages.fromJson(doc.data())).toList();

      final Map<String, Map<String, dynamic>> latestMessages = {};

      for (var message in messages) {
        // Determine the other user in the conversation
        final otherUser = message.participants!
            .firstWhere((email) => email != currentUserEmail);

        // Initialize latestMessages entry if not present
        if (!latestMessages.containsKey(otherUser)) {
          latestMessages[otherUser] = {
            'latestMessage': message,
            'unreadCount': 0,
          };
        }

        // Update latestMessage and unreadCount if needed
        if (message.senderEmail == otherUser) {
          if (message.recipientEmail == currentUserEmail && !message.readBy!) {
            latestMessages[otherUser]!['unreadCount'] =
                (latestMessages[otherUser]!['unreadCount'] as int) + 1;
          }
        }

        // Update latest message entry
        if (message.createdAt!.isAfter(
            (latestMessages[otherUser]!['latestMessage'] as Messages)
                .createdAt!)) {
          latestMessages[otherUser]!['latestMessage'] = message;
        }
      }

      return latestMessages.values.toList();
    });
  }
  // Stream<List<Map<String, dynamic>>> getLatestMessages(
  //   String currentUserEmail,
  // ) {
  //   return _fireStore
  //       .collection('Messages')
  //       .where('participants', arrayContains: currentUserEmail)
  //       .orderBy('createdAt', descending: true)
  //       .snapshots()
  //       .map((snapshot) {
  //     final messages =
  //         snapshot.docs.map((doc) => Messages.fromJson(doc.data())).toList();
  //     final Map<String, Map<String, dynamic>> latestMessages = {};

  //     for (var message in messages) {
  //       final otherUser = message.participants!
  //           .firstWhere((email) => email != currentUserEmail);

  //       // Check if the message is unread and count it
  //       if (!latestMessages.containsKey(otherUser)) {
  //         latestMessages[otherUser] = {
  //           'latestMessage': message,
  //           'unreadCount': message.readBy == false ? 1 : 0,
  //         };
  //       } else {
  //         if (message.readBy == false) {
  //           latestMessages[otherUser]!['unreadCount'] =
  //               latestMessages[otherUser]!['unreadCount'] + 1;
  //         }
  //       }
  //     }

  //     return latestMessages.values.toList();
  //   });
  // }
}
