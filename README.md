# Mini Chat App (Flutter)

A simple and clean Flutter chat application built using **Provider** and **MVVM architecture**.  
This app demonstrates real-time chat UI, user management, chat history, API-based auto replies, and offline fallback handling.

---

## Features Implemented

### User Management
- Display list of users
- Add new user using Floating Action Button
- User status (Online / Last seen) auto-generated
- Random online/offline status for new users

### Chat Screen
- One-to-one chat UI
- Sender and receiver message bubbles
- Gradient avatars for users
- Message timestamp shown below each message
- Auto-scroll friendly layout
- Keyboard-safe input bar

### Chat History
- Separate Chat History tab
- Shows:
  - User name
  - Last message
- Last seen time (right aligned, vertically centered)
- Updates automatically when a new message is sent

### Auto Reply (API + Offline Fallback)
- Receiver messages fetched from API (`dummyjson.com`)
- Auto-generated timestamp for API messages
- Graceful error handling
- Offline-safe logic (no app crash if API fails)

### Navigation
- Custom Bottom Navigation Bar using PNG icons
- Tabs:
  - Home (Users + Chat History)
  - Offers
  - Settings
- State preserved using `IndexedStack`

---

## Architecture

This project follows the **MVVM (Model–View–ViewModel)** pattern.

```text
lib/
│
├── api_services/
│   ├── chat_service.dart
│   └── user_service.dart
│
├── models/
│   ├── user_model.dart
│   ├── message_model.dart
│   └── chat_history_model.dart
│
├── viewmodels/
│   ├── home_viewmodel.dart
│   ├── user_view_model.dart
│   └── chat_view_model.dart
│
├── widgets/
│   ├── chatscreen/
│   │   ├── chat_bubble.dart
│   │   └── chat_history.dart
│   ├── homescreen/
│   │   ├── custom_tab_switcher.dart
│   │   └── user_list.dart
│   └── chat_history_tile.dart
│
├── screens/
│   ├── home_screen.dart
│   ├── chat_screen.dart
│   ├── offers_screen.dart
│   └── settings_screen.dart
│
├── navigations/
│   └── bottom_navbar.dart
│
├── constants/
│   └── constants.dart
│
└── main.dart
