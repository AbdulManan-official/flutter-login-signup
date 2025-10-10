import 'package:flutter/material.dart';
import '../widgets/inputfield.dart'; // Ensure correct path

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
                'lib/assets/signup.png', // replace with your signup image path
                height: 180,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 5),

              // Signup Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text(
                      'Join Us!',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                      ),
                    ),

                    const Text(
                      'Create your account and start exploring',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,  fontFamily: 'Montserrat',

                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 20),
                    InputField(
                      controller: nameController,
                      hint: 'Name',
                      placeholder: 'Enter your name',
                      icon: Icons.person,
                      iconColor: Colors.black,
                      focusedBorderColor: Colors.red, // Consistent focused border color
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    InputField(
                      controller: emailController,
                      hint: 'Email',
                      placeholder: 'Enter your email',
                      keyboardType: TextInputType.emailAddress,
                      icon: Icons.email,
                      iconColor: Colors.black,
                      focusedBorderColor: Colors.red,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        // **UPDATED Regex for a more robust valid email format**
                        // I've reverted this regex to your previous robust one,
                        // as the new one `[a-zA-Z]{2,}` is less flexible for TLDs
                        final emailRegex = RegExp(
                            r'^[\w.-]+@([\w-]+\.)+[\w-]{2,4}$'
                        );
                        if (!emailRegex.hasMatch(value.trim())) {
                          return 'Enter a valid email (user@example.com)';
                        }
                        return null;
                      },
                    ),
                    InputField(
                      controller: passwordController,
                      hint: 'Password',
                      placeholder: 'Enter your password',
                      obscureText: true,
                      isPassword: true,
                      icon: Icons.lock,
                      iconColor: Colors.black,
                      focusedBorderColor: Colors.red,
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
                    InputField(
                      controller: confirmPasswordController,
                      hint: 'Confirm Password',
                      placeholder: 'Confirm your password',
                      obscureText: true,
                      isPassword: true,
                      icon: Icons.lock_outline,
                      iconColor: Colors.black,
                      focusedBorderColor: Colors.red,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar( // Removed const
                                content: const Text('Signup Successful!'),
                                backgroundColor: Colors.green,
                                duration: const Duration(seconds: 2), // Set duration
                              ),
                            );
                            // Navigate to login or home after successful signup
                            // Navigator.pushReplacementNamed(context, '/login');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar( // Removed const
                                content: const Text('Please correct the errors in the form.'),
                                backgroundColor: Colors.red,
                                duration: const Duration(seconds: 3), // Set duration
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red, // Changed to red
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                        ),
                        child: const Text('Signup', style: TextStyle(fontSize: 18,
                          fontFamily: 'Montserrat',
                        )),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account? ',
                          style: TextStyle(color: Colors.black), // Plain black text
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.red, // Changed to red
                              fontWeight: FontWeight.bold,  fontFamily: 'Montserrat',

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