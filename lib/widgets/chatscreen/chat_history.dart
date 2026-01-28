import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../viewmodels/home_viewmodel.dart';
import 'chat_history_tile.dart';

/// Displays the list of chat history items
/// This screen is shown under the "Chats" tab
class ChatHistoryView extends StatelessWidget {
  const ChatHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    // Listen to HomeViewModel for chat history updates
    return Consumer<HomeViewModel>(
      builder: (context, vm, child) {
        // If there are no chats, show empty state message
        if (vm.chatHistory.isEmpty) {
          return const Center(
            child: Text('No chats yet'),
          );
        }

        // Wrapper container to enforce white background
        return Container(
          color: Colors.white, // background color for chat list
          child: ListView.builder(
            // Top spacing below AppBar
            padding: const EdgeInsets.only(top: 8),

            // Total number of chat history items
            itemCount: vm.chatHistory.length,

            // Build each chat history row
            itemBuilder: (context, index) {
              return ChatHistoryTile(
                // Pass individual chat history data to tile
                history: vm.chatHistory[index],
              );
            },
          ),
        );
      },
    );
  }
}
