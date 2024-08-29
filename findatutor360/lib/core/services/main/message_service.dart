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
  );
  Stream<List<Messages>> getMessages(
    String currentUserEmail,
    String recipientEmail,
  );
  Stream<List<Messages>> getLatestMessages(String currentUserEmail);
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
      String? recipientPhotoUrl) async {
    try {
      // Ensure that both senderEmail and recipientEmail are included in participants
      List<String> participants = [senderEmail!, recipientEmail!];

      Messages messages = Messages(
        id: null,
        senderEmail: senderEmail,
        recipientEmail: recipientEmail,
        senderName: _auth.currentUser!.displayName,
        senderPhotoUrl: _auth.currentUser!.photoURL,
        recipientName: recipientName,
        recipientPhotoUrl: recipientPhotoUrl,
        participants: participants, // Explicitly set participants list
        message: message!,
        createdAt: DateTime.now(),
        readBy: [], // Initialize as an empty list
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
      List<Messages> messages = snapshot.docs
          .map((doc) => Messages.fromJson(doc.data()))
          .where((message) => message.participants!.contains(recipientEmail))
          .toList();

      for (var message in messages) {
        if (message.recipientEmail == currentUserEmail &&
            !message.readBy!.contains(currentUserEmail)) {
          message.readBy!.add(currentUserEmail);
          _fireStore
              .collection('Messages')
              .doc(message.id!)
              .update({'readBy': message.readBy});
        }
      }

      return messages;
    });
  }

  @override
  Stream<List<Messages>> getLatestMessages(String currentUserEmail) {
    return _fireStore
        .collection('Messages')
        .where('participants', arrayContains: currentUserEmail)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      final messages =
          snapshot.docs.map((doc) => Messages.fromJson(doc.data())).toList();
      final Map<String, Messages> latestMessages = {};

      for (var message in messages) {
        final otherUser = message.participants!
            .firstWhere((email) => email != currentUserEmail);
        if (!latestMessages.containsKey(otherUser)) {
          latestMessages[otherUser] = message;
        }

        // Mark message as read if the current user is the recipient
        if (message.recipientEmail == currentUserEmail &&
            !message.readBy!.contains(currentUserEmail)) {
          message.readBy!.add(currentUserEmail);
          _fireStore
              .collection('Messages')
              .doc(message.id!)
              .update({'readBy': message.readBy});
        }
      }

      return latestMessages.values.toList();
    });
  }
}
