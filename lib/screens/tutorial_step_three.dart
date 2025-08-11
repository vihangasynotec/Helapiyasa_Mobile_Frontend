import 'package:flutter/material.dart';

class TutorialStepThree extends StatelessWidget {
  const TutorialStepThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2), // Consistent background
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top bar: step count and skip
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('3/3', style: TextStyle(fontSize: 16, color: Colors.black)),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/welcome'); // or home
                    },
                    child: const Text('Skip', style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ),

            // const SizedBox(height: 290),

            // Image
            Image.asset(
              'assets/store_03.png',
              height: 300,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 24),

            // Title
            const Center(
              child: Text(
                'Fast Delivery',
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
                'Get your orders delivered quickly and reliably. '
                    'Track your package and enjoy hassle-free shopping.',
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

            // Dots + Finish button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Pagination dots
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildDot(false),
                      _buildDot(false),
                      _buildDot(true),
                    ],
                  ),

                  // Finish button
                  Positioned(
                    right: 0,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login_page'); // Final screen
                      },
                      child: const Text(
                        'Finish',
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
