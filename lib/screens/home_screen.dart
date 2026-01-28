// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:mini_chat_app/widgets/chatscreen/chat_history.dart';
import 'package:provider/provider.dart';
import 'package:mini_chat_app/constants/constants.dart';
import 'package:mini_chat_app/viewmodels/home_viewmodel.dart';
import 'package:mini_chat_app/viewmodels/user_view_model.dart';
import 'package:mini_chat_app/widgets/homescreen/custom_tab_switcher.dart';
import 'package:mini_chat_app/widgets/homescreen/user_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Shows dialog to add a new user
  // Called when FloatingActionButton is pressed
  void _showAddUserDialog(BuildContext parentContext) {
    final controller = TextEditingController();

    showDialog(
      context: parentContext,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,

          // Dialog title
          title: const Text(
            'Add User',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          // Input field to enter user name
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Enter user name',
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          // Action buttons in dialog
          actions: [
            // Cancel button closes the dialog
            OutlinedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            // Add button adds user via UserViewModel
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(kPrimary),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              onPressed: () {
                final name = controller.text.trim();

                // Validate input before adding user
                if (name.isNotEmpty) {
                  parentContext.read<UserViewModel>().addUser(name);
                  Navigator.pop(dialogContext);
                }
              },
              child: const Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provides UserViewModel to manage users list
        ChangeNotifierProvider(create: (_) => UserViewModel()),
      ],

      // HomeViewModel controls current selected tab
      child: Consumer<HomeViewModel>(
        builder: (context, vm, child) {
          final isUsersTab = vm.currentTab == 0;

          return Scaffold(
            backgroundColor: kSurface,

            // Main screen body with scrollable content
            body: NestedScrollView(
              floatHeaderSlivers: true,

              // Builds the app bar and divider
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  // App bar with tab switcher
                  SliverAppBar(
                    scrolledUnderElevation: 0,
                    floating: true,
                    snap: true,
                    pinned: !isUsersTab,
                    forceElevated: innerBoxIsScrolled,
                    backgroundColor: Colors.white,
                    elevation: innerBoxIsScrolled ? 2 : 0,
                    centerTitle: true,
                    title: CustomTabSwitcher(
                      currentIndex: vm.currentTab,
                      onTap: vm.setTab,
                    ),
                  ),

                  // Divider below app bar
                  const SliverToBoxAdapter(
                    child: Divider(
                      height: 1,
                      thickness: 1.5,
                      color: Color(0xFFE0E0E0),
                    ),
                  ),
                ];
              },

              // Tab content area
              body: IndexedStack(
                index: vm.currentTab,
                children: const [
                  // Users tab content
                  UsersListView(),

                  // Chat history tab content
                  ChatHistoryView(),
                ],
              ),
            ),

            // Floating action button shown only on Users tab
            floatingActionButton: isUsersTab
                ? FloatingActionButton(
                    shape: const CircleBorder(),
                    backgroundColor: kPrimary,
                    onPressed: () {
                      _showAddUserDialog(context);
                    },
                    child: const Icon(Icons.add, color: Colors.white),
                  )
                : null,
          );
        },
      ),
    );
  }
}
