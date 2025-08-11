import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _savePassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white, // WHITE
              Color(0xFFFFFFFF),      // To fade into white
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  'assets/logo.png', // Replace with your logo asset path
                  height: 50,
                  width: 80,
                ),
                const SizedBox(height: 24),

                const Text(
                  'Hello',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Welcome Back !',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 32),

                // Login card
                Container(
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Login Account',
                        style: TextStyle(
                          color: Color(0xFFFF8300),
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Sign in to continue and explore all your personalized features.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                      const SizedBox(height: 24),

                      // Email Field
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            hintText: 'Your Email Address',
                            prefixIcon: const Icon(Icons.email_outlined),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.orange, width: 1.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.orange, width: 1.5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.orange, width: 2),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Password Field
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter Password',
                            prefixIcon: const Icon(Icons.lock_outline),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.orange, width: 1.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.orange, width: 1.5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.orange, width: 2),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Save Password + Forgot
                      Row(
                        children: [
                          Checkbox(
                            value: _savePassword,
                            activeColor: Colors.orange,
                            onChanged: (value) {
                              setState(() {
                                _savePassword = value ?? false;
                              });
                            },
                          ),
                          const Text('Save Password'),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              // TODO: Forgot Password
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.orange),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Login Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 5),
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/dashboard_page'); // Navigate to Dashboard Page
                        },
                        child: const Text(
                          'Login Account',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Create New Account
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/register_page'); // Navigate to Register Page
                        },
                        child: const Text(
                          'Create New Account',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}