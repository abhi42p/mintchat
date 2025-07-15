import 'package:chatmint/chat/chat_service.dart';
import 'package:chatmint/utils/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  final String messageId;
  final String userId;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
    required this.messageId,
    required this.userId,
  });

  // show options
  void _showOptions(BuildContext context, String messageId, String userId) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              // report message button
              ListTile(
                leading: const Icon(Icons.flag),
                title: const Text('Report'),
                onTap: () {
                  Navigator.pop(context);
                  _reportMessage(context, messageId, userId);
                },
              ),

              // block user button
              ListTile(
                leading: const Icon(Icons.block),
                title: const Text('Block'),
                onTap: () {
                  Navigator.pop(context);
                  _blockUser(context, userId);
                },
              ),

              // cancel button
              ListTile(
                leading: const Icon(Icons.cancel),
                title: const Text('Cancel'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // report message
  void _reportMessage(BuildContext context, String messageId, String userId) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Report Message'),
            content: Text('Are you sure you want to report this message?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  ChatService().reportUser(messageId, userId);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Message Reported")),
                  );
                },
                child: Text('Report'),
              ),
            ],
          ),
    );
  }

  //block user
  void _blockUser(BuildContext context, String userId) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
        title: Text('Block User'),
        content: Text('Are you sure you want to block this user?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          // block button
          TextButton(
            onPressed: () {
              ChatService().blockUser(userId);
              Navigator.pop(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("User Blocked")),
              );
            },
            child: Text('Block'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // light vs dark mode for correct bubble colors
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return InkWell(
      onLongPress: () {
        if (!isCurrentUser) {
          _showOptions(context, messageId, userId);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color:
              isCurrentUser
                  ? (isDarkMode ? Colors.green.shade600 : Colors.green.shade600)
                  : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(vertical: 2.5, horizontal: 25),
        child: Text(
          message,
          style: TextStyle(
            color:
                isCurrentUser
                    ? Colors.white
                    : (isDarkMode ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}
