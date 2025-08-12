import 'package:flutter/material.dart';
import '../models/productModel.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  static const double screenPadding = 12.0;

  List<ProductModel> filteredProducts = sampleProducts;
  String selectedCategory = 'All';
  double minPrice = 0;
  double maxPrice = 20000;
  double selectedRating = 0;
  bool showBestDealsOnly = false;
  String sortBy = 'None'; // Added sort option

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Filter Products',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              content: SizedBox(
                width: double.maxFinite,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Sort By Section
                      const Text(
                        'Sort By',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: ['None', 'Price: Low to High', 'Price: High to Low']
                            .map((sort) => FilterChip(
                                  label: Text(sort),
                                  selected: sortBy == sort,
                                  onSelected: (selected) {
                                    setStateDialog(() {
                                      sortBy = sort;
                                    });
                                  },
                                  selectedColor: Colors.orange.withOpacity(0.3),
                                  checkmarkColor: Colors.orange,
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 20),

                      // Category Filter
                      const Text(
                        'Category',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: ['All', 'Fashion', 'Electronics', 'Food', 'Cosmetics', 'Packages', 'Home']
                            .map((category) => FilterChip(
                                  label: Text(category),
                                  selected: selectedCategory == category,
                                  onSelected: (selected) {
                                    setStateDialog(() {
                                      selectedCategory = category;
                                    });
                                  },
                                  selectedColor: Colors.orange.withOpacity(0.3),
                                  checkmarkColor: Colors.orange,
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 20),

                      // Price Range Filter
                      const Text(
                        'Price Range',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('LKR ${minPrice.toInt()} - LKR ${maxPrice.toInt()}'),
                      RangeSlider(
                        values: RangeValues(minPrice, maxPrice),
                        min: 0,
                        max: 20000,
                        divisions: 20,
                        activeColor: Colors.orange,
                        inactiveColor: Colors.orange.withOpacity(0.3),
                        onChanged: (RangeValues values) {
                          setStateDialog(() {
                            minPrice = values.start;
                            maxPrice = values.end;
                          });
                        },
                      ),
                      const SizedBox(height: 20),

                      // Rating Filter
                      const Text(
                        'Minimum Rating',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Slider(
                              value: selectedRating,
                              min: 0,
                              max: 5,
                              divisions: 5,
                              activeColor: Colors.orange,
                              inactiveColor: Colors.orange.withOpacity(0.3),
                              onChanged: (value) {
                                setStateDialog(() {
                                  selectedRating = value;
                                });
                              },
                            ),
                          ),
                          Text('${selectedRating.toInt()}+ ⭐'),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Best Deals Filter
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Show Best Deals Only',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Switch(
                            value: showBestDealsOnly,
                            activeColor: Colors.orange,
                            onChanged: (value) {
                              setStateDialog(() {
                                showBestDealsOnly = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setStateDialog(() {
                      selectedCategory = 'All';
                      minPrice = 0;
                      maxPrice = 20000;
                      selectedRating = 0;
                      showBestDealsOnly = false;
                      sortBy = 'None'; // Reset sort
                    });
                  },
                  child: const Text(
                    'Clear All',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _applyFilters();
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Apply Filters'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _applyFilters() {
    setState(() {
      // First filter the products
      filteredProducts = sampleProducts.where((product) {
        // Category filter
        if (selectedCategory != 'All' && product.category != selectedCategory) {
          return false;
        }

        // Price filter
        if (product.price < minPrice || product.price > maxPrice) {
          return false;
        }

        // Rating filter
        if (product.rating < selectedRating) {
          return false;
        }

        // Best deals filter
        if (showBestDealsOnly && !product.isBestDeal) {
          return false;
        }

        return true;
      }).toList();

      // Then sort the filtered products
      if (sortBy == 'Price: Low to High') {
        filteredProducts.sort((a, b) => a.price.compareTo(b.price));
      } else if (sortBy == 'Price: High to Low') {
        filteredProducts.sort((a, b) => b.price.compareTo(a.price));
      }
      // If sortBy is 'None', keep original order
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shop',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter Summary
          if (selectedCategory != 'All' ||
              minPrice > 0 ||
              maxPrice < 20000 ||
              selectedRating > 0 ||
              showBestDealsOnly)
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.orange.withOpacity(0.1),
              child: Row(
                children: [
                  const Icon(Icons.filter_alt, color: Colors.orange, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Filters applied: ${_getFilterSummary()}',
                      style: const TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        selectedCategory = 'All';
                        minPrice = 0;
                        maxPrice = 20000;
                        selectedRating = 0;
                        showBestDealsOnly = false;
                        filteredProducts = sampleProducts;
                      });
                    },
                    child: const Text(
                      'Clear',
                      style: TextStyle(color: Colors.orange),
                    ),
                  ),
                ],
              ),
            ),

          // Products Count
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              '${filteredProducts.length} Products Found',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ),

          // Products Grid
          Expanded(
            child: filteredProducts.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No products found',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Try adjusting your filters',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(screenPadding),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.68,
                      crossAxisSpacing: screenPadding,
                      mainAxisSpacing: screenPadding,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return _buildProductCard(product);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  String _getFilterSummary() {
    List<String> filters = [];

    if (selectedCategory != 'All') filters.add(selectedCategory);
    if (minPrice > 0 || maxPrice < 20000) filters.add('Price');
    if (selectedRating > 0) filters.add('Rating ${selectedRating.toInt()}+');
    if (showBestDealsOnly) filters.add('Best Deals');

    return filters.join(', ');
  }

  Widget _buildProductCard(ProductModel product) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    product.imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: const Icon(Icons.image_not_supported, color: Colors.grey),
                      );
                    },
                  ),
                ),
                if (product.isBestDeal)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(8),
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
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  product.description,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  product.formattedPrice,
                  style: const TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Row(
                  children: [
                    ...List.generate(5, (i) {
                      return Icon(
                        i < product.rating.floor() ? Icons.star : Icons.star_border,
                        color: Colors.orange,
                        size: 14,
                      );
                    }),
                    const SizedBox(width: 4),
                    Text(
                      '(${product.reviews})',
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
