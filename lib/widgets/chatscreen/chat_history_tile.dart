import 'package:flutter/material.dart';
import 'package:mini_chat_app/screens/chat_screen.dart';
import '../../models/chat_history_model.dart';

/// Widget that displays a single chat history item
/// Example: User avatar + name + last message + last seen time
class ChatHistoryTile extends StatelessWidget {
  /// Holds user info and last message details
  final ChatHistoryModel history;

  const ChatHistoryTile({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // Padding around the entire tile
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),

      // Leading avatar with gradient background
      leading: Container(
        width: 48,
        height: 48,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          // Gradient used for chat history avatar
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF00c56a),
              Color(0xFF00be97),
            ],
          ),
        ),
        child: Center(
          // First letter of user's name
          child: Text(
            history.user.name[0].toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),

      // Custom title layout instead of default ListTile title
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // LEFT SIDE: User name and last message
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User name
                Text(
                  history.user.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),

                // Small spacing between name and message
                const SizedBox(height: 2),

                // Last message preview
                Text(
                  history.lastMessage,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          // RIGHT SIDE: Last seen time
          Text(
            history.user.lastSeen, // example: "2m ago"
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),

      // Navigate to chat screen on tap
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatScreen(user: history.user),
          ),
        );
      },
    );
  }
}
