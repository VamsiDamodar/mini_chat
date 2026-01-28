import 'package:flutter/material.dart';

// Screen shown when the user selects the "Offers" tab
class Offerscreen extends StatelessWidget {
  const Offerscreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Center widget to align content in the middle of the screen
    return Center(
      // Simple text indicating the Offers screen
      child: Text(
        'Offers Screen',
        style: const TextStyle(
          fontSize: 12,           // Text size
          fontWeight: FontWeight.w400, // Normal font weight
          color: Colors.black,    // Text color
        ),
      ),
    );
  }
}
