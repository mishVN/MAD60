class ShopItem {
  final String id;
  final String title;
  final String description;
  final String price;
  final String image;
  final String category;
  final List<String> features;
  final Map<String, String> nutritionalInfo;
  final bool inStock;
  final double rating;
  final int reviews;
  final String brand;
  final String weight;

  ShopItem({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
    required this.features,
    required this.nutritionalInfo,
    required this.inStock,
    required this.rating,
    required this.reviews,
    required this.brand,
    required this.weight,
  });
}
