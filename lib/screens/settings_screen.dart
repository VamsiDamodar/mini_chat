import 'package:flutter/material.dart';

// Screen shown when the user selects the "Settings" tab
class Settingscreen extends StatelessWidget {
  const Settingscreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Center widget keeps the content aligned in the middle of the screen
    return Center(
      // Displays the Settings screen title
      child: Text(
        'Settings Screen',
        style: const TextStyle(
          fontSize: 12,              // Font size of the text
          fontWeight: FontWeight.w400, // Normal font weight
          color: Colors.black,       // Text color
        ),
      ),
    );
  }
}
