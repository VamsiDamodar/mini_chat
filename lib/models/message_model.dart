/// Model class representing a single chat message
class MessageModel {

  /// Unique id of the message
  final int id;

  /// Actual message text/content
  final String text;

  /// Indicates whether the message is sent by current user
  /// true  → message sent by "me"
  /// false → message received from other user / API
  final bool isMe;

  /// Time at which the message was sent/received
  /// Example: 10:30 AM
  final String time;

  /// Constructor to create a message object
  MessageModel({
    required this.id,
    required this.text,
    required this.isMe,
    required this.time,
  });

  /// Factory constructor to create a receiver message from API response
  ///
  /// - `json` → raw API message data
  /// - `time` → generated current time when message is received
  factory MessageModel.fromApi(
    Map<String, dynamic> json,
    String time,
  ) {
    return MessageModel(
      id: json['id'],        // Message ID from API
      text: json['body'],    // Message body from API
      isMe: false,           // API messages are always receiver messages
      time: time,            // Time when message is received
    );
  }
}
