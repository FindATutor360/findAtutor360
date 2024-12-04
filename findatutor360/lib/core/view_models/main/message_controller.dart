import 'package:findatutor360/core/models/main/message_model.dart';
import 'package:findatutor360/core/services/main/message_service.dart';
import 'package:findatutor360/utils/base_provider.dart';
import 'package:findatutor360/utils/injection_container.dart';

/// Controller class to manage message-related functionality.
/// Inherits from [BaseProvider] for state management.
class MessageController extends BaseProvider {
  // Dependency injection to access the MessageService implementation.
  final MessageServiceImpl _messageServiceImpl =
      locator.get<MessageServiceImpl>();

  // Private list to store messages fetched from the service.
  final List<Messages> _messages = [];

  // Getter to expose the messages list.
  List<Messages> get messages => _messages;

  /// Sends a message from the sender to the recipient.
  ///
  /// [senderEmail] - The email of the sender.
  /// [message] - The content of the message.
  /// [recipientEmail] - The email of the recipient.
  /// [recipientName] - The name of the recipient.
  /// [recipientPhotoUrl] - The profile photo URL of the recipient.
  Future<void> sendMessage(
    String? senderEmail,
    String? message,
    String? recipientEmail,
    String? recipientName,
    String? recipientPhotoUrl,
  ) async {
    await _messageServiceImpl.sendMessage(
      senderEmail,
      message,
      recipientEmail,
      recipientName,
      recipientPhotoUrl,
    );
  }

  /// Streams a list of messages exchanged between the current user and a recipient.
  ///
  /// [currentUserEmail] - The email of the current user.
  /// [recipientEmail] - The email of the recipient.
  /// Returns a [Stream] of [Messages].
  Stream<List<Messages>> getMessages(
    String currentUserEmail,
    String recipientEmail,
  ) {
    return _messageServiceImpl.getMessages(
      currentUserEmail,
      recipientEmail,
    );
  }

  /// Streams the latest messages for the current user from all conversations.
  ///
  /// [currentUserEmail] - The email of the current user.
  /// Returns a [Stream] of latest messages represented as a list of [Map].
  Stream<List<Map<String, dynamic>>> getLatestMessages(
      String currentUserEmail) {
    return _messageServiceImpl.getLatestMessages(currentUserEmail);
  }
}
