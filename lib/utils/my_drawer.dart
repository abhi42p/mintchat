import 'package:chatmint/auth/auth_service.dart';
import 'package:chatmint/pages/settings_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  // Logout method
  void logout() {
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Top section: Logo and navigation items
          Column(
            children: [
              // Logo or icon in header
              const DrawerHeader(
                child: Center(child: Icon(Icons.message, size: 40)),
              ),

              // Home list tile
              _buildDrawerTile(
                icon: Icons.home,
                text: "H O M E",
                onTap: () => Navigator.pop(context),
              ),

              // Settings list tile
              _buildDrawerTile(
                icon: Icons.settings,
                text: "S E T T I N G S",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SettingsPage()),
                  );
                },
              ),
            ],
          ),

          // Bottom section: Logout
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25),
            child: ListTile(
              title: const Text("L O G O U T"),
              leading: const Icon(Icons.logout),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }

  // Reusable drawer tile method
  Widget _buildDrawerTile({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: ListTile(leading: Icon(icon), title: Text(text), onTap: onTap),
    );
  }
}
