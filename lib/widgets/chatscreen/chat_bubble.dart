import 'package:flutter/material.dart';
import 'package:mini_chat_app/constants/constants.dart';
import 'package:mini_chat_app/models/user_model.dart';

/// Widget used to display a single chat message bubble
/// Handles both sender (me) and receiver (other user)
class ChatBubble extends StatelessWidget {

  /// User with whom the chat is happening
  final UserModel user;

  /// Message text
  final String text;

  /// Identifies whether the message is sent by current user
  final bool isMe;

  /// Time at which message was sent or received
  final String time;

  const ChatBubble({
    super.key,
    required this.user,
    required this.text,
    required this.isMe,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Vertical spacing between messages
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        // Align message left or right based on sender
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,

        // Align avatars and bubbles at bottom
        crossAxisAlignment: CrossAxisAlignment.end,

        children: [
          // Show receiver avatar only for incoming messages
          if (!isMe) _userAvatar(),

          // Column containing message bubble and time
          Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              // Message bubble container
              Container(
                padding: const EdgeInsets.all(12),
                constraints: const BoxConstraints(maxWidth: 260),
                decoration: BoxDecoration(
                  // Different color for sender and receiver
                  color: isMe ? kPrimary : const Color(0xFFF1F1F1),

                  // Custom bubble shape
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(isMe ? 16 : 0),
                    topRight: Radius.circular(isMe ? 0 : 16),
                    bottomLeft: const Radius.circular(16),
                    bottomRight: const Radius.circular(16),
                  ),
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    color: isMe ? Colors.white : Colors.black,
                  ),
                ),
              ),

              // Small spacing between bubble and time
              const SizedBox(height: 4),

              // Message time shown below bubble
              Text(
                time,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          // Show sender avatar only for outgoing messages
          if (isMe) _myAvatar(),
        ],
      ),
    );
  }

  /// Avatar shown for sender (current user)
  Widget _myAvatar() {
    return Padding(
      // Adds spacing to align avatar with bubble
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 40),
      child: Container(
        width: 36,
        height: 36,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          // Gradient background for sender avatar
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xffb250e8),
              Color(0xFFe63eae),
            ],
            stops: [
              0.0,
              0.5,
            ],
          ),
        ),
        child: const Center(
          child: Text(
            'Y',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  /// Avatar shown for receiver (selected user)
  Widget _userAvatar() {
    return Padding(
      // Extra vertical spacing for alignment
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 60),
      child: Container(
        width: 36,
        height: 36,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          // Gradient background for receiver avatar
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF5877fb),
              Color(0xFF9a57fa),
            ],
            stops: [
              0.0,
              0.99,
            ],
          ),
        ),
        child: Center(
          child: Text(
            // First letter of receiver name
            user.name[0].toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
