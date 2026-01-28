import 'package:flutter/material.dart';
import 'package:mini_chat_app/models/chat_history_model.dart';
import 'package:mini_chat_app/models/user_model.dart';


class HomeViewModel extends ChangeNotifier {
  int currentTab = 0;

  final List<ChatHistoryModel> chatHistory = [];
// set tab function.
  void setTab(int index) {
    currentTab = index;
    notifyListeners();
  }

  /// Called whenever a message is sent
  void addOrUpdateChatHistory({
    required UserModel user,
    required String lastMessage,
  }) {
    // Remove existing entry if already chatted
    chatHistory.removeWhere((item) => item.user.id == user.id);

    // Add latest chat on top
    chatHistory.insert(
      0,
      ChatHistoryModel(
        user: user,
        lastMessage: lastMessage,
        updatedAt: DateTime.now(),
      ),
    );

    notifyListeners();
  }
}
