import 'package:flutter/material.dart';

class RegisterPersonalInfoScreen extends StatefulWidget {
  const RegisterPersonalInfoScreen({super.key});

  @override
  State<RegisterPersonalInfoScreen> createState() => _RegisterPersonalInfoScreenState();
}

class _RegisterPersonalInfoScreenState extends State<RegisterPersonalInfoScreen> {
  DateTime? selectedBirthday;
  bool _obscurePassword = true;
  String? selectedCountryCode = '+94';
  String? selectedSecurityQuestion;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _securityAnswerController = TextEditingController();

  final List<String> countryCodes = ['+94', '+91', '+1', '+44'];
  final List<String> securityQuestions = [
    'Your first pet\'s name?',
    'Your mother\'s maiden name?',
    'Your favorite teacher?',
  ];

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
              children: [
                const SizedBox(height: 50),
                Container(
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F6F6),
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
                        'Personal Info',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Complete your registration',
                        style: TextStyle(fontSize: 18, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),

                      _buildSectionTitle('Birthday'),
                      _buildBirthdayPicker(),
                      const SizedBox(height: 16),

                      _buildSectionTitle('Password'),
                      _buildPasswordField(),
                      const SizedBox(height: 16),

                      _buildSectionTitle('Phone Number'),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: _buildDropdown(countryCodes, selectedCountryCode,
                                    (val) => setState(() => selectedCountryCode = val), 'Code'),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 5,
                            child: _buildTextField(
                              controller: _phoneController,
                              hint: 'Phone Number',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      _buildSectionTitle('Security Question'),
                      _buildDropdown(securityQuestions, selectedSecurityQuestion,
                              (val) => setState(() => selectedSecurityQuestion = val), 'Select question'),
                      const SizedBox(height: 20),
                      _buildTextField(
                        controller: _securityAnswerController,
                        hint: 'Your Answer',
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
                          // TODO: Handle account creation
                        },
                        child: const Text(
                          'Create Account',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
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

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),

    );
  }

  Widget _buildBirthdayPicker() {
    return GestureDetector(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime(2000, 1, 1),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (picked != null) {
          setState(() {
            selectedBirthday = picked;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.orange, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedBirthday != null
                  ? '${selectedBirthday!.month}/${selectedBirthday!.day}/${selectedBirthday!.year}'
                  : 'Select Birthday',
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const Icon(Icons.calendar_today, color: Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(List<String> items, String? selected, ValueChanged<String?> onChanged, String hint) {
    return DropdownButtonFormField<String>(
      value: selected,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.orange, width: 1.5),
        ),
      ),
      items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildPasswordField() {
    return _buildTextField(
      controller: _passwordController,
      hint: 'Enter Password',
      obscureText: _obscurePassword,
      suffixIcon: IconButton(
        icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          suffixIcon: suffixIcon,
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
}