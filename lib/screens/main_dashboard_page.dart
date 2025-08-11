import 'package:flutter/material.dart';

class MainDashboard_Page extends StatelessWidget {
  const MainDashboard_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Online Shopping',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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

            // 🚚 Banner
            Container(
              height: 140,
              decoration: BoxDecoration(
                color: Colors.orange[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'Online Shopping Banner',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // 🗂️ All Category
            _sectionTitle('All Category'),
            _iconRow([
              Icons.local_grocery_store,
              Icons.chair,
              Icons.devices,
              Icons.brush,
              Icons.checkroom,
            ]),
            const SizedBox(height: 24),

            // 🔥 Hot Deals
            _sectionTitle('Hot Deals'),
            _productRow('Family Package 7', 'LKR 11,890.00'),
            _productRow('Bronze Drive Deal', 'LKR 1,095.00'),
            const SizedBox(height: 24),

            // 🏆 Top Categories
            _sectionTitle('Top Categories'),
            _productRow('Family Package 7', 'LKR 11,890.00'),
            _productRow('Interactive T-Shirt', 'LKR 1,095.00'),
            const SizedBox(height: 24),

            // 📦 Packages
            _sectionTitle('Packages'),
            _productRow('Family Package 7', 'LKR 11,890.00'),
            _productRow('Bronze Drive Deal', 'LKR 1,095.00'),
            const SizedBox(height: 24),

            // 🆕 New Arrivals
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _sectionTitle('New Arrivals'),
                TextButton(
                  onPressed: () {},
                  child: const Text('View All'),
                ),
              ],
            ),
            _productRow('Summer & Gadgets', 'Explore Now'),
            const SizedBox(height: 24),

            // 🛍️ Shop By Brands
            _sectionTitle('Shop By Brands'),
            Row(
              children: [
                _brandLogo('Viva'),
                const SizedBox(width: 16),
                _brandLogo('Angel'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _iconRow(List<IconData> icons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: icons
          .map((icon) => CircleAvatar(
        radius: 24,
        backgroundColor: Colors.white,
        child: Icon(icon, color: Colors.orange),
      ))
          .toList(),
    );
  }

  Widget _productRow(String name, String price) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.orange[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.shopping_bag, color: Colors.orange),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Text(
            price,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _brandLogo(String name) {
    return Expanded(
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
