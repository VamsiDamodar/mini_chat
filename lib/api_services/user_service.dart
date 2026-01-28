import 'package:mini_chat_app/models/user_model.dart';

// Service class responsible for fetching users
class UserService {

  // 🔹 Simulated API call to fetch users list
  // This mimics a real backend request using a delay
  Future<List<UserModel>> fetchUsers() async {
    
    // Simulate network delay (like an API call)
    await Future.delayed(const Duration(seconds: 1));

    // Return a list of users (mock data)
    return [
      UserModel(
        id: "1",                 // Unique user ID
        name: "Alice Johnson",   // User name
        isOnline: true,          // Online status
        lastSeen: "Online",      // Last seen text
      ),
    ];
  }
}
