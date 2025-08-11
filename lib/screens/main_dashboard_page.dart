import 'dart:async';
import 'package:flutter/material.dart';
import 'package:helapiya_mobile_app/models/productModel.dart';

class MainDashboard_Page extends StatefulWidget {
  const MainDashboard_Page({Key? key}) : super(key: key);

  @override
  State<MainDashboard_Page> createState() => _MainDashboard_PageState();
}

class _MainDashboard_PageState extends State<MainDashboard_Page> {
  final PageController _pageController = PageController();
  final List<String> bannerImages = [
    'assets/banner1.png',
    'assets/banner2.png',
  ];

  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < bannerImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🗂️ All Category
            _sectionTitle('All Category'),
            const SizedBox(height: 10),
            _iconRow([
              Icons.all_inbox,
              Icons.chair,
              Icons.devices,
              Icons.brush,
              Icons.checkroom,
            ]),
            const SizedBox(height: 24),

            // 🚚 Banner Carousel
            SizedBox(
              height: 220,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: bannerImages.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      bannerImages[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),


            // 🔥 Hot Deals
            _sectionTitle('Hot Deals'),
          _horizontalProductRow([
            ProductModel(
              name: 'Family Package 1',
              price: 'LKR 10,899/-',
              rating: 4.5,
              reviews: 2,
              isBestDeal: true,
              imagePath: 'assets/product/family_pack1.png',
            ),
            ProductModel(
              name: 'Bhoomi One Shot',
              price: 'LKR 360/-',
              rating: 5.0,
              reviews: 1,
              isBestDeal: true,
              imagePath: 'assets/product/oil_01.png',
            ),
            ProductModel(
              name: 'Helapiyasa T-Shirt',
              price: 'LKR 1,099/-',
              rating: 5.0,
              reviews: 1,
              imagePath: 'assets/product/fashion_01.png',
            ),
          ]),


          const SizedBox(height: 24),

            // 🏆 Top Categories
            _sectionTitle('Top Categories'),
          _horizontalProductRow([
            ProductModel(
              name: 'Family Package 1',
              price: 'LKR 10,899/-',
              rating: 4.5,
              reviews: 2,
              imagePath: 'assets/product/family_pack1.png',
            ),
            ProductModel(
              name: 'Bhoomi One Shot',
              price: 'LKR 360/-',
              rating: 5.0,
              reviews: 1,
              imagePath: 'assets/product/oil_01.png',
            ),
            ProductModel(
              name: 'Helapiyasa T-Shirt',
              price: 'LKR 1,099/-',
              rating: 5.0,
              reviews: 1,
              imagePath: 'assets/product/fashion_01.png',
            ),
          ]),

          const SizedBox(height: 24),

            // 📦 Packages
            _sectionTitle('Packages'),
          _horizontalProductRow([
            ProductModel(
              name: 'Family Package 1',
              price: 'LKR 10,899/-',
              rating: 4.5,
              reviews: 2,
              imagePath: 'assets/product/family_pack1.png',
            ),
            ProductModel(
              name: 'Bhoomi One Shot',
              price: 'LKR 360/-',
              rating: 5.0,
              reviews: 1,
              imagePath: 'assets/product/oil_01.png',
            ),
            ProductModel(
              name: 'Helapiyasa T-Shirt',
              price: 'LKR 1,099/-',
              rating: 5.0,
              reviews: 1,
              imagePath: 'assets/product/fashion_01.png',
            ),
          ]),

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
          _horizontalProductRow([
            ProductModel(
              name: 'Family Package 1',
              price: 'LKR 10,899/-',
              rating: 4.5,
              reviews: 2,
              imagePath: 'assets/product/family_pack1.png',
            ),
            ProductModel(
              name: 'Bhoomi One Shot',
              price: 'LKR 360/-',
              rating: 5.0,
              reviews: 1,
              imagePath: 'assets/product/oil_01.png',
            ),
            ProductModel(
              name: 'Helapiyasa T-Shirt',
              price: 'LKR 1,099/-',
              rating: 5.0,
              reviews: 1,
              imagePath: 'assets/product/fashion_01.png',
            ),
          ]),
            const SizedBox(height: 24),

            // 🏷️ Offers
            _sectionTitle('Offers'),
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
      children: icons.map((icon) {
        return Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.orange,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.black),
        );
      }).toList(),
    );
  }

  Widget _horizontalProductRow(List<ProductModel> products) {
    return SizedBox(
      height: 240,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final product = products[index];
          return Container(
            width: 164,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  spreadRadius: 1,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🖼️ Product Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    product.imagePath,
                    height: 136,
                    width: 164,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 8),

                // 🏷️ Product Name
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),

                // 💰 Price
                Text(
                  product.price,
                  style: const TextStyle(fontSize: 13, color: Colors.orange),
                ),

                // ⭐ Rating & Reviews
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 14),
                    const SizedBox(width: 4),
                    Text('${product.rating}', style: const TextStyle(fontSize: 12)),
                    const SizedBox(width: 6),
                    Text('(${product.reviews})', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                  ],
                ),

                // 🔖 Best Deal Badge
                if (product.isBestDeal)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Best Deal',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
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
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
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
