import 'package:flutter/material.dart';
import 'package:mini_chat_app/screens/home_screen.dart';
import 'package:mini_chat_app/screens/offers_screen.dart';
import 'package:mini_chat_app/screens/settings_screen.dart';

/// Custom bottom navigation bar widget
/// Handles screen switching between Home, Offers, and Settings
class CustomBottomNavbar extends StatefulWidget {
  const CustomBottomNavbar({super.key});

  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {

  /// Holds the currently selected tab index
  /// 0 = Home, 1 = Offers, 2 = Settings
  int _selectedIndex = 0;

  /// Screens list
  /// IndexedStack is used so that each screen
  /// preserves its state when switching tabs
  final List<Widget> _screens = const [
    HomeScreen(),
    Offerscreen(),
    Settingscreen(),
  ];

  /// Bottom navigation items using PNG icons
  /// Each item contains an asset path and label
  final List<NavItem> _navItems = const [
    NavItem(
      assetPath: 'assets/messenger.png',
      label: 'Home',
    ),
    NavItem(
      assetPath: 'assets/tag.png',
      label: 'Offers',
    ),
    NavItem(
      assetPath: 'assets/setting.png',
      label: 'Settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      /// Displays the selected screen
      /// IndexedStack keeps all screens alive
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),

      /// Custom bottom navigation bar
      bottomNavigationBar: _buildCustomBar(),
    );
  }

  /// Builds the custom bottom navigation bar UI
  Widget _buildCustomBar() {
    return Container(
      height: 80,

      /// White background with a top border
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFE0E0E0),
            width: 1.5,
          ),
        ),
      ),

      /// SafeArea prevents overlap with system UI
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          /// Generate navigation items dynamically
          children: List.generate(_navItems.length, (index) {
            final item = _navItems[index];
            final isSelected = _selectedIndex == index;

            return GestureDetector(

              /// Update selected index on tap
              onTap: () => setState(() => _selectedIndex = index),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  /// PNG icon with color change based on selection
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      isSelected
                          ? const Color.fromRGBO(24, 94, 252, 1)
                          : Colors.black54,
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(
                      item.assetPath,
                      height: 24,
                      width: 24,
                    ),
                  ),

                  const SizedBox(height: 4),

                  /// Navigation label
                  Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected
                          ? const Color.fromRGBO(24, 94, 252, 1)
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

/// Model class for a bottom navigation item
/// Uses PNG asset icons instead of Material icons
class NavItem {

  /// Path to the PNG icon asset
  final String assetPath;

  /// Text label shown below the icon
  final String label;

  const NavItem({
    required this.assetPath,
    required this.label,
  });
}
