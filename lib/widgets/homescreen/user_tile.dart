import 'package:flutter/material.dart';
import 'package:mini_chat_app/models/user_model.dart';
import 'package:mini_chat_app/screens/chat_screen.dart';

/// Single user row shown in the Users list
/// Displays avatar, name, last seen status, and online indicator
class UserTile extends StatelessWidget {
  final UserModel user;

  const UserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // Navigate to ChatScreen when user taps the tile
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatScreen(user: user),
          ),
        );
      },

      // Avatar + online indicator
      leading: Stack(
        children: [
          // User avatar with gradient background
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF5877fb),
                  Color(0xFF9a57fa),
                ],
                // Second color appears only near the end
                stops: [
                  0.0,
                  0.990,
                ],
              ),
            ),
            child: Center(
              child: Text(
                // First letter of user name
                user.name[0].toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          // Online status dot (shown only if user is online)
          if (user.isOnline)
            Positioned(
              bottom: 2,
              right: 2,
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
              ),
            ),
        ],
      ),

      // User name
      title: Text(user.name),

      // Last seen or online status
      subtitle: Text(
        user.lastSeen,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.black54,
        ),
      ),
    );
  }
}
