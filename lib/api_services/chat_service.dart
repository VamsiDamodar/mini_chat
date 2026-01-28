import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mini_chat_app/models/message_model.dart';

// Service class responsible for chat-related API calls
class ChatService {

  // 🔹 Fetch receiver messages from backend (simulated API)
  Future<List<MessageModel>> fetchReceiverMessages() async {
    // API call to fetch comments (used as chat messages)
    final response = await http.get(
      Uri.parse('https://dummyjson.com/comments?limit=1'),
    );

    // If API call is successful
    if (response.statusCode == 200) {
      // Decode JSON response
      final data = json.decode(response.body);

      // Extract comments array from response
      final List comments = data['comments'];

      // Generate current time for received messages
      final receivedTime = _getCurrentTime();

      // Convert API response into MessageModel list
      return comments
          .map<MessageModel>(
            (e) => MessageModel.fromApi(e, receivedTime),
          )
          .toList();
    } else {
      // Throw error if API call fails
      throw Exception('Failed to load messages');
    }
  }

  // 🔹 Utility method to get current time in 12-hour format (e.g., 10:30 AM)
  String _getCurrentTime() {
    final now = DateTime.now(); // Current date & time

    // Convert 24-hour format to 12-hour format
    final hour = now.hour > 12 ? now.hour - 12 : now.hour;

    // Ensure minute always has 2 digits
    final minute = now.minute.toString().padLeft(2, '0');

    // Decide AM / PM
    final period = now.hour >= 12 ? 'PM' : 'AM';

    // Return formatted time string
    return '$hour:$minute $period';
  }
}
