import 'package:flutter/material.dart';
import 'package:mini_chat_app/viewmodels/home_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:mini_chat_app/models/user_model.dart';
import 'package:mini_chat_app/viewmodels/chat_view_model.dart';
import 'package:mini_chat_app/widgets/chatscreen/chat_bubble.dart';

// Chat screen shown when a user is selected from users list or chat history
class ChatScreen extends StatefulWidget {
  final UserModel user; // Selected user for the chat

  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Controller to manage message input field
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Provides ChatViewModel only for this screen
      create: (_) => ChatViewModel(),

      // Builder is used to get a new context under the provider
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Colors.white,

          // App bar showing selected user's details
          appBar: AppBar(
            backgroundColor: Colors.white,
            scrolledUnderElevation: 0,
            elevation: 0,

            // Back button to return to previous screen
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),

            titleSpacing: 0,

            // User avatar, name, and status
            title: Row(
              children: [
                // User avatar with gradient
                Container(
                  width: 45,
                  height: 45,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF5877fb),
                        Color(0xFF9a57fa),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.user.name[0].toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // User name and online/last seen status
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.user.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      widget.user.isOnline
                          ? 'Online'
                          : widget.user.lastSeen,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Divider below app bar
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Divider(
                height: 1,
                thickness: 1.5,
                color: Color(0xFFE0E0E0),
              ),
            ),
          ),

          // Chat messages list
          body: Consumer<ChatViewModel>(
            builder: (context, vm, child) {
              return ListView.builder(
                // Number of messages in chat
                itemCount: vm.messages.length,

                // Builds each chat message bubble
                itemBuilder: (context, index) {
                  final msg = vm.messages[index];

                  return Align(
                    alignment: msg.isMe
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: ChatBubble(
                      user: widget.user,
                      text: msg.text,
                      isMe: msg.isMe,
                      time: msg.time, // Time shown below bubble
                    ),
                  );
                },
              );
            },
          ),

          // Message input area at the bottom
          bottomNavigationBar: AnimatedPadding(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,

            // Adjusts UI when keyboard opens
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),

            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                child: Row(
                  children: [
                    // Text field to type message
                    Expanded(
                      child: TextField(
                        autofocus: true,
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 14,
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF5F5F5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Send message button
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Color(0xFF165DFC),
                      child: IconButton(
                        iconSize: 20,
                        icon: const Icon(Icons.send, color: Colors.white),

                        // Sends message through ChatViewModel
                        onPressed: () async {
                          final text = _controller.text.trim();

                          // Validate input
                          if (text.isNotEmpty) {
                            await context
                                .read<ChatViewModel>()
                                .sendMessage(
                                  text: text,
                                  onHistoryUpdate: (lastMessage) {
                                    // Updates chat history for the user
                                    context
                                        .read<HomeViewModel>()
                                        .addOrUpdateChatHistory(
                                          user: widget.user,
                                          lastMessage: lastMessage,
                                        );
                                  },
                                );

                            // Clear input after sending
                            _controller.clear();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
