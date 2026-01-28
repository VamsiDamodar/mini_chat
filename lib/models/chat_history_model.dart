import 'user_model.dart';

/// Represents ONE chat history item
/// Example:
/// - User: Alice
/// - Last message: "Hi"
/// - Updated time: 10:30 AM
class ChatHistoryModel {

  /// The user with whom the chat happened
  final UserModel user;

  /// The most recent message in this chat
  final String lastMessage;

  /// The time when the chat was last updated
  /// Used for sorting chat history (latest chat first)
  final DateTime updatedAt;

  /// Constructor to create a chat history item
  ChatHistoryModel({
    required this.user,
    required this.lastMessage,
    required this.updatedAt,
  });
}
