import 'package:flutter/material.dart';

class RegisterPersonalDetailsScreen extends StatefulWidget {
  const RegisterPersonalDetailsScreen({super.key});

  @override
  State<RegisterPersonalDetailsScreen> createState() => _RegisterPersonalDetailsScreenState();
}

class _RegisterPersonalDetailsScreenState extends State<RegisterPersonalDetailsScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  DateTime? selectedDate;

  String? selectedCountryCode = '+94';

  final List<Map<String, String>> countryCodes = [
    {'code': '+94', 'flag': '🇱🇰', 'country': 'Sri Lanka'},
    {'code': '+1', 'flag': '🇺🇸', 'country': 'USA'},
    {'code': '+44', 'flag': '🇬🇧', 'country': 'UK'},
    {'code': '+91', 'flag': '🇮🇳', 'country': 'India'},
    {'code': '+61', 'flag': '🇦🇺', 'country': 'Australia'},
    {'code': '+33', 'flag': '🇫🇷', 'country': 'France'},
    {'code': '+49', 'flag': '🇩🇪', 'country': 'Germany'},
    {'code': '+81', 'flag': '🇯🇵', 'country': 'Japan'},
  ];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _dateOfBirthController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFFFFFFFF)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo.png',
                  height: 50,
                  width: 80,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Join Us',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Create Free Account',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
                const SizedBox(height: 32),

                Container(
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.3),
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
                        'Personal Details',
                        style: TextStyle(
                          color: Color(0xFFFF8300),
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Please provide your personal information to create your account.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                      const SizedBox(height: 24),

                      _buildDateOfBirthField(),
                      const SizedBox(height: 16),

                      _buildPasswordField(),
                      const SizedBox(height: 16),

                      _buildConfirmPasswordField(),
                      const SizedBox(height: 16),

                      // Phone Number section with country code dropdown
                      const Text(
                        'Phone Number',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: _buildCountryCodeDropdown(),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 5,
                            child: _buildTextField(
                              controller: _phoneNumberController,
                              label: 'Phone Number',
                              hint: '77 123 4567',
                              icon: Icons.phone_outlined,
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () {
                          _handleRegistration();
                        },
                        child: const Text(
                          'Save & Continue',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 12),

                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login_page');
                        },
                        child: const Text(
                          'Back to Login',
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    IconData? icon,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: icon != null ? Icon(icon, color: Colors.orange) : null,
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: Colors.white,
          labelStyle: const TextStyle(color: Colors.black87),
          hintStyle: TextStyle(color: Colors.grey[600]),
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
    );
  }

  Widget _buildDateOfBirthField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _dateOfBirthController,
        readOnly: true,
        onTap: () async {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime(2000, 1, 1),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: Theme.of(context).colorScheme.copyWith(
                    primary: Colors.orange,
                    onPrimary: Colors.white,
                    surface: Colors.white,
                    onSurface: Colors.black,
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.orange,
                    ),
                  ),
                ),
                child: child!,
              );
            },
          );
          if (picked != null) {
            setState(() {
              selectedDate = picked;
              _dateOfBirthController.text = '${picked.day}/${picked.month}/${picked.year}';
            });
          }
        },
        decoration: InputDecoration(
          labelText: 'Date of Birth',
          hintText: 'Select your date of birth',
          prefixIcon: const Icon(Icons.calendar_today, color: Colors.orange),
          filled: true,
          fillColor: Colors.white,
          labelStyle: const TextStyle(color: Colors.black87),
          hintStyle: TextStyle(color: Colors.grey[600]),
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
    );
  }

  Widget _buildPasswordField() {
    return _buildTextField(
      controller: _passwordController,
      label: 'Password',
      hint: 'Enter your password',
      icon: Icons.lock_outline,
      obscureText: _obscurePassword,
      suffixIcon: IconButton(
        icon: Icon(
          _obscurePassword ? Icons.visibility_off : Icons.visibility,
          color: Colors.orange,
        ),
        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
      ),
    );
  }

  Widget _buildConfirmPasswordField() {
    return _buildTextField(
      controller: _confirmPasswordController,
      label: 'Confirm Password',
      hint: 'Confirm your password',
      icon: Icons.lock_outline,
      obscureText: _obscureConfirmPassword,
      suffixIcon: IconButton(
        icon: Icon(
          _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
          color: Colors.orange,
        ),
        onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
      ),
    );
  }

  Widget _buildCountryCodeDropdown() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        value: selectedCountryCode,
        onChanged: (String? newValue) {
          setState(() {
            selectedCountryCode = newValue;
          });
        },
        decoration: InputDecoration(
          labelText: 'Code',
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
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
        items: countryCodes
            .map<DropdownMenuItem<String>>((Map<String, String> value) {
          return DropdownMenuItem<String>(
            value: value['code'],
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value['flag']!,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    value['code']!,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        isExpanded: false,
        icon: const Icon(Icons.arrow_drop_down, color: Colors.orange, size: 20),
        dropdownColor: Colors.white,
      ),
    );
  }

  void _handleRegistration() {
    // Validate all fields with null checks
    if (_firstNameController.text.trim().isEmpty) {
      return;
    }
    if (_lastNameController.text.trim().isEmpty) {
      return;
    }
    if (_emailController.text.trim().isEmpty) {
      return;
    }
    if (_usernameController.text.trim().isEmpty) {
      return;
    }
    if (_dateOfBirthController.text.trim().isEmpty || selectedDate == null) {
      return;
    }
    if (_passwordController.text.trim().isEmpty) {
      return;
    }
    if (_confirmPasswordController.text.trim().isEmpty) {
      return;
    }
    if (_passwordController.text != _confirmPasswordController.text) {
      return;
    }
    if (_phoneNumberController.text.trim().isEmpty) {
      return;
    }
    if (selectedCountryCode == null || selectedCountryCode!.isEmpty) {
      return;
    }

    // Navigate to next screen or complete registration silently
    Navigator.pushReplacementNamed(context, '/login_page');
  }
}
