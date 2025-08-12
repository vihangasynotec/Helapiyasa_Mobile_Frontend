import 'package:flutter/material.dart';
import '../models/productModel.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onTap;

  const ProductCard({
    Key? key,
    required this.product,
    this.onTap,
  }) : super(key: key);

  static const BorderRadius cardRadius = BorderRadius.all(Radius.circular(12));
  static const BorderRadius badgeRadius = BorderRadius.all(Radius.circular(8));

  static const TextStyle titleStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 14,
    overflow: TextOverflow.ellipsis,
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 12,
    color: Colors.grey,
    overflow: TextOverflow.ellipsis,
  );

  static const TextStyle priceStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.orange,
  );

  static const TextStyle badgeStyle = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle reviewStyle = TextStyle(
    fontSize: 10,
    color: Colors.grey,
  );

  static const Color ratingColor = Colors.orange;
  static const Color bestDealColor = Colors.orange;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: cardRadius),
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
                          alignment: Alignment.center,
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
                          color: bestDealColor,
                          borderRadius: badgeRadius,
                        ),
                        child: const Text('Best Deal', style: badgeStyle),
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
                  Text(product.name, style: titleStyle, maxLines: 1),
                  const SizedBox(height: 2),
                  Text(product.description, style: subtitleStyle, maxLines: 2),
                  const SizedBox(height: 4),
                  Text(product.formattedPrice, style: priceStyle),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      ...List.generate(5, (i) {
                        return Icon(
                          i < product.rating.floor() ? Icons.star : Icons.star_border,
                          color: ratingColor,
                          size: 14,
                        );
                      }),
                      const SizedBox(width: 4),
                      Text('(${product.reviews})', style: reviewStyle),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
