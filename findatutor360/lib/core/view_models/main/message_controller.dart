import 'package:findatutor360/core/models/main/message_model.dart';
import 'package:findatutor360/core/services/main/message_service.dart';
import 'package:findatutor360/utils/base_provider.dart';
import 'package:findatutor360/utils/injection_container.dart';

class MessageController extends BaseProvider {
  final MessageServiceImpl _messageServiceImpl =
      locator.get<MessageServiceImpl>();

  List<Messages> _messages = [];

  List<Messages> get messages => _messages;

  Future<void> sendMessage(
      String? senderEmail,
      String? message,
      String? recipientEmail,
      String? recipientName,
      String? recipientPhotoUrl) async {
    await _messageServiceImpl.sendMessage(
        senderEmail, message, recipientEmail, recipientName, recipientPhotoUrl);
  }

  Stream<List<Messages>> getMessages(
    String currentUserEmail,
    String recipientEmail,
  ) {
    return _messageServiceImpl.getMessages(
      currentUserEmail,
      recipientEmail,
    );
  }

  Stream<List<Messages>> getLatestMessages(String currentUserEmail) {
    return _messageServiceImpl.getLatestMessages(currentUserEmail);
  }
}
