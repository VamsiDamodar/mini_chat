import 'package:flutter/material.dart';
import 'package:mini_chat_app/viewmodels/user_view_model.dart';
import 'package:provider/provider.dart';

import 'user_tile.dart';

/// Displays the list of users in the "Users" tab
/// Uses UserViewModel to fetch and manage user data
class UsersListView extends StatefulWidget {
  const UsersListView({super.key});

  @override
  State<UsersListView> createState() => _UsersListViewState();
}

class _UsersListViewState extends State<UsersListView> {
  @override
  void initState() {
    super.initState();

    // Load users AFTER the first frame is rendered
    // This avoids calling Provider too early in widget lifecycle
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserViewModel>().loadUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, vm, child) {
        return Container(
          // Background color for the users list
          color: Colors.white,

          // Show loader while fetching users
          child: vm.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )

              // Show users list once data is loaded
              : ListView.builder(
                  padding: const EdgeInsets.only(top: 8),

                  // Total number of users
                  itemCount: vm.users.length,

                  // Build each user row
                  itemBuilder: (context, index) {
                    return UserTile(
                      user: vm.users[index],
                    );
                  },
                ),
        );
      },
    );
  }
}
