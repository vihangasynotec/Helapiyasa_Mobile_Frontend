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

  // Helper method to get responsive values
  double _getResponsiveValue(BuildContext context, {
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600) {
      return mobile;
    } else if (screenWidth < 1200) {
      return tablet;
    } else {
      return desktop;
    }
  }

  // Helper method to determine if screen is mobile
  bool _isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  // Helper method to determine if screen is tablet
  bool _isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 600 && width < 1200;
  }

  // Helper method to determine if screen is desktop
  bool _isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200;
  }

  // Get number of columns for grid based on screen size
  int _getCrossAxisCount(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600) {
      return 2; // Mobile: 2 columns
    } else if (screenWidth < 900) {
      return 3; // Small tablet: 3 columns
    } else if (screenWidth < 1200) {
      return 4; // Large tablet: 4 columns
    } else {
      return 5; // Desktop: 5 columns
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    // Responsive padding
    final horizontalPadding = _getResponsiveValue(
      context,
      mobile: 16.0,
      tablet: 24.0,
      desktop: 32.0,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🗂️ All Category
            _sectionTitle('All Category'),
            SizedBox(height: _getResponsiveValue(context, mobile: 10, tablet: 12, desktop: 16)),

            // Responsive category icons
            _isMobile(context)
              ? _iconRow([
                  Icons.all_inbox,
                  Icons.chair,
                  Icons.devices,
                  Icons.brush,
                  Icons.checkroom,
                ])
              : _iconGrid([
                  Icons.all_inbox,
                  Icons.chair,
                  Icons.devices,
                  Icons.brush,
                  Icons.checkroom,
                ]),

            SizedBox(height: _getResponsiveValue(context, mobile: 24, tablet: 28, desktop: 32)),

            // 🚚 Banner Carousel
            SizedBox(
              height: _getResponsiveValue(context, mobile: 220, tablet: 280, desktop: 350),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  _getResponsiveValue(context, mobile: 12, tablet: 16, desktop: 20)
                ),
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: bannerImages.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      bannerImages[index],
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: _getResponsiveValue(context, mobile: 24, tablet: 28, desktop: 32)),

            // 🔥 Hot Deals
            _sectionTitle('Hot Deals'),
            _responsiveProductSection([
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

            SizedBox(height: _getResponsiveValue(context, mobile: 24, tablet: 28, desktop: 32)),

            // 🏆 Top Categories
            _sectionTitle('Top Categories'),
            _responsiveProductSection([
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

            SizedBox(height: _getResponsiveValue(context, mobile: 24, tablet: 28, desktop: 32)),

            // 📦 Packages
            _sectionTitle('Packages'),
            _responsiveProductSection([
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

            SizedBox(height: _getResponsiveValue(context, mobile: 24, tablet: 28, desktop: 32)),

            // 🆕 New Arrivals
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _sectionTitle('New Arrivals'),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'View All',
                    style: TextStyle(
                      fontSize: _getResponsiveValue(context, mobile: 14, tablet: 16, desktop: 18),
                    ),
                  ),
                ),
              ],
            ),
            _responsiveProductSection([
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

            SizedBox(height: _getResponsiveValue(context, mobile: 24, tablet: 28, desktop: 32)),


            // 🛍️ Shop By Brands
            _sectionTitle('Shop By Brands'),
            SizedBox(height: _getResponsiveValue(context, mobile: 16, tablet: 20, desktop: 24)),
            _responsiveBrandSection(),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: _getResponsiveValue(context, mobile: 18, tablet: 22, desktop: 26),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _iconRow(List<IconData> icons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: icons.map((icon) {
        return Container(
          padding: EdgeInsets.all(_getResponsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.white,
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
          child: Icon(
            icon,
            color: Colors.orange,
            size: _getResponsiveValue(context, mobile: 24, tablet: 28, desktop: 32),
          ),
        );
      }).toList(),
    );
  }

  // Grid layout for tablets and desktops
  Widget _iconGrid(List<IconData> icons) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _getCrossAxisCount(context),
        crossAxisSpacing: _getResponsiveValue(context, mobile: 12, tablet: 16, desktop: 20),
        mainAxisSpacing: _getResponsiveValue(context, mobile: 12, tablet: 16, desktop: 20),
        childAspectRatio: 1.0,
      ),
      itemCount: icons.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(_getResponsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.white,
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
          child: Icon(
            icons[index],
            color: Colors.orange,
            size: _getResponsiveValue(context, mobile: 24, tablet: 28, desktop: 32),
          ),
        );
      },
    );
  }

  // Responsive product section
  Widget _responsiveProductSection(List<ProductModel> products) {
    if (_isMobile(context)) {
      return _horizontalProductRow(products);
    } else {
      return _productGrid(products);
    }
  }

  Widget _horizontalProductRow(List<ProductModel> products) {
    final cardWidth = _getResponsiveValue(context, mobile: 164, tablet: 200, desktop: 240);
    final cardHeight = _getResponsiveValue(context, mobile: 240, tablet: 280, desktop: 320);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_getResponsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SizedBox(
        height: cardHeight,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          separatorBuilder: (_, __) => SizedBox(width: _getResponsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
          itemBuilder: (context, index) {
            final product = products[index];
            return _buildProductCard(product, cardWidth);
          },
        ),
      ),
    );
  }

  // Grid layout for tablets and desktops
  Widget _productGrid(List<ProductModel> products) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _getCrossAxisCount(context),
        crossAxisSpacing: _getResponsiveValue(context, mobile: 12, tablet: 16, desktop: 20),
        mainAxisSpacing: _getResponsiveValue(context, mobile: 12, tablet: 16, desktop: 20),
        childAspectRatio: _getResponsiveValue(context, mobile: 0.75, tablet: 0.8, desktop: 0.85),
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return _buildProductCard(product, null);
      },
    );
  }

  Widget _buildProductCard(ProductModel product, double? width) {
     final imageHeight = _getResponsiveValue(context, mobile: 136, tablet: 160, desktop: 180);

    return Container(
      width: width,
      padding: EdgeInsets.all(_getResponsiveValue(context, mobile: 8, tablet: 12, desktop: 16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_getResponsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
        // Removed card drop shadow
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🖼️ Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(_getResponsiveValue(context, mobile: 8, tablet: 12, desktop: 16)),
            child: Image.asset(
              product.imagePath,
              height: imageHeight,
              width: width ?? _getResponsiveValue(context, mobile: 148, tablet: 180, desktop: 220), // Fixed: Use finite width instead of double.infinity
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: _getResponsiveValue(context, mobile: 8, tablet: 10, desktop: 12)),

          // 🏷️ Product Name
          Text(
            product.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: _getResponsiveValue(context, mobile: 14, tablet: 16, desktop: 18),
              fontWeight: FontWeight.w600,
            ),
          ),

          // 💰 Price
          Text(
            product.price,
            style: TextStyle(
              fontSize: _getResponsiveValue(context, mobile: 13, tablet: 15, desktop: 17),
              color: Colors.orange,
            ),
          ),

          // ⭐ Rating & Reviews
          Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.amber,
                size: _getResponsiveValue(context, mobile: 14, tablet: 16, desktop: 18),
              ),
              SizedBox(width: _getResponsiveValue(context, mobile: 4, tablet: 6, desktop: 8)),
              Text(
                '${product.rating}',
                style: TextStyle(
                  fontSize: _getResponsiveValue(context, mobile: 12, tablet: 14, desktop: 16),
                ),
              ),
              SizedBox(width: _getResponsiveValue(context, mobile: 6, tablet: 8, desktop: 10)),
              Text(
                '(${product.reviews})',
                style: TextStyle(
                  fontSize: _getResponsiveValue(context, mobile: 11, tablet: 13, desktop: 15),
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          // 🔖 Best Deal Badge
          if (product.isBestDeal)
            Container(
              margin: EdgeInsets.only(top: _getResponsiveValue(context, mobile: 4, tablet: 6, desktop: 8)),
              padding: EdgeInsets.symmetric(
                horizontal: _getResponsiveValue(context, mobile: 6, tablet: 8, desktop: 10),
                vertical: _getResponsiveValue(context, mobile: 2, tablet: 4, desktop: 6),
              ),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Best Deal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: _getResponsiveValue(context, mobile: 10, tablet: 12, desktop: 14),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _responsiveBrandSection() {
    final brandImages = [
      'assets/brands/brand1.png',
      'assets/brands/brand2.png',
      'assets/brands/brand3.png',
      'assets/brands/brand4.png',
      'assets/brands/brand5.png',
      'assets/brands/brand6.png',
    ];

    // Always use horizontal carousel for all screen sizes
    return SizedBox(
      height: _getResponsiveValue(context, mobile: 56, tablet: 56, desktop: 56),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: brandImages.length,
        separatorBuilder: (_, __) => SizedBox(width: _getResponsiveValue(context, mobile: 8, tablet: 12, desktop: 16)),
        itemBuilder: (context, index) {
          return _brandLogo(brandImages[index]);
        },
      ),
    );
  }

  Widget _brandLogo(String assetPath) {
    return Container(
      width: _getResponsiveValue(context, mobile: 145, tablet: 145, desktop: 145),
      height: _getResponsiveValue(context, mobile: 56, tablet: 56, desktop: 56),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_getResponsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_getResponsiveValue(context, mobile: 12, tablet: 16, desktop: 20)),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: _getResponsiveValue(context, mobile: 8, tablet: 12, desktop: 16),
            vertical: _getResponsiveValue(context, mobile: 8, tablet: 8, desktop: 8),
          ),
          child: Image.asset(
            assetPath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
