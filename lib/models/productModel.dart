class ProductModel {
  final String name;
  final String price;
  final double rating;
  final int reviews;
  final bool isBestDeal;
  final String imagePath;

  ProductModel({
    required this.name,
    required this.price,
    required this.rating,
    required this.reviews,
    required this.imagePath,
    this.isBestDeal = false,
  });
}
