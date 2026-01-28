/// Model class representing a user in the app
class UserModel {

  /// Unique identifier for the user
  /// Example: "1", "abc123"
  final String id;

  /// Display name of the user
  /// Example: "Alice Johnson"
  final String name;

  /// Indicates whether the user is currently online
  /// true  → Online
  /// false → Offline
  final bool isOnline;

  /// Last seen status of the user
  /// Example: "Online", "10 mins ago", "Yesterday"
  final String lastSeen;

  /// Constructor to create a UserModel instance
  UserModel({
    required this.id,
    required this.name,
    required this.isOnline,
    required this.lastSeen,
  });
}
