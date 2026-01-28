import 'package:flutter/material.dart';
import 'package:mini_chat_app/navigations/bottom_navbar.dart';
import 'package:mini_chat_app/viewmodels/home_viewmodel.dart';
import 'package:provider/provider.dart';

/// App entry point
void main() {
  runApp(
    // MultiProvider allows providing multiple global ViewModels
    MultiProvider(
      providers: [
        // Global HomeViewModel
        // Used for tab switching and chat history management
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

/// Root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // App title
      title: 'Mini Chat',

      // Removes debug banner
      debugShowCheckedModeBanner: false,

      // App-wide theme configuration
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0066FF),
        ),
      ),

      // Initial screen of the app
      // Bottom navigation controls Home, Offers, and Settings screens
      home: const CustomBottomNavbar(),
    );
  }
}
