import 'package:chatmint/pages/blocked_users_page.dart';
import 'package:chatmint/utils/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings"), centerTitle: true),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(12),
            ),
            margin: EdgeInsets.all(25),
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Dark mode"),
                CupertinoSwitch(
                  value:
                      Provider.of<ThemeProvider>(
                        context,
                        listen: false,
                      ).isDarkMode,
                  onChanged: (value) {
                    Provider.of<ThemeProvider>(
                      context,
                      listen: false,
                    ).toggleTheme();
                  },
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => BlockedUsersPage()),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              margin: EdgeInsets.symmetric(horizontal: 25),
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Blocked Users"),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => BlockedUsersPage()),
                      );
                    },
                    icon: Icon(Icons.arrow_forward_ios_rounded),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
