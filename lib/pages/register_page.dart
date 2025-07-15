import 'package:chatmint/auth/auth_service.dart';
import 'package:chatmint/pages/home_page.dart';
import 'package:chatmint/pages/login_page.dart';
import 'package:chatmint/utils/my_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();

  void register(BuildContext context) async{
    // get auth service
    final _auth = AuthService();

    // password match --> create user
    if (_pwController.text == _confirmPwController.text) {
      try {
        await _auth.signUpWithEmailAndPassword(
          _emailController.text,
          _pwController.text,
        );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomePage()));
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text(e.toString())),
        );
      }
    }
    // password don't match --> tell user to fix
    else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text("Passwords don't match")),
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
                child: Lottie.asset('assets/register.json'),
              ),
              const SizedBox(height: 30),
              // Register text
              Text(
                "Register",
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
              const SizedBox(height: 20),
              // Confirm Password field
              MTF(
                hintText: "Enter Password",
                labelText: "Confirm Password",
                obscureText: true,
                controller: _confirmPwController,
              ),
              const SizedBox(height: 30),
              // Register Button
              ElevatedButton(
                onPressed: () {
                  register(context);
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
              // Login page button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already an account",
                    style: TextStyle(
                      fontFamily: GoogleFonts.cardo().fontFamily,
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => LoginPage()),
                      );
                    },
                    child: Text(
                      "Login",
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
