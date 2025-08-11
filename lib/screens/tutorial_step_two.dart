import 'package:flutter/material.dart';

class TutorialStepTwo extends StatelessWidget {
  const TutorialStepTwo({super.key});

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
                  const Text('2/3', style: TextStyle(fontSize: 16, color: Colors.black)),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/welcome'); // Skip logic
                    },
                    child: const Text('Skip', style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ),

            // const SizedBox(height: 290),

            // Illustration image
            Image.asset(
              'assets/store_02.png', // Replace with your correct image asset
              height: 300,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 24),

            // Title
            const Center(
              child: Text(
                'Make Payment',
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
                'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. '
                    'Velit officia consequat duis enim velit mollit.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF8C8C8C),
                ),
              ),
            ),

            const Spacer(),

            // Bottom bar: Prev | Dots | Next
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Centered dots
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildDot(false),
                      _buildDot(true), // Active dot for step 2
                      _buildDot(false),
                    ],
                  ),

                  // Prev button on the left
                  Positioned(
                    left: 0,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/tutorial_step_one');
                      },
                      child: const Text(
                        'Prev',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  // Next button on the right
                  Positioned(
                    right: 0,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/tutorial_step_three');
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
            ),
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
        color: isActive ? const Color(0xFFFFA726) : Colors.grey[400],
        shape: BoxShape.circle,
      ),
    );
  }
}
