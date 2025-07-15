import 'package:chatmint/auth/auth_service.dart';
import 'package:chatmint/chat/chat_service.dart';
import 'package:chatmint/utils/user_tile.dart';
import 'package:flutter/material.dart';

class BlockedUsersPage extends StatelessWidget {
  BlockedUsersPage({super.key});

  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();

  // show confirm unblock box
  void _showUnblockBox(BuildContext context, String userId) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Unblock User"),
            content: Text("Are you sure you want to unblock this user?"),
            actions: [
              // cancel button
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
              ),

              // unblock button
              TextButton(
                onPressed: () {
                  chatService.unblockUser(userId);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("User unblocked")),
                  );
                },
                child: Text("Unblock"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String userId = authService.getCurrentUser()!.uid;

    return Scaffold(
      appBar: AppBar(title: Text("Blocked User"), centerTitle: true),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: chatService.getBlockedUsersStream(userId),
        builder: (context, snapshot) {
          // errors
          if (snapshot.hasError) {
            return const Center(child: Text("Error loading..."));
          }

          // loading..
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final blockedUsers = snapshot.data ?? [];

          // no users
          if (blockedUsers.isEmpty) {
            return const Center(child: Text("No Blocked User"));
          }

          // load complete
          return ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              final user = blockedUsers[index];
              return UserTile(
                text: user["email"],
                onTap: () => _showUnblockBox(context, user['uid']),
              );
            },
          );
        },
      ),
    );
  }
}
