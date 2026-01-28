import 'package:flutter/material.dart';
import 'package:mini_chat_app/constants/constants.dart';

/// Custom tab switcher used in HomeScreen AppBar
/// Allows switching between "Users" and "Chat History"
class CustomTabSwitcher extends StatelessWidget {
  // Currently selected tab index
  final int currentIndex;

  // Callback triggered when user taps a tab
  final ValueChanged<int> onTap;

  const CustomTabSwitcher({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Overall height of the tab switcher
      height: 44,

      // Inner spacing
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),

      // Background container styling
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(kTabRadius),
      ),

      // Row holding the two tab buttons
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Users tab
          _buildTabButton(0, 'Users'),

          // Chat History tab
          _buildTabButton(1, 'Chat History'),
        ],
      ),
    );
  }

  /// Builds an individual tab button
  /// Handles selection animation and styling
  Widget _buildTabButton(int index, String label) {
    // Check if this tab is currently selected
    final isSelected = currentIndex == index;

    return GestureDetector(
      // Notify parent when tab is tapped
      onTap: () => onTap(index),

      // Animated container for smooth selection transition
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 280),

        // Padding inside tab button
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),

        // Styling changes based on selected state
        decoration: BoxDecoration(
          // White background for selected tab
          color: isSelected ? Colors.white : Colors.transparent,

          // Rounded corners
          borderRadius: BorderRadius.circular(kTabRadius - 4),

          // Subtle shadow only for selected tab
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ]
              : null,
        ),

        // Tab label text
        child: Text(
          label,
          style: TextStyle(
            // Slightly bolder text for selected tab
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: Colors.black,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
