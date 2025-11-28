import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/inputfield.dart'; // Ensure correct path
import '../services/firebase_service.dart';
import 'package:task_login/screens/HomeScreen.dart';


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
  bool isLoading = false;

  Future<void> handleSignup() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please correct the errors in the form.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true; // start loading
    });

    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final name = nameController.text.trim();

    try {
      final user = await FirebaseService.instance.signUp(email, password);

      if (user != null) {
        await FirebaseService.instance.saveUserData(user.uid, {
          'uid': user.uid,
          'name': name,
          'email': email,
          'createdAt': DateTime.now(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Account created successfully!'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Signup failed';
      if (e.code == 'email-already-in-use') errorMessage = 'This email is already registered';
      else if (e.code == 'weak-password') errorMessage = 'Your password is too weak';
      else if (e.code == 'invalid-email') errorMessage = 'Invalid email format';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something went wrong: $e'), backgroundColor: Colors.red),
      );
    } finally {
      setState(() {
        isLoading = false; // stop loading
      });
    }
  }



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
                        onPressed: isLoading ? null : handleSignup, // disable while loading
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
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                            : const Text(
                          'Signup',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Montserrat',
                          ),
                        ),
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