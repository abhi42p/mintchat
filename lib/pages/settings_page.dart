import 'package:chatmint/pages/blocked_users_page.dart';
import 'package:chatmint/utils/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Settings"), centerTitle: true),
      body: Column(
        children: [
          // Toggle for Dark Mode
          _buildSettingTile(
            context: context,
            title: "Dark mode",
            trailing: CupertinoSwitch(
              value: themeProvider.isDarkMode,
              onChanged: (_) => themeProvider.toggleTheme(),
            ),
          ),

          const SizedBox(height: 10),

          // Blocked Users Navigation Tile
          _buildSettingTile(
            context: context,
            title: "Blocked Users",
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => BlockedUsersPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  /// Reusable setting tile for cleaner layout
  Widget _buildSettingTile({
    required BuildContext context,
    required String title,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 16)),
            trailing,
          ],
        ),
      ),
    );
  }
}
