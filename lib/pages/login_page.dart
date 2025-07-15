import 'package:chatmint/auth/auth_service.dart';
import 'package:chatmint/pages/register_page.dart';
import 'package:chatmint/utils/my_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  void login(BuildContext context) async {
    // auth service
    final authService = AuthService();

    // try login
    try {
      await authService.signInWithEmailAndPassword(
        _emailController.text,
        _pwController.text,
      );
    }
    // catch any errors
    catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                height: 250,
                width: 250,
                child: Lottie.asset('assets/login.json'),
              ),
              const SizedBox(height: 30),
              // Login Text
              Text(
                "Login",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.bellota().fontFamily,
                ),
              ),
              const SizedBox(height: 30),
              // Email field
              MTF(
                hintText: "example@gmail.com",
                labelText: "Email",
                obscureText: false,
                controller: _emailController,
              ),
              const SizedBox(height: 20),
              // Password field
              MTF(
                hintText: "Enter Password",
                labelText: "Password",
                obscureText: true,
                controller: _pwController,
              ),
              const SizedBox(height: 30),
              // Login button
              ElevatedButton(
                onPressed: () {
                  login(context);
                },
                child: Icon(
                  CupertinoIcons.chevron_right_2,
                  size: 20,
                  color: Colors.white,
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 3,
                  backgroundColor: Colors.deepPurple.shade500,
                ),
              ),
              const SizedBox(height: 20),
              // Register Page button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontFamily: GoogleFonts.cardo().fontFamily,
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => RegisterPage()),
                      );
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontFamily: GoogleFonts.baumans().fontFamily,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
