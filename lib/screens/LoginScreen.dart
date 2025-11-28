import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/inputfield.dart'; // Ensure correct path
import '../services/firebase_service.dart';
import 'HomeScreen.dart'; // Import HomeScreen

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false; // Add this to manage spinner
  Future<void> handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    try {
      final user = await FirebaseService.instance.login(email, password);

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login Successful!'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Login failed';
      if (e.code == 'user-not-found') errorMessage = 'User not found';
      if (e.code == 'wrong-password') errorMessage = 'Incorrect password';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e'), backgroundColor: Colors.red),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top Image
              Image.asset(
                'lib/assets/login.png', // Replace with your actual image path
                height: 270,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 5),

              // Login Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text(
                      'Welcome Back!',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontFamily: 'Montserrat',
                      ),
                    ),

                    const SizedBox(height: 4),

                    const Text(
                      'Log in to continue and explore our app',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),

                    InputField(
                      controller: emailController,
                      hint: 'Email', // This is the floating label
                      placeholder: 'Enter your email', // This is the initial placeholder
                      keyboardType: TextInputType.emailAddress,
                      icon: Icons.email,
                      iconColor: Colors.black,
                      focusedBorderColor: Colors.red, // Focused border color
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email';
                        }

                        final emailRegex = RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        );

                        if (!emailRegex.hasMatch(value.trim())) {
                          return 'Enter a valid email (user@example.com)';
                        }

                        return null;
                      },
                    ),

                    // Password Field with Eye Icon Toggle
                    InputField(
                      controller: passwordController,
                      hint: 'Password', // This is the floating label
                      placeholder: 'Enter your password', // This is the initial placeholder
                      obscureText: true,
                      isPassword: true,
                      icon: Icons.lock,
                      iconColor: Colors.black,
                      focusedBorderColor: Colors.red, // Focused border color
                        validator: (value) {
                          if (value == null || value.isEmpty) return 'Enter your password';
                          if (value.length < 8) return 'Enter Min 8 characters';
                          if (!value.contains(RegExp(r'[A-Z]'))) return 'Include uppercase character';
                          if (!value.contains(RegExp(r'[a-z]'))) return 'Include lowercase character';
                          if (!value.contains(RegExp(r'[0-9]'))) return 'Include number';
                          if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return 'Include special character';
                          return null;
                        },

                        ),

                    const SizedBox(height: 20),

                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                        ),
                        child: isLoading
                            ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                            : const Text(
                          'Login',
                          style: TextStyle(fontSize: 18, fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Navigate to Signup
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account? ',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Signup',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}