import 'package:flutter/material.dart';

class TutorialStepOne extends StatelessWidget {
  const TutorialStepOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2), // Light grey background
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top bar with step and skip
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/welcome');
                    },
                    child: const Text('1/3', style: TextStyle(fontSize: 16, color: Colors.black)),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/welcome');
                    },
                    child: const Text('Skip', style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 290),

            // Illustration image
            Image.asset(
              'assets/store_01.png',
              height: 300,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 24),

            // Title
            const Center(
              child: Text(
                'Choose Products',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Description
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                'Explore a curated collection of clothing, shoes, bags, and accessories. '
                    'Find your style and shop with ease—all in one place.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600, // Semi-bold
                  color: Color(0xFF8C8C8C), // Light grey text
                ),
              ),
            ),

            const Spacer(),

            // Pagination and Next
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Centered dots
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildDot(true),
                      _buildDot(false),
                      _buildDot(false),
                    ],
                  ),

                  // Next button positioned on the right
                  Positioned(
                    right: 0,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/tutorial_step_two');
                      },
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDot(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 10 : 8,
      height: isActive ? 10 : 8,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFFFA726) : Colors.grey[400], // Orange if active
        shape: BoxShape.circle,
      ),
    );
  }
}