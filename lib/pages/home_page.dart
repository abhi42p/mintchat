import 'package:chatmint/auth/auth_service.dart';
import 'package:chatmint/chat/chat_service.dart';
import 'package:chatmint/pages/chat_page.dart';
import 'package:chatmint/utils/my_drawer.dart';
import 'package:chatmint/utils/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // Services to handle chat and authentication
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with custom font
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(fontFamily: GoogleFonts.badScript().fontFamily),
        ),
        centerTitle: true,
      ),

      // Custom navigation drawer
      drawer: const MyDrawer(),

      // Body: list of available users to chat with
      body: _buildUserList(),
    );
  }

  // Builds a list of users (excluding the current user)
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStreamExcludingBlocked(),
      builder: (context, snapshot) {
        // Error handling
        if (snapshot.hasError) {
          return const Center(child: Text("Something went wrong"));
        }

        // Loading indicator while waiting for data
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text("Loading..."));
        }

        // If data is available, map users to a ListView
        final users = snapshot.data;

        if (users == null || users.isEmpty) {
          return const Center(child: Text("No users found."));
        }

        return ListView(
          children: users
              .where((user) => user["email"] != _authService.getCurrentUser()?.email) // Filter out current user
              .map<Widget>(
                (userData) => _buildUserListItem(userData, context),
          )
              .toList(),
        );
      },
    );
  }

  // Builds an individual user tile
  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    return UserTile(
      text: userData["email"] ?? "No email",
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatPage(
              receiverEmail: userData["email"],
              receiverID: userData["uid"],
            ),
          ),
        );
      },
    );
  }
}
