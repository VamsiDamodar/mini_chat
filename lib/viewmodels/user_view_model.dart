import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mini_chat_app/api_services/user_service.dart';
import 'package:mini_chat_app/models/user_model.dart';

/// ViewModel responsible for managing users list
/// Handles loading users and adding new users
class UserViewModel extends ChangeNotifier {

  /// Service that provides user data (API or mock)
  final UserService _service = UserService();

  /// Used to show loading indicator in UI
  bool isLoading = false;

  /// List of users displayed on Users screen
  List<UserModel> users = [];

  /// Loads users from UserService
  /// This method is usually called when screen opens
  Future<void> loadUsers() async {
    // Start loading
    isLoading = true;
    notifyListeners();

    // Fetch users from service
    users = await _service.fetchUsers();

    // Stop loading
    isLoading = false;
    notifyListeners();
  }

  /// Adds a new user using only the name entered by user
  ///
  /// Other fields like online status and last seen
  /// are generated randomly
  void addUser(String name) {
    final random = Random();

    // Randomly decide if user is online
    final isOnline = random.nextBool();

    // Create new user model
    final newUser = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      isOnline: isOnline,
      lastSeen: isOnline
          ? 'Online'
          : '${random.nextInt(59) + 1} min ago',
    );

    // Insert new user at top of the list
    users.insert(0, newUser);

    // Notify UI to refresh
    notifyListeners();
  }
}
