import 'package:flutter/material.dart';

class TutorialStepOne extends StatelessWidget {
  const TutorialStepOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar: step indicator + skip
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('1/3', style: TextStyle(fontSize: 16)),
                  TextButton(
                    onPressed: () {
                      // TODO: Navigate to home or skip destination
                    },
                    child: const Text('Skip'),
                  ),
                ],
              ),
            ),

            // Illustration
            Image.asset(
              'assets/store_01.png',
              height: 250,
            ),

            const SizedBox(height: 24),

            // Title
            const Text(
              'Choose Products',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFD4361),
              ),
            ),

            const SizedBox(height: 12),

            // Description
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Explore a curated collection of clothing, shoes, bags, and accessories. '
                'Find your style and shop with ease—all in one place.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),

            const Spacer(),

            // Navigation dots + Next button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Progress dots
                  Row(
                    children: [
                      _buildDot(true),
                      _buildDot(false),
                      _buildDot(false),
                    ],
                  ),

                  // Next button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFD4361),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const TutorialStepOne()),
                      );
                    },
                    child: const Text('Next'),
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
      width: isActive ? 12 : 8,
      height: isActive ? 12 : 8,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFFD4361) : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}
