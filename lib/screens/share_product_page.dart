import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/productModel.dart';

class ShareProductPage extends StatelessWidget {
  final ProductModel product;

  const ShareProductPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Share Product',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Preview Card
              _buildProductPreview(),
              const SizedBox(height: 30),

              // Share Options Title
              const Text(
                'Share this product with:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),

              // Social Media Options
              _buildShareSection('Social Media', [
                _ShareOption(
                  icon: Icons.message,
                  label: 'WhatsApp',
                  color: const Color(0xFF25D366),
                  onTap: () => _shareToWhatsApp(context),
                ),
                _ShareOption(
                  icon: Icons.facebook,
                  label: 'Facebook',
                  color: const Color(0xFF1877F2),
                  onTap: () => _shareToFacebook(context),
                ),
                _ShareOption(
                  icon: Icons.alternate_email,
                  label: 'Twitter',
                  color: const Color(0xFF1DA1F2),
                  onTap: () => _shareToTwitter(context),
                ),
                _ShareOption(
                  icon: Icons.camera_alt,
                  label: 'Instagram',
                  color: const Color(0xFFE1306C),
                  onTap: () => _shareToInstagram(context),
                ),
              ]),

              const SizedBox(height: 25),

              // Additional Options
              _buildShareSection('More Options', [
                _ShareOption(
                  icon: Icons.link,
                  label: 'Copy Link',
                  color: const Color(0xFF9C27B0),
                  onTap: () => _copyLink(context),
                ),
                _ShareOption(
                  icon: Icons.bookmark,
                  label: 'Save for Later',
                  color: const Color(0xFFFF9800),
                  onTap: () => _saveForLater(context),
                ),
                _ShareOption(
                  icon: Icons.report,
                  label: 'Report Product',
                  color: const Color(0xFFF44336),
                  onTap: () => _reportProduct(context),
                ),
              ]),

              const SizedBox(height: 30),

              // Share Message Preview
              _buildSharePreview(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductPreview() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              product.imagePath,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image_not_supported),
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  product.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      product.formattedPrice,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (product.isBestDeal)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(4),
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShareSection(String title, List<_ShareOption> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: options.map((option) => _buildShareButton(option)).toList(),
        ),
      ],
    );
  }

  Widget _buildShareButton(_ShareOption option) {
    return GestureDetector(
      onTap: option.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: option.color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: option.color.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(
              option.icon,
              color: option.color,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                option.label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: option.color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSharePreview() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.preview, color: Colors.blue[700], size: 20),
              const SizedBox(width: 8),
              Text(
                'Share Message Preview',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            _getShareText(),
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  String _getShareText() {
    return '''🛍️ Check out this amazing product!

${product.name}
${product.description}

💰 Price: ${product.formattedPrice}
⭐ Rating: ${product.rating}/5 (${product.reviews} reviews)
🏷️ Category: ${product.category}
${product.isBestDeal ? '🔥 Best Deal!' : ''}

Shop now on Helapiyasa!
🔗 Download the app: [App Link]''';
  }

  void _shareToWhatsApp(BuildContext context) {
    _showShareSuccess(context, 'WhatsApp', '🟢 Shared to WhatsApp successfully!');
  }

  void _shareToFacebook(BuildContext context) {
    _showShareSuccess(context, 'Facebook', '🔵 Shared to Facebook successfully!');
  }

  void _shareToTwitter(BuildContext context) {
    _showShareSuccess(context, 'Twitter', '🐦 Shared to Twitter successfully!');
  }

  void _shareToInstagram(BuildContext context) {
    _showShareSuccess(context, 'Instagram', '📸 Shared to Instagram successfully!');
  }

  void _saveForLater(BuildContext context) {
    _showShareSuccess(context, 'Saved', '🔖 Product saved for later!');
  }

  void _reportProduct(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Report Product'),
          content: const Text('Why are you reporting this product?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showShareSuccess(context, 'Report', '⚠️ Product reported successfully!');
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Report'),
            ),
          ],
        );
      },
    );
  }

  void _copyLink(BuildContext context) {
    Clipboard.setData(ClipboardData(text: _getShareText()));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8),
            Text('Link copied to clipboard!'),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showShareSuccess(BuildContext context, String platform, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class _ShareOption {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  _ShareOption({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
}
