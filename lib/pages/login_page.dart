import 'package:chatmint/auth/auth_service.dart';
import 'package:chatmint/pages/home_page.dart';
import 'package:chatmint/pages/register_page.dart';
import 'package:chatmint/utils/my_text_field.dart';
import 'package:chatmint/utils/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Form key to manage validation state
  final _formKey = GlobalKey<FormState>();

  // Controllers to retrieve text input
  final _emailController = TextEditingController();
  final _pwController = TextEditingController();

  // Method to handle user login
  void _login() async {
    if (_formKey.currentState!.validate()) {
      // Create an instance of your AuthService
      final _auth = AuthService();

      try {
        // Attempt login with trimmed email & password
        await _auth.signInWithEmailAndPassword(
          _emailController.text.trim(),
          _pwController.text.trim(),
        );

        // If successful, navigate to home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomePage()),
        );
      } catch (e) {
        // Show error dialog if login fails
        _showErrorDialog(e.toString());
      }
    }
  }

  // Reusable error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(title: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      // Center content vertically
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Form(
            key: _formKey, // Attach the form key
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animation/logo
                Lottie.asset('assets/login.json', height: 200, width: 200),
                const SizedBox(height: 20),

                // Login title
                Text(
                  "Login",
                  style: GoogleFonts.bellota(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),

                // Email input field with validation
                MTF(
                  hintText: "example@gmail.com",
                  labelText: "Email",
                  obscureText: false,
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Email can't be empty";
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value))
                      return "Enter a valid email";
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Password input field with validation
                MTF(
                  hintText: "Enter Password",
                  labelText: "Password",
                  obscureText: true,
                  controller: _pwController,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Password can't be empty";
                    if (value.length < 6)
                      return "Password must be at least 6 characters";
                    return null;
                  },
                ),
                const SizedBox(height: 30),

                // Login button
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    backgroundColor: Colors.deepPurple.shade500,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12,
                    ),
                  ),
                  child: const Icon(
                    CupertinoIcons.chevron_right_2,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(height: 20),

                // Register redirect link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: GoogleFonts.cardo(fontSize: 16),
                    ),
                    TextButton(
                      onPressed:
                          () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const RegisterPage(),
                            ),
                          ),
                      child: Text(
                        "Register",
                        style: GoogleFonts.baumans(
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
      ),
    );
  }
}
