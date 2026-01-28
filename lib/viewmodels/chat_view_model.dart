import 'package:flutter/material.dart';
import '../models/message_model.dart';
import '../api_services/chat_service.dart';

/// ViewModel responsible for all chat-related business logic
/// This includes:
/// - Sending messages
/// - Receiving messages from API
/// - Handling offline fallback replies
class ChatViewModel extends ChangeNotifier {

  /// Service used to communicate with backend / API
  final ChatService _service = ChatService();

  /// Stores all chat messages (both sender and receiver)
  final List<MessageModel> messages = [];

  /// Predefined fallback replies used when API fails or device is offline
  final List<String> _offlineReplies = [
    'I am offline right now',
    'No internet connection',
    'Please try again later',
    'Message received, will reply soon',
  ];

  /// Returns the current time in 12-hour format (hh:mm AM/PM)
  /// Example: 10:30 AM
  String _getCurrentTime() {
    final now = DateTime.now();

    final hour = now.hour > 12 ? now.hour - 12 : now.hour;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';

    return '$hour:$minute $period';
  }

  /// Picks a random offline reply from predefined list
  String _getOfflineReply() {
    _offlineReplies.shuffle();
    return _offlineReplies.first;
  }

  /// Handles the complete message sending flow
  ///
  /// Flow:
  /// 1. Add sender message
  /// 2. Update chat history
  /// 3. Call API for receiver message
  /// 4. If API fails, send offline fallback reply
  Future<void> sendMessage({
    required String text,
    required void Function(String) onHistoryUpdate,
  }) async {

    /// Step 1: Add sender message immediately
    messages.add(
      MessageModel(
        id: DateTime.now().millisecondsSinceEpoch,
        text: text,
        isMe: true,
        time: _getCurrentTime(),
      ),
    );

    /// Notify UI so sender message appears instantly
    notifyListeners();

    /// Update chat history list
    onHistoryUpdate(text);

    /// Step 2: Try fetching receiver message from API
    try {
      final apiMessages = await _service.fetchReceiverMessages();

      /// If API returns a message, add it
      if (apiMessages.isNotEmpty) {
        messages.add(apiMessages.first);
      } else {
        /// API returned empty response, use fallback reply
        messages.add(
          MessageModel(
            id: DateTime.now().millisecondsSinceEpoch,
            text: _getOfflineReply(),
            isMe: false,
            time: _getCurrentTime(),
          ),
        );
      }
    } catch (e) {
      /// Step 3: API failed (offline / error)
      /// Add offline fallback auto-reply
      messages.add(
        MessageModel(
          id: DateTime.now().millisecondsSinceEpoch,
          text: _getOfflineReply(),
          isMe: false,
          time: _getCurrentTime(),
        ),
      );

      debugPrint('API ERROR: $e');
    }

    /// Notify UI after receiver message is added
    notifyListeners();
  }
}
