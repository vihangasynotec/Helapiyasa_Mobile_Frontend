import 'package:flutter/material.dart';
import 'main_dashboard_page.dart'; // Make sure this file exists

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  // Define pages for each tab (only Home is wired for now)
  final List<Widget> _pages = const [
    MainDashboard_Page(), // Home
    Center(child: Text('Shop Page')), // Placeholder
    Center(child: Text('Cart Page')), // Placeholder
    Center(child: Text('Profile Page')), // Placeholder
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png',
              height: 32,
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.black),
              onPressed: () {},
            ),
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart, color: Colors.black),
                  onPressed: () {},
                ),
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      '2',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: MainPane(child: _pages[_selectedIndex]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

class MainPane extends StatelessWidget {
  final Widget child;
  const MainPane({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 🔍 Search Bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(Icons.search, color: Colors.grey),
              const SizedBox(width: 8),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search any Product...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.mic, color: Colors.grey),
                onPressed: () {},
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // 📦 Dynamic content
        Expanded(
          child: SingleChildScrollView(
            child: child,
          ),
        ),
      ],
    );
  }
}
