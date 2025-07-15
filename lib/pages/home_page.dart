import 'package:chatmint/auth/auth_service.dart';
import 'package:chatmint/chat/chat_service.dart';
import 'package:chatmint/pages/chat_page.dart';
import 'package:chatmint/utils/my_drawer.dart';
import 'package:chatmint/utils/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // chat & auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home",style: TextStyle(fontFamily: GoogleFonts.badScript().fontFamily),), centerTitle: true,),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  // build a list of users except for the current logged in user

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStreamExcludingBlocked(),
      builder: (context, snapshot) {
        // error
        if (snapshot.hasError) {
          return const Text("Error");
        }

        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: const Text("Loading.."));
        }

        // list view
        return ListView(
          children:
              snapshot.data!
                  .map<Widget>(
                    (userData) => _buildUserListItem(userData, context),
                  )
                  .toList(),
        );
      },
    );
  }

  // build individual list tile for user
  Widget _buildUserListItem(
    Map<String, dynamic> userData,
    BuildContext context,
  ) {
    // display all users except current user
    if(userData["email"] != _authService.getCurrentUser()!.email){
      return UserTile(
        text: userData["email"],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChatPage(receiverEmail: userData["email"],receiverID: userData["uid"],),
            ),
          );
        },
      );
    } else{
      return Container();
    }
  }
}
