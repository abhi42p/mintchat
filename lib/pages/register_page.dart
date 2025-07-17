import 'package:chatmint/auth/auth_service.dart';
import 'package:chatmint/pages/home_page.dart';
import 'package:chatmint/pages/login_page.dart';
import 'package:chatmint/utils/my_text_field.dart';
import 'package:chatmint/utils/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Key for the form to validate input
  final _formKey = GlobalKey<FormState>();

  // Controllers to access the input field values
  final _emailController = TextEditingController();
  final _pwController = TextEditingController();
  final _confirmPwController = TextEditingController();

  // Method to handle registration logic
  void _register() async {
    if (_formKey.currentState!.validate()) {
      final _auth = AuthService();

      try {
        // Attempt to register the user
        await _auth.signUpWithEmailAndPassword(
          _emailController.text.trim(),
          _pwController.text.trim(),
        );

        // Navigate to home screen upon success
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomePage()),
        );
      } catch (e) {
        // Show error if registration fails
        _showErrorDialog(e.toString());
      }
    }
  }

  // Utility function to show an error dialog
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
      // Ensures content is vertically centered and scrollable
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Form(
            key: _formKey, // Attach the form key for validation
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Registration Lottie animation
                Lottie.asset('assets/register.json', height: 200, width: 200),
                const SizedBox(height: 20),

                // Page title
                Text(
                  "Register",
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
                      return "Minimum 6 characters required";
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Confirm Password input with matching validation
                MTF(
                  hintText: "Confirm Password",
                  labelText: "Confirm Password",
                  obscureText: true,
                  controller: _confirmPwController,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Please confirm your password";
                    if (value != _pwController.text)
                      return "Passwords do not match";
                    return null;
                  },
                ),
                const SizedBox(height: 30),

                // Register submit button
                ElevatedButton(
                  onPressed: _register,
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

                // Redirect to login page for existing users
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: GoogleFonts.cardo(fontSize: 16),
                    ),
                    TextButton(
                      onPressed:
                          () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginPage(),
                            ),
                          ),
                      child: Text(
                        "Login",
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
