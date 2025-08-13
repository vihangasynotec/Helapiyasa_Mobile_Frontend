import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:helapiya_mobile_app/models/productModel.dart';
import 'product_detail_page.dart';

class MainDashboard_Page extends StatefulWidget {
  const MainDashboard_Page({Key? key}) : super(key: key);

  @override
  State<MainDashboard_Page> createState() => _MainDashboard_PageState();
}

class _MainDashboard_PageState extends State<MainDashboard_Page> {
  final PageController _pageController = PageController();
  final TextEditingController _searchController = TextEditingController();
  final List<String> bannerImages = [
    'assets/banner1.png',
    'assets/banner2.png',
  ];

  int _currentPage = 0;
  Timer? _timer;
  Timer? _hotDealsTimer;
  String _searchQuery = '';

  // Category data with items
  final List<Map<String, dynamic>> _categories = [
    {
      'id': 1,
      'name': 'Electronics',
      'icon': 'assets/category/ca_icon1.png',
      'color': Colors.blue,
      'items': ['Smartphones', 'Laptops', 'Headphones', 'Cameras', 'Smart Watch', 'Tablets']
    },
    {
      'id': 2,
      'name': 'Fashion',
      'icon': 'assets/category/ca_icon2.png',
      'color': Colors.pink,
      'items': ['Men\'s Clothing', 'Women\'s Clothing', 'Shoes', 'Bags', 'Accessories', 'Jewelry']
    },
    {
      'id': 3,
      'name': 'Beauty',
      'icon': 'assets/category/ca_icon3.png',
      'color': Colors.purple,
      'items': ['Skincare', 'Makeup', 'Hair Care', 'Perfumes', 'Body Care', 'Nail Care']
    },
    {
      'id': 4,
      'name': 'Home & Living',
      'icon': 'assets/category/ca_icon4.png',
      'color': Colors.green,
      'items': ['Furniture', 'Kitchen', 'Bedding', 'Decor', 'Storage', 'Lighting']
    },
    {
      'id': 5,
      'name': 'Food & Grocery',
      'icon': 'assets/category/ca_icon5.png',
      'color': Colors.orange,
      'items': ['Fresh Produce', 'Dairy', 'Beverages', 'Snacks', 'Cooking Oil', 'Spices']
    },
    {
      'id': 6,
      'name': 'Sports & Fitness',
      'icon': 'assets/category/ca_icon6.png',
      'color': Colors.red,
      'items': ['Gym Equipment', 'Sports Wear', 'Outdoor Gear', 'Yoga & Fitness', 'Team Sports', 'Swimming']
    },
  ];

  // Hot deals countdown timer (24 hours from now)
  DateTime _hotDealsEndTime = DateTime.now().add(const Duration(hours: 24));
  String _timeRemaining = '02:11:40'; // Initial time remaining

  // Get filtered categories based on search query
  List<Map<String, dynamic>> get _filteredCategories {
    if (_searchQuery.isEmpty) {
      return _categories;
    }
    return _categories.where((category) {
      final categoryName = category['name'].toString().toLowerCase();
      final items = category['items'] as List<String>;
      final itemsMatch = items.any((item) => item.toLowerCase().contains(_searchQuery.toLowerCase()));
      return categoryName.contains(_searchQuery.toLowerCase()) || itemsMatch;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
    _startHotDealsTimer(); // Start the hot deals countdown
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

  void _startHotDealsTimer() {
    _updateHotDealsTimer(); // Initial update
    _hotDealsTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      _updateHotDealsTimer();
    });
  }

  void _updateHotDealsTimer() {
    final now = DateTime.now();
    final difference = _hotDealsEndTime.difference(now);

    if (difference.isNegative) {
      // Timer expired, reset for next 24 hours
      _hotDealsEndTime = DateTime.now().add(const Duration(hours: 24));
      return;
    }

    final hours = difference.inHours;
    final minutes = difference.inMinutes % 60;
    final seconds = difference.inSeconds % 60;

    setState(() {
      _timeRemaining = '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _hotDealsTimer?.cancel(); // Cancel hot deals timer
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

    // Mobile-focused responsive padding
    final horizontalPadding = screenWidth < 360 ? 12.0 : 16.0; // Small phones vs regular phones

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🗂️ All Category
            _sectionTitle('All Category'),
            SizedBox(height: screenWidth < 360 ? 8 : 10),

            // Mobile-only category icons (removed duplicates)
            _iconRow([
              Icons.all_inbox,
              Icons.chair,
              Icons.devices,
              Icons.brush,
              Icons.checkroom,
              Icons.vaccines,
              Icons.local_drink,
              Icons.health_and_safety,
              Icons.bathroom,
            ]),

            SizedBox(height: screenWidth < 360 ? 20 : 24),

            // 🚚 Banner Carousel
            SizedBox(
              height: screenWidth < 360 ? 180 : 220, // Smaller for small phones
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
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
            SizedBox(height: screenWidth < 360 ? 20 : 24),

            // Hot Deals Countdown Timer
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hurry Up! Hot Deals Ending In:',
                    style: TextStyle(
                      fontSize: screenWidth < 360 ? 14 : 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth < 360 ? 8 : 12,
                      vertical: screenWidth < 360 ? 4 : 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 6,
                          spreadRadius: 1,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      _timeRemaining,
                      style: TextStyle(
                        fontSize: screenWidth < 360 ? 14 : 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),


            // 🔥 Hot Deals
            _sectionTitle('Hot Deals'),
            _mobileProductSection([
              ProductModel(
                id: 'hd1',
                name: 'Family Package 1',
                description: 'Complete family package deal',
                price: 10899,
                rating: 4.5,
                reviews: 2,
                isBestDeal: true,
                imagePath: 'assets/product/family_pack1.png',
                category: 'Packages',
              ),
              ProductModel(
                id: 'hd2',
                name: 'Bhoomi One Shot',
                description: 'Premium cooking oil',
                price: 360,
                rating: 5.0,
                reviews: 1,
                isBestDeal: true,
                imagePath: 'assets/product/oil_01.png',
                category: 'Food',
              ),
              ProductModel(
                id: 'hd3',
                name: 'Helapiyasa T-Shirt',
                description: 'Comfortable cotton t-shirt',
                price: 1099,
                rating: 5.0,
                reviews: 1,
                imagePath: 'assets/product/fashion_01.png',
                category: 'Fashion',
              ),
              ProductModel(
                id: 'hd4',
                name: 'Family Package 2',
                description: 'Extended family package',
                price: 8999,
                rating: 4.8,
                reviews: 5,
                isBestDeal: true,
                imagePath: 'assets/product/family_pack1.png',
                category: 'Packages',
              ),
              ProductModel(
                id: 'hd5',
                name: 'Natural Oil',
                description: 'Pure natural cooking oil',
                price: 450,
                rating: 4.9,
                reviews: 3,
                isBestDeal: true,
                imagePath: 'assets/product/oil_01.png',
                category: 'Food',
              ),
            ]),



            SizedBox(height: screenWidth < 360 ? 20 : 24),

            // 🏆 Top Categories
            _sectionTitle('Top Categories'),
            _mobileProductSection([
              ProductModel(
                id: 'tc1',
                name: 'Electronics Hub',
                description: 'Latest electronic gadgets',
                price: 15500,
                rating: 4.7,
                reviews: 8,
                imagePath: 'assets/product/electronic_01.png',
                category: 'Electronics',
              ),
              ProductModel(
                id: 'tc2',
                name: 'Fashion Collection',
                description: 'Trendy fashion items',
                price: 2299,
                rating: 4.6,
                reviews: 12,
                imagePath: 'assets/product/fashion_02.png',
                category: 'Fashion',
              ),
              ProductModel(
                id: 'tc3',
                name: 'Beauty Pack',
                description: 'Complete beauty solution',
                price: 3899,
                rating: 4.9,
                reviews: 6,
                imagePath: 'assets/product/cosmatic_01.png',
                category: 'Cosmetics',
              ),
              ProductModel(
                id: 'tc4',
                name: 'Home Essentials',
                description: 'Essential home products',
                price: 5499,
                rating: 4.5,
                reviews: 4,
                imagePath: 'assets/product/family_pack1.png',
                category: 'Home',
              ),
            ]),

            SizedBox(height: screenWidth < 360 ? 20 : 24),

            // 📦 Packages
            _sectionTitle('Packages'),
            _mobileProductSection([
              ProductModel(
                id: 'pkg1',
                name: 'Starter Package',
                description: 'Perfect starter package',
                price: 4999,
                rating: 4.3,
                reviews: 15,
                imagePath: 'assets/product/family_pack1.png',
                category: 'Packages',
              ),
              ProductModel(
                id: 'pkg2',
                name: 'Premium Oil Set',
                description: 'Premium cooking oil collection',
                price: 899,
                rating: 4.8,
                reviews: 9,
                imagePath: 'assets/product/oil_02.png',
                category: 'Food',
              ),
              ProductModel(
                id: 'pkg3',
                name: 'Fashion Bundle',
                description: 'Complete fashion bundle',
                price: 1799,
                rating: 4.7,
                reviews: 7,
                imagePath: 'assets/product/fashion_03.png',
                category: 'Fashion',
              ),
              ProductModel(
                id: 'pkg4',
                name: 'Complete Set',
                description: 'Everything you need package',
                price: 12999,
                rating: 4.9,
                reviews: 11,
                imagePath: 'assets/product/family_pack1.png',
                category: 'Packages',
              ),
            ]),

            SizedBox(height: screenWidth < 360 ? 20 : 24),

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
                      fontSize: screenWidth < 360 ? 12 : 14,
                      color: Colors.orange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            _mobileProductSection([
              ProductModel(
                id: 'na1',
                name: 'Latest Fashion',
                description: 'Brand new fashion item',
                price: 1299,
                rating: 4.8,
                reviews: 3,
                imagePath: 'assets/product/fashion_04.png',
                category: 'Fashion',
              ),
              ProductModel(
                id: 'na2',
                name: 'New Electronics',
                description: 'Latest electronic device',
                price: 8500,
                rating: 4.6,
                reviews: 2,
                imagePath: 'assets/product/electronic_02.png',
                category: 'Electronics',
              ),
              ProductModel(
                id: 'na3',
                name: 'Fresh Cosmetics',
                description: 'New cosmetic products',
                price: 2199,
                rating: 4.9,
                reviews: 1,
                imagePath: 'assets/product/cosmatic_02.png',
                category: 'Cosmetics',
              ),
            ]),

            SizedBox(height: screenWidth < 360 ? 20 : 24),

            // 🛍️ Shop By Brands
            _sectionTitle('Shop By Brands'),
            SizedBox(height: screenWidth < 360 ? 12 : 16),
            _mobileBrandSection(),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth < 360 ? 8 : 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: screenWidth < 360 ? 16 : 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _iconRow(List<IconData> icons) {
    final screenWidth = MediaQuery.of(context).size.width;
    final iconSize = screenWidth < 360 ? 20.0 : 24.0;
    final containerSize = screenWidth < 360 ? 56.0 : 64.0;
    final paddingSize = screenWidth < 360 ? 8.0 : 10.0;

    return SizedBox(
      height: containerSize + 10, // Extra space for better visual
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: screenWidth < 360 ? 8 : 12),
        itemCount: icons.length,
        separatorBuilder: (_, __) => SizedBox(width: screenWidth < 360 ? 12 : 16),
        physics: const BouncingScrollPhysics(), // Better scroll feeling
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Add onTap functionality here if needed
              print('Category ${index + 1} tapped');
            },
            child: Container(
              width: containerSize,
              height: containerSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 6,
                    spreadRadius: 1,
                    offset: const Offset(0, 3),
                  ),
                ],
                border: Border.all(
                  color: Colors.orange.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Center(
                child: Icon(
                  icons[index],
                  color: Colors.orange,
                  size: iconSize,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Mobile-optimized product section
  Widget _mobileProductSection(List<ProductModel> products) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth < 360 ? 140.0 : 164.0;
    final cardHeight = screenWidth < 360 ? 200.0 : 240.0;

    return Container(
      margin: EdgeInsets.only(top: screenWidth < 360 ? 8 : 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SizedBox(
        height: cardHeight,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: screenWidth < 360 ? 8 : 12),
          itemCount: products.length,
          separatorBuilder: (_, __) => SizedBox(width: screenWidth < 360 ? 8 : 12),
          itemBuilder: (context, index) {
            return _buildMobileProductCard(products[index], cardWidth);
          },
        ),
      ),
    );
  }

  Widget _buildMobileProductCard(ProductModel product, double width) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageHeight = screenWidth < 360 ? 100.0 : 136.0;
    final padding = screenWidth < 360 ? 6.0 : 8.0;

    // Calculate discount percentage for hot deals
    double? discountPercentage;
    if (product.isBestDeal) {
      // Sample discount calculation - you can customize this logic
      switch (product.id) {
        case 'hd1': // Family Package 1
          discountPercentage = 25.0; // 25% off
          break;
        case 'hd2': // Bhoomi One Shot
          discountPercentage = 15.0; // 15% off
          break;
        case 'hd3': // Helapiyasa T-Shirt
          discountPercentage = 30.0; // 30% off
          break;
        case 'hd4': // Family Package 2
          discountPercentage = 20.0; // 20% off
          break;
        case 'hd5': // Natural Oil
          discountPercentage = 40.0; // 40% off
          break;
        default:
          discountPercentage = 20.0; // Default discount for other best deals
      }
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: product),
          ),
        );
      },
      child: Container(
        width: width,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🖼️ Product Image with Discount Badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    product.imagePath,
                    height: imageHeight,
                    width: width - (padding * 2),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: imageHeight,
                        width: width - (padding * 2),
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.grey[400],
                          size: screenWidth < 360 ? 30 : 40,
                        ),
                      );
                    },
                  ),
                ),

                // Discount Percentage Badge
                if (discountPercentage != null)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth < 360 ? 6 : 8,
                        vertical: screenWidth < 360 ? 2 : 4,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.red, Colors.red.shade600],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.local_offer,
                            color: Colors.white,
                            size: screenWidth < 360 ? 10 : 12,
                          ),
                          SizedBox(width: 2),
                          Text(
                            '${discountPercentage.toInt()}% OFF',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth < 360 ? 8 : 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // Best Deal Badge (moved to top-right)
                if (product.isBestDeal)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth < 360 ? 4 : 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.orange.withOpacity(0.3),
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Text(
                        'HOT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth < 360 ? 7 : 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: screenWidth < 360 ? 6 : 8),

            // 🏷️ Product Name
            Text(
              product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: screenWidth < 360 ? 12 : 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),

            // 💰 Price with Discount
            Row(
              children: [
                Text(
                  product.formattedPrice,
                  style: TextStyle(
                    fontSize: screenWidth < 360 ? 11 : 13,
                    color: Colors.orange,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (discountPercentage != null) ...[
                  SizedBox(width: 4),
                  Text(
                    'LKR ${(product.price / (1 - discountPercentage / 100)).toInt()}/-',
                    style: TextStyle(
                      fontSize: screenWidth < 360 ? 9 : 11,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ],
            ),

            // ⭐ Rating & Reviews
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: screenWidth < 360 ? 12 : 14,
                ),
                SizedBox(width: 2),
                Text(
                  '${product.rating}',
                  style: TextStyle(
                    fontSize: screenWidth < 360 ? 10 : 12,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(width: 4),
                Text(
                  '(${product.reviews})',
                  style: TextStyle(
                    fontSize: screenWidth < 360 ? 9 : 11,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _mobileBrandSection() {
    final screenWidth = MediaQuery.of(context).size.width;
    final brandImages = [
      'assets/brands/brand1.png',
      'assets/brands/brand2.png',
      'assets/brands/brand3.png',
      'assets/brands/brand4.png',
      'assets/brands/brand5.png',
      'assets/brands/brand6.png',
    ];

    return SizedBox(
      height: screenWidth < 360 ? 45 : 56,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: brandImages.length,
        separatorBuilder: (_, __) => SizedBox(width: screenWidth < 360 ? 6 : 8),
        itemBuilder: (context, index) {
          return _mobileBrandLogo(brandImages[index]);
        },
      ),
    );
  }

  Widget _mobileBrandLogo(String assetPath) {
    final screenWidth = MediaQuery.of(context).size.width;
    final logoWidth = screenWidth < 360 ? 120.0 : 145.0;
    final logoHeight = screenWidth < 360 ? 45.0 : 56.0;

    return Container(
      width: logoWidth,
      height: logoHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth < 360 ? 6 : 8,
            vertical: screenWidth < 360 ? 6 : 8,
          ),
          child: Image.asset(
            assetPath,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[100],
                child: Icon(
                  Icons.image_not_supported,
                  color: Colors.grey[400],
                  size: screenWidth < 360 ? 20 : 24,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showCategoryDetails(Map<String, dynamic> category) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: (category['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        category['icon'],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.category,
                            color: category['color'] as Color,
                            size: 30,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category['name'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          '${(category['items'] as List<String>).length} items available',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.grey),
                  ),
                ],
              ),
            ),

            // Items Grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 3,
                ),
                itemCount: (category['items'] as List<String>).length,
                itemBuilder: (context, index) {
                  final item = (category['items'] as List<String>)[index];
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: (category['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: (category['color'] as Color).withOpacity(0.3),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: category['color'] as Color,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
